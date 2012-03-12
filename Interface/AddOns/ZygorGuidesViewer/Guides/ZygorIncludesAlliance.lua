if UnitFactionGroup("player")~="Alliance" then return end
local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if ZGV:DoMutex("IncludesA") then return end


--------------------------------------------------------------------------------------------------------------------------------------
-- Hearth
--------------------------------------------------------------------------------------------------------------------------------------

ZygorGuidesViewer:RegisterInclude("innkeeper_dwarven",[[
		goto Stormwind,64.9,31.9
		.talk Thaegra Tillstone##44235
]])

ZygorGuidesViewer:RegisterInclude("home_TradeDistrict",[[
		goto Stormwind City,60.4,75.3
		.talk Innkeeper Allison##6740
		.home Trade District
]])

ZygorGuidesViewer:RegisterInclude("home_DwarvenDistrict",[[
		goto Stormwind City,64.9,31.9
		.talk Thaegra Tillstone##44235
		.home Dwarven District
]])

ZygorGuidesViewer:RegisterInclude("home_OldTown",[[
		goto Stormwind City,75.7,54.1
		.talk Maegan Tillman##44237
		.home Old Town
]])

ZygorGuidesViewer:RegisterInclude("hearth_hub",[[
		'Hearth to the Trade District |goto Stormwind City |use Hearthstone##6948 |noway |c
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
--------------------------------------------------------------------------------------------------------------------------------------
-- Portals
--------------------------------------------------------------------------------------------------------------------------------------

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

ZygorGuidesViewer:RegisterInclude("uldum_port",[[
		goto Stormwind City 75.2,20.5 |n
		.' Click the Portal to Uldum. |goto Uldum|noway|c
]])

--------------------------------------------------------------------------------------------------------------------------------------
-- Boats
--------------------------------------------------------------------------------------------------------------------------------------

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

ZygorGuidesViewer:RegisterInclude("rideto_darnassus",[[
		goto Stormwind City,22.6,56.0 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
	step
		 goto Teldrassil,55.1,88.3 |n
		 .' Go through the Pink portal to Darnassus |goto Darnassus |noway |c
]])

ZygorGuidesViewer:RegisterInclude("rideto_theramoreisle",[[
		|fly Menethil Harbor
	step
		goto Wetlands,6.5,62.1 |n
		.' Ride the boat to Theramore Isle, Dustwallow Marsh |goto Dustwallow Marsh |noway |c
]])

ZygorGuidesViewer:RegisterInclude("rideto_stormwind",[[
		goto Teldrassil,55.0,93.7 |n
		.' Ride the boat to Stormwind |goto Stormwind City |noway |c
]])
--------------------------------------------------------------------------------------------------------------------------------------
-- Leveling Kalimdor
--------------------------------------------------------------------------------------------------------------------------------------

-- DUSTWALLOW MARSH --
ZygorGuidesViewer:RegisterInclude("Dustwallow_Marsh",[[
	step
		goto Dustwallow Marsh,34.1,46.8 |n
		.' Follow the bridge across |goto Dustwallow Marsh,34.1,46.8,0.5 |noway |c
	step
		goto 65.1,47.1
		.talk Lieutenant Aden##23951
		..accept Mission to Mudsprocket##27248
	step
		goto 66.2,46.1
		.talk Guard Byron##4921
		..accept Tabetha's Farm##11212
		..accept They Call Him Smiling Jim##27251
	step
		goto 66.6,45.2
		.talk Innkeeper Janene##6272
		.home Theramore Isle
	step
		goto 68.3,48.7
		.talk Morgan Stern##4794
		..accept Mudrock Soup and Bugs##1204
	step
		goto 68.2,48.6
		.talk Captain Garran Vimes##4944
		..turnin Reinforcements From Theramore##26687
		..turnin They Call Him Smiling Jim##27251
		..accept Inspecting the Ruins##27249
	step
		goto 67.5,51.3
		.talk Baldruc##4321
		.fpath Theramore
	step
		goto 68.4,51.0
		.talk Calia Hastings##23566
		..accept Traitors Among Us##27210
	step
		goto 68.3,51.6
		.talk Sergeant Amelyn##23835
		..accept This Old Lighthouse##27216
	step
		goto 67.2,51.0
		.talk 5 Deserter Agitator##23602
		..' Tell them to spout their treasonous filth elsewhere!
		.' Expose 5 Deserter Agitators |q 27210/1
	step
		goto 68.4,51.0
		.talk Calia Hastings##23566
		..turnin Traitors Among Us##27210
		..accept Propaganda War##27211
	step
		goto 67.9,58.7
		.click the Deserter Propoganda##36
		.get Deserter Propaganda |q 27211/1
	step
		goto 68.4,51.0
		.talk Calia Hastings##23566
		..turnin Propaganda War##27211
		..accept Discrediting the Deserters##27212
	step
		goto 67.2,51.0
		.talk Theramore Guard##4979
		..' Tell them they look like intelligent people and ask them to read one of your leaflets and give it some thought
		.' Distribute 6 Leaflets |q 27212/1
	step
		goto 68.4,51.0
		.talk Calia Hastings##23566
		..turnin Discrediting the Deserters##27212
		..accept The End of the Deserters##27213
	step
		goto 76.2,57.0
		.from Gavis Greyshield##23941
		.' He will eventually surrender
		.' Capture Gavis Greyshield |q 27213/1
	step
		goto 68.4,51.0
		.talk Calia Hastings##23566
		..turnin The End of the Deserters##27213
	step
		goto 68.3,51.8
		.talk Sergeant Amelyn##23835
		..accept The Hermit of Swamplight Manor##27215
	step
		goto 72.1,47.0
		.talk Babs Fizzletorque##23892
		..turnin This Old Lighthouse##27216
		..accept Thresher Oil##27217
	step
		goto 71.9,49.7
		.from Young Murk Thresher##4388+
		.get 4 Thresher Oil |q 27217/1
	step
		goto 72.1,47.0
		.talk Babs Fizzletorque##23892
		..turnin Thresher Oil##27217
		..accept Dastardly Denizens of the Deep##27218
	step
		goto 69.1,52.1
		.talk "Dirty" Michael Crowe##23896
		..turnin Dastardly Denizens of the Deep##27218
		..accept Is it Real?##27219
	step
		goto 65.1,47.1
		.talk Lieutenant Aden##23951
		..accept A Disturbing Development##27214
	step
		goto 59.8,41.1
		.talk Captain Wymor##5086
		..turnin A Disturbing Development##27214
		..accept Defias in Dustwallow?##27234
	step
		goto 64.6,43.0 |n
		.' Go to the beach |goto 64.6,43.0,0.5 |noway |c
	step
		goto 64.7,41.3
		.' Walk north on the beach and in the water
		.from Mudrock Spikeshell##4397+
		.get 8 Forked Mudrock Tongue |q 1204/1
	step
		goto 63.8,28.9
		.from Garn Mathers##23679
		.get Defias Orders |q 27234/1
	step
		goto 64.6,43.0 |n
		.' Go to this spot on the beach |goto 64.6,43.0,0.5 |noway |c
	step
		goto 59.7,41.1
		.talk Captain Wymor##5086
		..turnin Defias in Dustwallow?##27234
		..accept Renn McGill##27235
	step
		ding 38
	step
		goto 64.6,43.0 |n
		.' Go to the beach |goto 64.6,43.0,0.5 |noway |c
	step
		goto 63.7,17.0
		.talk Renn McGill##23569
		..turnin Renn McGill##27235
		..accept Secondhand Diving Gear##27236
	step
		goto 63.0,18.6
		.click Tool Kit##1209
		.get Tool Kit |q 27236/2
	step
		goto 62.6,18.2
		.click Damaged Diving Gear##2350
		.get Damaged Diving Gear |q 27236/1
	step
		goto 63.7,17.0
		.talk Renn McGill##23569
		..turnin Secondhand Diving Gear##27236
		..accept Recover the Cargo!##27237
	step
		'Use Renn's Supplies |use Renn's Supplies##33045
		.collect Repaired Diving Gear##33040 |q 27237
		.collect Salvage Kit##33044 |q 27237
	step
		goto 65.6,20.3
		.' Use your Salvage Kit next to Shipwreck Debris |use Salvage Kit##33044 |tip They look like collections of junk floating around underwater around this area.
		.get Salvaged Strongbox |q 27237/1
	step
		goto 63.7,17.0
		.talk Renn McGill##23569
		..turnin Recover the Cargo!##27237
		..accept Jaina Must Know##27238
	step
		'Hearth to Theramore Isle |goto 66.6,45.2,0.5 |use Hearthstone##6948 |noway |c
	step
		goto 65.1,47.7 |n
		.' Follow the path up |goto 65.1,47.7,0.5 |noway |c
	step
		goto 66.3,49.0
		.' Go to the top of the tower
		.talk Lady Jaina Proudmoore##4968
		..turnin Jaina Must Know##27238
		..accept Survey Alcaz Island##27239
	step
		goto 68.3,48.7
		.talk Morgan Stern##4794
		..turnin Mudrock Soup and Bugs##1204
		..accept ... and Bugs##1258
	step
		goto 67.3,51.1
		.talk Cassa Crimsonwing##23704
		..' Tell her Lady Jaina told you to speak to her about using a gryphon to survey Alcaz Island
		.' Survey Alcaz Island |q 27239/1
	step
		goto 70.4,50.1
		.' Walk along the rocks on the outskirts of Theramore Isle
		.from Spiny Rock Crab##44390+
		.get 12 Pristine Crawler Leg |q 1258/1
	step
		goto 68.3,48.7
		.talk Morgan Stern##4794
		..turnin ... and Bugs##1258
	step
		goto 65.1,47.7 |n
		.' Follow the path up |goto 65.1,47.7,0.5 |noway |c
	step
		goto 66.3,49.0
		.' Go to the top of the tower
		.talk Lady Jaina Proudmoore##4968
		..turnin Survey Alcaz Island##27239
	step
		goto 55.4,26.3
		.talk "Swamp Eye" Jarl##4792
		..turnin The Hermit of Witch Hill##27215
		..accept Marsh Frog Legs##27183
	step
		goto 55.6,26.1
		.talk Mordant Grimsby##23843
		..accept What's Haunting Witch Hill?##27188
	step
		goto 55.4,25.9
		.click the Loose Dirt##498
		..accept The Orc Report##27246
	step
		'All around "Swamp Eye" Jarl's house:
		.from Giant Marsh Frog##23979+
		.get 10 Marsh Frog Leg |q 27183/1
	step
		goto 55.4,26.3
		.talk "Swamp Eye" Jarl##4792
		..turnin Marsh Frog Legs##27183
		..accept Jarl Needs Eyes##27184
	step
		goto 55.9,28.5
		.from Risen Husk##23555+, Risen Spirit##23554+
		.' Gather 10 Information |q 27188/1
	step
		goto 55.6,26.1
		.talk Mordant Grimsby##23843
		..turnin What's Haunting Witch Hill?##27188
		..accept The Witch's Bane##27189
	step
		goto 55.2,27.7
		.click Witchbane##7445+
		.get 9 Witchbane |q 27189/1
	step
		goto 55.6,26.1
		.talk Mordant Grimsby##23843
		..turnin The Witch's Bane##27189
		..accept Cleansing Witch Hill##27190
	step
		goto 55.2,26.7
		'Use your Witchbane Torch while standing at the end of the dock right outside |use Witchbane Torch##33113
		.from Zelfrax##23864
		.' Cleanse Witch Hill |q 27190/1
	step
		goto 55.6,26.1
		.talk Mordant Grimsby##23843
		..turnin Cleansing Witch Hill##27190
	step
		goto 46.7,23.1
		.talk Sergeant Lukas##23723
		..accept Raptor Captor##27242
	step
		goto 46.9,17.5
		.talk "Stinky" Ignatz##4880
		..accept Stinky's Escape##1222
		.' Escort "Stinky" Ignatz
		.' Help Stinky find Bogbean Leaves |q 1222/1
		.' Use your Sturdy Rope on any raptors you fight, when they are almost dead |use Sturdy Rope##33069
	step
		goto 47.3,18.9
		.from Bloodfen Raptor##4351+, Bloodfen Screecher##4352+ |tip Don't actually kill them.  When they are almost dead, capture them.
		.' Use your Sturdy Rope when the raptors are almost dead |use Sturdy Rope##33069
		.' Capture 6 Raptors |q 27242/1
	step
		goto 46.7,23.1
		.talk Sergeant Lukas##23723
		..turnin Raptor Captor##27242
		..accept Unleash the Raptors##27243
		..accept Prisoners of the Grimtotems##27245
	step
		ding 39
	step
		goto 41.6,12.1
		.' Use your Raptor Bait next to the windmill |use Raptor Bait##33070
		.' Release the Raptors |q 27243/1
	step
		goto 42.7,13.6
		.from Grimtotem Elder##23714+, Grimtotem Breaker##23592+, Grimtotem Spirit-Shifter##23593+
		.collect Grimtotem Key##33061 |n
		.click Blackhoof Cage##1787+
		.' Free 5 Theramore Prisoners |q 27245/1
	step
		goto 46.7,23.1
		.talk Sergeant Lukas##23723
		..turnin Unleash the Raptors##27243
		..turnin Prisoners of the Grimtotems##27245
	step
		goto Dustwallow Marsh,35.3,22.6
		.from Darkmist Silkspinner##4379+, Darkmist Spider##4376+, Darkmist Recluse##4378+
		.get 20 Unpopped Darkmist Eye |q 27184/1
	step
		goto 29.8,47.7
		.talk Inspector Tarem##23567
		..turnin Inspecting the Ruins##27249
	step
		goto 29.7,47.6
		.click Suspicious Hoofprint##520 
		..accept Suspicious Hoofprints##27262
	step
		goto 29.8,48.2
		.click Theramore Guard Badge##522
		..accept Lieutenant Paval Reethe##27263
	step
		goto 29.6,48.6
		.click Black Shield##58
		..accept The Black Shield##27252
	step
		goto 42.8,72.4
		.talk Dyslix Silvergrub##40358
		.fpath Mudsprocket
	step
		goto 42.3,72.9
		.talk Drazzit Dripvalve##23572
		..turnin Mission to Mudsprocket##27248
	step
		goto 41.8,73.1
		.click Wanted Poster##4371 
		..accept WANTED: Goreclaw the Ravenous##27412
	step
		goto 41.9,74.0
		.talk Brogg##23579
		..accept Bloodfen Feathers##27407
	step
		goto 41.9,74.2
		.talk Axle##23995
		.home Mudsprocket
	step
		goto 41.5,73.0
		.talk Gizzix Grimegurgle##23570
		..accept Catch a Dragon by the Tail##27413
	step
		goto 32.4,65.4
		.kill Goreclaw the Ravenous##23873 |q 27412/1 |tip He's a big green raptor standing at the entrance to the cave.
		.from Bloodfen Razormaw##4356+, Bloodfen Lashtail##4357+
		.get 5 Bloodfen Feather |q 27407/1
	step
		goto 42.3,72.9
		.talk Drazzit Dripvalve##23572
		..turnin WANTED: Goreclaw the Ravenous##27412
	step
		goto 41.9,74
		.talk Brogg##23579
		..turnin Bloodfen Feathers##27407
		..accept Banner of the Stonemaul##27408
		..accept The Essence of Enmity##27409
	step
		goto 38.5,65.9 |n
		.' Use Brogg's Totem on corpses of mobs you kill |use Brogg's Totem##33088
		.' The entrance to the cave is here |goto Dustwallow Marsh,38.5,65.9,0.5 |noway |c
	step
		goto 38.1,69.4
		.click the Stonemaul Banner##6957
		.get Stonemaul Banner |q 27408/1
		.' Use Brogg's Totem on corpses of mobs you kill |use Brogg's Totem##33088
	step
		goto 38.5,65.9 |n
		.' Use Brogg's Totem on corpses of mobs you kill |use Brogg's Totem##33088
		.' Leave the cave |goto Dustwallow Marsh,38.5,65.9,0.5 |noway |c
	step
		goto 39.4,66.6
		.from Firemane Scout##4329+, Firemane Ash Tail##4331+
		.' Use Brogg's Totem on their corpses |use Brogg's Totem##33088
		.get 10 Black Dragonkin Essence |q 27409/1
	step
		goto 46.1,57.4
		.talk Apprentice Morlann##23600
		..accept Direhorn Raiders##27340
		..accept The Zeppelin Crash##27346
	step
		goto 46.0,57.1
		.talk Tabetha##6546
		..turnin Tabetha's Farm##11212
		..accept Help for Mudsprocket##11211
	step
		goto 46.0,57.2
		.talk Apprentice Garion##23601
		..accept The Reagent Thief##27339
	step
		goto 41.5,52.9
		.from Darkfang Creeper##4412+, Noxious Shredder##4348+
		.get 6 Marsh Venom |q 27339/1
	step
		goto 46.6,49.1
		.from Grimtotem Destroyer##23594+, Grimtotem Earthbinder##23595+
		.' Kill 12 Direhorn Grimtotems |q 27340/1
	step
		goto 46.0,57.2
		.talk Apprentice Garion##23601
		..turnin The Reagent Thief##27339
	step
		goto 46.1,57.4
		.talk Apprentice Morlann##23600
		..turnin Direhorn Raiders##27340
	step
		goto 53.6,56.9
		.talk Moxie Steelgrille##23797
		..turnin The Zeppelin Crash##27346
		..accept Corrosion Prevention##27347
		..accept Secure the Cargo!##27348
	step
		goto 53.1,56.0
		.' Use your Ooze Buster on green and blue oozes while Energized! |use Ooze Buster##33108 |tip Stand next to the blue lightning structures to get the Energized! buff.
		.' Dissolve 10 Oozes |q 27347/1
		.click the Zeppelin Cargo##6606
		.get 8 Zeppelin Cargo |q 27348/1
	step
		goto 53.6,56.9
		.talk Moxie Steelgrille##23797
		..turnin Corrosion Prevention##27347
		..turnin Secure the Cargo!##27348
		..accept Delivery for Drazzit##11208
	step
		ding 40
	step
		goto 54.9,58.4 |n
		.' Follow the path down |goto Dustwallow Marsh,54.9,58.4,0.5 |noway |c
	step
		goto 58.8,60.2
		.talk Nat Pagle##12919
		..turnin Is it Real?##27219
		..accept Nat's Bargain##27220
	step
		'Use Pagle's Fish Paste, Extra Strength |use Pagle's Fish Paste, Extra Strength##33166
		.' Wear Pagle's Fish Paste |havebuff Interface\Icons\Spell_Nature_ElementalAbsorption |q 27220
	step
		goto 56.6,62.4
		.from Lurking Shark##23928
		.' Test the Fish Paste |q 27220/1
	step
		goto 58.8,60.2
		.talk Nat Pagle##12919
		..turnin Nat's Bargain##27220
		..accept Oh, It's Real##27221
	step
		goto 66.5,55.1 |n
		.' Swim across to shore |goto 66.5,55.1,0.5 |noway |c
	step
		goto 69.6,51.8
		.talk Major Mills##23905
		..turnin Oh, It's Real##27221
		..accept Take Down Tethyr!##27222
	step
		goto 69.6,51.8
		.' Run around the docks
		.click Cove Cannon##10475+
		.' Defend the Theramore Docks from Tethyr |q 27222/1
	step
		goto 69.6,51.8
		.talk Major Mills##23905
		..turnin Take Down Tethyr!##27222
	step
		goto 68.3,48.7
		.talk Morgan Stern##4794
		..turnin Stinky's Escape##1222
	step
		goto 68.2,48.6
		.talk Captain Garran Vimes##4944
		..turnin Suspicious Hoofprints##27262
		..turnin Lieutenant Paval Reethe##27263
		..accept Lieutenant Paval Reethe##27264
		..turnin The Black Shield##27252
		..accept The Black Shield##27284
	step
		goto 68.0,48.1
		.talk Adjutant Tesoran##4948
		..turnin Lieutenant Paval Reethe##27264
		..accept Daelin's Men##27286
	step
		goto 68.2,48.6
		.talk Captain Garran Vimes##4944
		..turnin Daelin's Men##27286
		..accept The Deserters##27287
	step
		goto 65.1,47.1
		.talk Lieutenant Aden##23951
		..turnin The Orc Report##27246
		..accept Captain Vimes##27247
	step
		goto 64.8,50.4
		.talk Caz Twosprocket##4941
		..turnin The Black Shield##27284
		..accept The Black Shield##27285
	step
		goto 68.2,48.6
		.talk Captain Garran Vimes##4944
		..turnin The Black Shield##27285
		..turnin Captain Vimes##27247
	step
		goto 55.4,26.3
		.talk "Swamp Eye" Jarl##4792
		..turnin Jarl Needs Eyes##27184
		..accept Hungry as an Ogre!##27191
		..accept Jarl Needs a Blade##27186
	step
		goto 57.8,19.6 |n
		.' The path down to Razorspine starts here |goto 57.8,19.6,0.5 |noway |c
	step
		goto 57.9,18.7
		.from Razorspine##23841 |tip He walks up and down this path.
		.get Razorspine's Sword |q 27186/1
	step
		goto 57.4,16.8
		.from Mirefin Coastrunner##4362+, Mirefin Murloc##4359+
		.get 8 Mirefin Head |q 27191/1
	step
		goto 57.9,18.4 |n
		.' The path up to "Swamp Eye" Jarl starts here |goto 57.9,18.4,0.5 |noway |c
	step
		goto 55.4,26.3
		.talk "Swamp Eye" Jarl##4792
		..turnin Hungry as an Ogre!##27191
		..turnin Jarl Needs a Blade##27186
	step
		'Hearth to Mudsprocket |goto 41.9,74.2,1.5 |use Hearthstone##6948 |noway |c
	step
		goto 41.9,74.0
		.talk Brogg##23579
		..turnin Banner of the Stonemaul##27408
		..turnin The Essence of Enmity##27409
		..accept Spirits of Stonemaul Hold##27410
	step
		goto 42.3,72.9
		.talk Drazzit Dripvalve##23572
		..turnin Help for Mudsprocket##11211
		..turnin Delivery for Drazzit##11208
	step
		goto 45.8,68.4
		.click Ogre Remains##7431
		.from Stonemaul Spirit##23786+
		.' Lay 10 Stonemaul Spirits to Rest |q 27410/1
	step
		goto 36.1,54.3
		.from Balos Jacken##5089
		.' Eventually he will surrender
		.talk Balos Jacken##5089
		..turnin The Deserters##27287
		..accept The Deserters##27288
	step
		goto 41.9,74.0
		.talk Brogg##23579
		..turnin Spirits of Stonemaul Hold##27410
		..accept Challenge to the Black Flight##27411
	step
		ding 41
	step
		goto 52.1,75.8
		.' Use your Stonemaul Banner at the foot of the stone ramp at the entrance to Onyxia's Lair |use Stonemaul Banner##33095
		.from Smolderwing##23789
		.' Avenge the Stonemaul Clan |q 27411/1
	step
		goto 50.5,75.3
		.click Wyrmtail##391+
		.get 8 Wyrmtail|q 27413/1
	step
		goto 41.5,73.0
		.talk Gizzix Grimegurgle##23570
		..turnin Catch a Dragon by the Tail##27413
	step
		goto 41.9,74.0
		.talk Brogg##23579
		..turnin Challenge to the Black Flight##27411
	step
		goto 42.8,72.4
		.talk Dyslix Silvergrub##40358
		.' Fly to Theramore, Dustwallow Marsh |goto 67.5,51.2,0.5 |noway |c
	step
		goto 68.2,48.6
		.talk Captain Garran Vimes##4944
		..turnin The Deserters##27288
	step
		goto 67.5,51.3
		.talk Baldruc##4321
		.' Fly to Mudsprocket, Dustwallow Marsh |goto 42.9,72.4,0.5 |noway |c
	step
		goto 41.8,73.9
		.talk Thyssiana##40345
		..accept To New Thalanaar##25479
	step
		goto 42.8,72.4
		.talk Dyslix Silvergrub##40358
		..' Tell him you need to get to New Thalanaar!
		.' Take a Hippogryph to New Thalanaar |q 25479/1
]])

--------------------------------------------------------------------------------------------------------------------------------------
-- Leveling Eastern Kingdoms
--------------------------------------------------------------------------------------------------------------------------------------
ZygorGuidesViewer:RegisterInclude("A_Eastern_Plaguelands_Argent_Dawn_Revered",[[
	step
		goto Eastern Plaguelands,9.0,66.5
		.talk Fiona##45417
		..turnin Into the Woods##27683
		..accept Gidwin Goldbraids##27367
		..accept Tarenar Sunstrike##27370
	step
		goto 4.1,36.0
		.talk Gidwin Goldbraids##45428
		..turnin Gidwin Goldbraids##27367
		..accept Just Encased##27368
	step
		goto 4.7,35.6 |n
		.' Enter the tunnel |goto 4.7,35.6,0.5 |noway |c
	step
		goto 5.1,33.4
		.from Crypt Stalker##8555+,Crypt Horror##8557+ |tip All inside this tunnel.
		.get 8 Crypt Bile |q 27368/1
	step
		goto 4.7,35.6 |n
		.' Leave the tunnel |goto 4.7,35.6,0.5 |noway |c
	step
		goto Eastern Plaguelands,4.1,36.0
		.talk Gidwin Goldbraids##45428
		..turnin Just Encased##27368
		..accept Greasing the Wheel##27369
	step
		goto 3.4,38.0
		.click Banshee's Bell##9889+
		.get 10 Banshee's Bells |q 27369/1
	step
		goto 9.0,66.5
		.talk Fiona##45417
		..turnin Greasing the Wheel##27369
	step
		goto 18.4,74.8
		.talk Tarenar Sunstrike##45429
		..turnin Tarenar Sunstrike##27370
		..accept What I Do Best##27371
	step
		goto 18.6,76.9
		.kill 5 Death's Step Miscreation##45444+ |q 27371/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin What I Do Best##27371
		..accept A Gift For Fiona##27372
	step
		goto 17.2,68.7
		.from Plaguehound Runt##8596+ |tip They share spawn locations with the Carrion Grubs.  So, if you are having trouble find Plaguehound Runts, kill Carrion Grubs and more should spawn.
		.get 10 Plaguehound Blood |q 27372/1
		.' You can find more Plague Hound Runts around [Eastern Plaguelands,14.4,63.0].
	step
		goto 9.0,66.5
		.talk Fiona##45417
		..turnin A Gift For Fiona##27372
		..accept Onward, to Light's Hope Chapel##27373
	step
		goto 8.8,66.6
		.clicknpc Fiona's Caravan##33315
		..' Choose 1 of the 3 buffs you can choose from |tip All of the buffs only work while you're in Eastern Plaguelands.  Fiona's Lucky Charm gives you a chance to loot extra gold or items from enemies.  Gidwin's Weapon Oil gives you a chance to do extra Holy damage on melee and ranged attacks.  Tarenar's Talisman gives you a chance to do extra Holy damage on successful spell attacks.
		.' Click here to proceed. |confirm
	step
		goto 8.8,66.6
		.clicknpc Fiona's Caravan##33315
		..' Choose to go to the next destination
		.' Ride Fiona's Caravan |q 27373/1
	step
		goto 34.9,67.9
		.talk Janice Myers##44232
		.fpath Crown Guard Tower
	step
		goto 35.0,68.1
		.talk Urk Gagbaz##45500
		..accept Zaeldarr the Outcast##27432
	step
		goto 34.9,69.1
		.talk Fiona##45417
		..turnin Onward, to Light's Hope Chapel##27373
	step
		goto 35.3,68.8
		.talk Tarenar Sunstrike##45429
		..accept Traveling Companions##27381
	step
		goto 35.6,68.9
		.talk Carlin Redpath##11063
		..accept Little Pamela##27383
	step
		goto 35.9,69.3
		.' Go to the top of the tower
		.talk Argus Highbeacon##45451
		..' Ask him if he's interested in joining your caravan
		.' Find a traveling companion |q 27381/1
	step
		goto 35.9,69.3
		.talk Argus Highbeacon##45451
		..accept Rough Roads##27382
	step
		goto 35.3,68.9
		.talk Tarenar Sunstrike##45429
		..turnin Traveling Companions##27381
	step
		goto 32.4,83.7
		.talk Pamela Redpath##10926
		..turnin Little Pamela##27383
		..accept Pamela's Doll##27384
		..accept I'm Not Supposed to Tell You This##27392
	step
		goto 35.5,83.0
		.' You can find the doll parts in all of the buildings |tip They look like yellowish cloth objects on the ground inside the houses around this area.
		.click Pamela's Doll's Right Side##4233
		.collect Pamela's Doll's Right Side##12888 |q 27384
		.click Pamela's Doll's Left Side##4232
		.collect Pamela's Doll's Left Side##12887 |q 27384
		.click Pamela's Doll's Head##4231
		.collect Pamela's Doll's Head##12886 |q 27384
	step
		'Use Pamela's Doll's Head |use Pamela's Doll's Head##12886
		.get Pamela's Doll |q 27384/1
	step
		goto 40.3,83.8
		.from The Lone Hunter##45450
		.get Joseph's Hunting Blade |q 27392/1
	step
		goto 32.4,83.7
		.talk Pamela Redpath##10926
		..turnin Pamela's Doll##27384
		..turnin I'm Not Supposed to Tell You This##27392
		..accept Uncle Carlin##27385
	step
		ding 40
	step
		goto 35.6,68.9
		.talk Carlin Redpath##11063
		..turnin Uncle Carlin##27385
		..accept A Strange Historian##27386
	step
		goto 35.3,68.0
		.talk Chromie##10667
		..turnin A Strange Historian##27386
		..accept Villains of Darrowshire##27387
		..accept Heroes of Darrowshire##27388
		..accept Marauders of Darrowshire##27389
	step
		goto 35.0,68.1
		.talk Urk Gagbaz##45500
		..accept Cenarion Tenacity##27544
	step
		goto 35.6,68.9
		.talk Carlin Redpath##11063
		..' Ask him if he has the extended Annals of Darrowshire
		.get Extended Annals of Darrowshire |q 27388/1
	step
		goto 39.8,72.4
		.click Shattered Sword of Marduk##4175
		.get Shattered Sword of Marduk |q 27387/2
	step
		goto 39.6,72.1
		.kill 13 Plaguebat##8600+ |q 27382/1
	step
		goto 35.9,69.2
		.' Go to the top of the tower
		.talk Argus Highbeacon##45451
		..turnin Rough Roads##27382
	step
		goto 24.2,78.5 |n
		.' Enter the crypt |goto 24.2,78.5,0.5 |noway |c
	step
		goto 23.8,77.9
		.' Go to the bottom of the crypt
		.from Zaeldarr the Outcast##12250
		.get Zaeldarr's Head |q 27432/1
	step
		goto 22.1,68.2
		.click Redpath's Shield##4172
		.get Redpath's Shield |q 27388/3
	step
		goto 22.3,68.3
		.' Go upstairs
		.click Davil's Libram##430
		.get Davil's Libram |q 27388/2
	step
		goto 35.0,68.2
		.talk Urk Gagbaz##45500
		..turnin Zaeldarr the Outcast##27432
	step
		goto 35.2,68.1
		.talk Chromie##10667
		..turnin Heroes of Darrowshire##27388
	step
		goto 37.3,60.2
		.click Horgus' Skull##4173
		.get Skull of Horgus |q 27387/1
	step
		goto 30.2,56.9
		.talk Rayne##16135
		..turnin Cenarion Tenacity##27544
		..accept Postponing the Inevitable##27420
		..accept Amidst Death, Life##27421
	step
		goto 33.7,44.4
		.' Go inside the necropolis
		.' Use Rayne's Seeds while standing on the platform above the green liquid |use Rayne's Seeds##61036
		.' Plant a Seed in the Western Necropolis |q 27421/2
	step
		goto 37.8,42.5
		.' Go inside the necropolis
		.' Use Rayne's Seeds while standing on the platform above the green liquid |use Rayne's Seeds##61036
		.' Plant a Seed in the Northeastern Necropolis |q 27421/3
	step
		goto 37.6,48.3
		.' Go inside the necropolis
		.' Use Rayne's Seeds while standing on the platform above the green liquid |use Rayne's Seeds##61036
		.' Plant a Seed in the Southeastern Necropolis |q 27421/1
	step
		goto 36.4,46.0
		.from Scourge Champion##8529+
		.collect Fetid Skull##13157 |n
		.' Use your Mystic Crystal when you have a Fetid Skull |use Mystic Crystal##13156
		.get 5 Resonating Skull |q 27389/1
		.from Shadowmage##8550+, Dark Adept##8546+
		.collect Plague Disseminator Control Rune##61037 |n
		.' Use your Overcharged Mote when you have a Plague Disseminator Control Rune |use Overcharged Mote##61038
		.' Destroy 3 Plague Disseminators |q 27420/1
	step
		goto 30.2,56.9
		.talk Rayne##16135
		..turnin Postponing the Inevitable##27420
		..turnin Amidst Death, Life##27421
	step
		goto 35.3,68.1
		.talk Chromie##10667
		..turnin Villains of Darrowshire##27387
		..turnin Marauders of Darrowshire##27389
		..accept The Battle of Darrowshire##27390
	step
		goto 35.1,84.0
		.' Use your Relic Bundle |use Relic Bundle##15209
		.' Fight in the battle and follow the instructions that appear on your screen
		.from Redpath the Corrupted##10938
		.' Joseph Redpath will appear after the battle at [Eastern Plaguelands,35.1,84.0]
		.talk Joseph Redpath##10936
		.' Accept Redpath's Forgiveness |q 27390/1
	step
		goto 32.4,83.7
		.talk Pamela Redpath##10926
		..turnin The Battle of Darrowshire##27390
		..accept Hidden Treasures##27391
	step
		goto 32.2,83.4
		.click Joseph's Chest##318
		..turnin Hidden Treasures##27391
	step
		goto 34.9,69.2
		.talk Fiona##45417
		..accept The Trek Continues##27448
	step
		goto 35.0,69.3
		.clicknpc Fiona's Caravan##33315
		..' Choose to go to the next destination
		.' Ride in Fiona's Caravan |q 27448/1
	step
		goto 52.8,53.6
		.talk Devon Manning##44231
		.fpath Light's Shield Tower
	step
		goto 52.9,53.1
		.talk Fiona##45417
		..turnin The Trek Continues##27448
		..accept Boys Will Be Boys##27455
	step
		goto 53.0,53.1
		.clicknpc Fiona's Caravan##33315
		.' Complete the Argus' Journal quest |tip This will give you a 2% experience bonus while in Eastern Plaguelands, so will allow you to level faster.  //%
		|confirm
	step
		goto 53.2,54.6
		.talk Betina Bigglezink##11035
		..accept To Kill With Purpose##27451
		..accept Dark Garb##27452
	step
		goto 53.8,54.0
		.' Go to the top of the tower
		.talk Frederick Calston##45575
		..accept Frederick's Fish Fancy##27450
	step
		goto 52.8,51.4
		.talk Vex'tul##45574
		..accept Honor and Strength##27449
		.kill 3 Mossflayer Rogue##45579+ |q 27449/1
	step
		goto 52.8,51.4
		.talk Vex'tul##45574
		..turnin Honor and Strength##27449
	step
		ding 41
	step
		goto 50.2,61.3
		.click Plague Puffer##45650+
		.get 8 Plague Puffer |q 27450/1
		.' Click Infectis Incher##34590+
		.get 8 Infectis Incher |q 27450/2
		.click Infectis Scuttler##45657+
		.get 8 Infectis Scuttler |q 27450/3
	step
		goto 53.7,62.3
		.from Unseen Servant##8538+, Stitched Horror##8543+, Hate Shrieker##8541+, Dark Caster##8526+, Scourge Warder##8525+, Gibbering Ghoul##8531+
		.collect 7 Living Rot##15447 |n |tip These only last 10 minutes, so keep an eye on the timer and try to get them as fast as you can.
		.' Use Mortar and Pestle once you have 7 Living Rot |use Mortar and Pestle##15454
		.get Coagulated Rot |q 27451/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin To Kill With Purpose##27451
	step
		ding 41
	step
		goto 55.7,61.0
		.from Dark Summoner##8551+, Vile Tutor##8548+
		.get Death Cultist Headwear |q 27452/1
		.get Death Cultist Robes |q 27452/2
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Dark Garb##27452
		..accept Catalysm##27453
	step
		goto 57.6,72.6
		.' Use Betina's Flasks on Plague Ravagers and Blighted Surges underwater |use Betina's Flasks##61284
		.get 8 Active Liquid Plague Agent |q 27453/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Catalysm##27453
		..accept Just a Drop in the Bucket##27454
	step
		goto 61.7,75.5
		.' Use your Death Cultist Disguise |use Death Cultist Disguise##61283
		.' Wear your Death Cultist Disguise |havebuff INTERFACE\ICONS\inv_helmet_152 |q 27454
	step
		goto 62.4,76.4
		.click Mereldar Plague Cauldron##4331
		..' Choose to throw in an entire flask
		.' Disturb the Mereldar Plague Cauldron |q 27454/1
	step
		goto 53.2,54.6
		.talk Betina Bigglezink##11035
		..turnin Just a Drop in the Bucket##27454
	step
		goto 53.8,54.0
		.' Go to the top of the tower
		.talk Frederick Calston##45575
		..turnin Frederick's Fish Fancy##27450
	step
		goto 74.4,53.3
		.talk Gidwin Goldbraids##45431
		..turnin Boys Will Be Boys##27455
		..accept A Boyhood Dream##27463
	step
		goto 73.8,51.9
		.talk Rimblat Earthshatter##16134
		..accept Gathering Some Grub(s)##27456
	step
		goto 74.9,53.5
		.talk Smokey LaRue##11033
		..accept Smokey and the Bandage##27458
	step
		goto 75.8,53.4
		.talk Khaelyn Steelwing##12617
		.fpath Light's Hope Chapel
	step
		goto 75.6,52.4
		.talk Jessica Chambers##16256
		.home Light's Hope Chapel
	step
		goto 75.6,52.0
		.talk Leonid Barthalomew the Revered##11036
		..accept The Brotherhood of Light##27459
	step
		goto 75.9,52.0
		.talk Lord Maxwell Tyrosus##11034
		..turnin A Boyhood Dream##27463
		..accept Argent Call: The Trial of the Crypt##27464
	step
		goto 77.2,50.8 |n
		.' Enter the crypt |goto 77.2,50.8,0.5 |noway |c
	step
		goto 77.2,51.4
		.' Go to the bottom of the crypt
		.' Use your Argent Scroll |use Argent Scroll##61309
		.from Argent Warden##45698+
		.from Lord Raymond George##45707
		.' Complete the Trial of the Crypt |q 27464/1
	step
		goto 75.9,52.0
		.talk Lord Maxwell Tyrosus##11034
		..turnin Argent Call: The Trial of the Crypt##27464
		..accept Argent Call: The Noxious Glade##27465
	step
		goto 71.9,45.4
		.from Stephen Browman##46167
		.get Browman's Wrappings |q 27458/1
	step
		goto 72.1,41.6 |n
		.' Run up this path |goto 72.1,41.6,0.5 |noway |c
	step
		goto 77.4,37.3
		.kill 16 Noxious Glade Scourge |q 27465/1
		.kill 8 Noxious Glade Cultists |q 27465/2
		'|from Diseased Flayer##8532+, Dread Weaver##8528+, Death Singer##8542+
		'|from Skullmage##45691+, Noxious Assassin##45692+
	step
		'Hearth to Light's Hope Chapel |goto 75.6,52.4,0.5 |use Hearthstone##6948 |noway |c
	step
		goto 75.9,52.0
		.talk Lord Maxwell Tyrosus##11034
		..turnin Argent Call: The Noxious Glade##27465
	step
	label	"Annals"
		goto 76.1,51.0
		.talk Lord Raymond George##49856
		|tip These are dungeon quests. If you are not high level, you will need to get a group to continue.
		..accept Annals of the Silver Hand##28755 |repeatable
	step
		goto 27.8,11.6
		.' Enter Stratholme through this portal
		.' Teleport to Stratholme |goto Stratholme |noway |c
	step
		goto Stratholme,32.1,34.6
		.click The Bastion Door##444
		.' Enter the hallway |goto Stratholme,30.5,35.8,0.5 |c
	step
		goto Stratholme,22.4,56.6
		.click Hall of the High Command Door##444
		.' Enter the Hallway and turn left |goto 20.1,59.5,0.5 |noway |c
	step
		goto Stratholme,27.5,74.7
		.click Annals of the Silver Hand##8133
		.get Annals of the Silver Hand |q 28755/1
	step
		'Hearth to Light's Hope Chapel | goto Eastern Plaguelands,75.5,52.6,0.5 |use Hearthstone##6948 |noway |c
	step
		goto Eastern Plaguelands,76.2,51.0
		.talk Lord Raymond George##49856
		..turnin Annals of the Silver Hand##28755
		|next "Annals" |only if rep('Argent Dawn')<=Revered
	step
		.' Congratulations, you are now Exalted with the _Argent Dawn_!
]])

--------------------------------------------------------------------------------------------------------------------------------------
-- Leveling Outland
--------------------------------------------------------------------------------------------------------------------------------------
ZygorGuidesViewer:RegisterInclude("Hellfire_Peninsula",[[
	step
		goto Blasted Lands,59.4,14.9
		.talk Bernie Heisten##3546
		.buy 1 Nethergarde Bitter##23848 |q 9563 |future
	step
		goto 54.7,50.5
		.talk Watch Commander Relthorn Netherwane##16841
		..accept Through the Dark Portal##10119
	step
		goto 55.0,54.0 |n
		.' Go into the big green portal to the Outlands |goto Hellfire Peninsula |noway |c
	step
		goto Hellfire Peninsula,87.3,50.7
		.talk Commander Duron##19229
		..turnin Through the Dark Portal##10119
		..accept Arrival in Outland##10288
	step
		goto 87.4,52.4
		.talk Amish Wildhammer##18931
		..turnin Arrival in Outland##10288
		..accept Journey to Honor Hold##10140
	step
		|fly Honor Hold
	step
		goto 54.5,62.8
		.talk Marshal Isildor##19308
		..turnin Journey to Honor Hold##10140
		..accept Force Commander Danath##10254
	step
		.home Honor Hold
	step
		goto 56.6,66.7
		.talk Force Commander Danath Trollbane##16819
		..turnin Force Commander Danath##10254
		..accept The Legion Reborn##10141
		..accept Know your Enemy##10160
	step
		goto 51.2,60
		.talk Dumphry##21209
		..accept Waste Not, Want Not##10055
	step
		goto 50.9,60.2
		.talk Lieutenant Amadi##16820
		..turnin Know your Enemy##10160
		..accept Fel Orc Scavengers##10482
	step
		goto 61.7,60.8
		.talk Sergeant Altumus##19309
		..turnin The Legion Reborn##10141
		..accept The Path of Anguish##10142
	step
		goto 60.4,52.1
		.' Click the Salvaged Metal and Wood|They are scraps on the ground around this area.
		.get 8 Salvaged Metal |q 10055/1
		.get 8 Salvaged Wood |q 10055/2
		.kill 20 Bonechewer Orcs |q 10482/1
		'|from Bonechewer Evoker##19701, Bonechewer Raider##16925, Bonechewer Mutant##16876, Bonechewer Scavenger##18952
	step
		goto 65.8,54.1
		.' Be on the lookout for the giant Fel Reaver
		.kill 1 Dreadcaller##19434 |q 10142/1
		.kill 4 Flamewaker Imp##19136+ |q 10142/2
		.kill 6 Infernal Warbringer##19261+ |q 10142/3
	step
		goto 61.7,60.8
		.talk Sergeant Altumus##19309
		..turnin The Path of Anguish##10142
		..accept Expedition Point##10143
	step
		goto 51.2,60
		.talk Dumphry##21209
		..turnin Waste Not, Want Not##10055
		..accept Laying Waste to the Unwanted##10078
	step
		goto 50.9,60.2
		.talk Lieutenant Amadi##16820
		..turnin Fel Orc Scavengers##10482
		..accept Ill Omens##10483
	step
		goto 71.3,62.8
		.talk Forward Commander Kingston##19310
		..turnin Expedition Point##10143
		..accept Disrupt Their Reinforcements##10144
	step
		goto 72.0,59.6
		.kill the demons here|n
		.collect 4 Demonic Rune Stone##28513|q 10144
		'|from Wrathguard##18975, Doomwhisperer##18981
	step
		goto 72.7,59
		.' Stand inside the portal and click it to destroy it|goal Disrupt Portal Kaalez|q 10144/2
	step
		goto 71.7,56.4
		.kill the demons here|n
		.collect 4 Demonic Rune Stone##28513|q 10144
		'|from Wrathguard##18975, Doomwhisperer##18981
	step
		goto 71.4,55.2
		.' Stand inside the portal and click it to destroy it|goal Disrupt Portal Grimh|q 10144/1
	step
		goto 71.3,62.8
		.talk Forward Commander Kingston##19310
		..turnin Disrupt Their Reinforcements##10144
		..accept Mission: The Murketh and Shaadraz Gateways##10146
	step
		goto 71.4,62.5
		.talk Wing Commander Dabir'ee##19409
		.' Take the flight
		.' Click the bomb in your bags, bomb Gateway Shaadraz|goal Gateway Shaadraz Destroyed|q 10146/2|use Seaforium PU-36 Explosive Nether Modulator##28038
		.' Click the bomb in your bags, bomb Gateway Murketh|goal Gateway Murketh Destroyed|q 10146/1|use Seaforium PU-36 Explosive Nether Modulator##28038
	step
		goto 71.4,62.7
		.talk Forward Commander Kingston##19310
		..turnin Mission: The Murketh and Shaadraz Gateways##10146
		..accept Shatter Point##10340
	step
		goto 71.4,62.5
		.talk Wing Commander Dabir'ee##19409
		..'Fly to Shatter Point|goto Hellfire Peninsula,78.5,35.1,1|noway|c
	step
		goto 78.4,34.9
		.talk Runetog Wildhammer##20234
		.fpath Shatter Point
	step
		goto 78.4,34.9
		.talk Runetog Wildhammer##20234
		..turnin Shatter Point##10340
		..accept Wing Commander Gryphongar##10344
	step
		goto 79.3,33.9
		.talk Wing Commander Gryphongar##20232
		..turnin Wing Commander Gryphongar##10344
		..accept Mission: The Abyssal Shelf##10163
	step
		goto 78.3,34.5
		.talk Gryphoneer Windbellow##20235
		.' Take a flight to the Abyssal Shelf
		.' Use the Area 52 Special bomb in your bags to bomb the mobs|use Area 52 Special##28132|tip If you don't complete this in the first run, you can keep flying until it's done.
		..kill 20 Gan'arg Peon##19398+ |q 10163/1
		..kill 5 Mo'arg Overseer##19397+ |q 10163/2
		..'Destroy 5 Fel Cannons |goal 5 Fel Cannon Destroyed|q 10163/3
	step
		goto 79.3,33.9
		.talk Wing Commander Gryphongar##20232
		..turnin Mission: The Abyssal Shelf##10163
		..accept Go to the Front##10382
	step
		goto 78.3,34.5|n
		.talk Gryphoneer Windbellow##20235 |tip Right next to an Armored Gryphon Destroyer.
		..'Fly to Honor Point|goto Hellfire Peninsula,68.7,28.2,1|noway|c
	step
		goto 68.3,28.6
		.talk Field Marshal Brock##20793
		..turnin Go to the Front##10382
	step
		'Hearth to Honor Hold|goto Hellfire Peninsula,54.3,63.6,0.5|use Hearthstone##6948|noway|c
	step
		goto 54.3,63.6
		.talk Father Malgor Devidicus##16825
		..accept An Old Gift##10058
	step
		goto 54.3,63.6
		.talk Sid Limbardi##16826
		..accept The Longbeards##9558
	step
		goto 56.7,66.5
		.talk Warp-Scryer Kryv##16839
		..accept The Path of Glory##10047
	step
		goto 50.9,60.2
		.talk Honor Guard Wesilow##16827
		..accept Unyielding Souls##10050
	step
		goto 52,62.6
		.talk Foreman Biggums##16837
		..accept A Job for an Intelligent Man##9355
		..accept When This Mine's a-Rockin'##10079
	step
		'Go inside the cave to 54.9,62.9|goto 54.9,62.9
		.kill 12 Gan'arg Sapper##18827+ |q 10079/1
	step
		'Go outside the cave to 52,62.6|goto 52,62.6
		.talk Foreman Biggums##16837
		..turnin When This Mine's a-Rockin'##10079
		..accept The Mastermind##10099
	step
		'Go inside the cave to 56.3,61.4|goto 56.3,61.4
		.kill Z'kral##18974 |q 10099/1|tip He is all the way at the bottom of the cave way in the back of the big room.
	step
		'Go outside the cave to 52,62.6|goto 52,62.6
		.talk Foreman Biggums##16837
		..turnin The Mastermind##10099
	step
		goto 66.1,48.8
		.' Click the Trampled Skeletons|tip They look like little brown ribcages and spines.  You will find them on the grey road.  They are very easy to miss, but once you find one you will find them really fast.
		.' Cleanse 8 Trampled Skeletons|goal 8 Cleanse Trampled Skeleton|q 10047/1
	step
		goto 58.7,47
		.' Use your Flaming Torch on the Eastern Thrower to burn it|goal Eastern Thrower Burned|q 10078/1|use Flaming Torch##26002|tip It's a big catapult.
	step
		goto 55.9,46.7
		.' Use your Flaming Torch on the Central Eastern Thrower to burn it|goal Central Eastern Thrower Burned|q 10078/2|use Flaming Torch##26002|tip It's a big catapult.
	step
		goto 53.5,47.2
		.' Use your Flaming Torch on the Central Western Thrower to burn it|goal Central Western Thrower Burned|q 10078/3|use Flaming Torch##26002|tip It's a big catapult.
	step
		goto 52.8,47.1
		.' Use your Flaming Torch on the Western Thrower to burn it|goal Western Thrower Burned|q 10078/4|use Flaming Torch##26002|tip It's a big catapult.
	step
		goto 65.8,67.2
		.kill Bleeding Hollow orcs|n
		.get Cursed Talisman|q 10483/1
		'|from Bleeding Hollow Tormentor##19424+, Bleeding Hollow Peon##16907+,Bleeding Hollow Grunt##16871+
	step
		goto 71,63.4
		.talk Corporal Ironridge##21133
		..turnin Ill Omens##10483
		..accept Cursed Talismans##10484
	step
		goto 55,86.8
		.' Click the small book|tip It's a small white book laying on the steps of the house.
		.get Mysteries of the Light|q 10058/1
	step
		goto 58,79
		.kill 10 Unyielding Sorcerer##16905+ |q 10050/2
		.kill 5 Unyielding Knight##16906+ |q 10050/3
		.kill 12 Unyielding Footman##16904+ |q 10050/1
	step
		goto 49.2,74.8
		.talk "Screaming" Screed Luckheed##19367
		..accept In Case of Emergency...##10161
		.talk Legassi##19344
		..accept Ravager Egg Roundup##9349
	step
		goto 41.2,84.4
		.' Click Ravager Eggs|tip They look like big white eggs on the ground around this area.
		.kill Razorfury Ravagers |n
		.get 12 Ravager Egg |q 9349/1
		'|from Razorfang Ravager##16933,Razorfang Hatchling##16932
	step
		goto 49.2,74.8
		.talk Legassi##19344
		..turnin Ravager Egg Roundup##9349
		..accept Helboar, the Other White Meat##9361
	step
		goto 50.2,74.8
		.kill Helboars|n
		.get Tainted Helboar Meat|n
		.' Use your Purification Mixture on the Tainted Helboar Meat|use Purification Mixture##23268|tip The meat won't become purified every time, it can become toxic as well.
		.get 8 Purified Helboar Meat|q 9361/1
		'|from Deranged Helboar##16863
	step
		goto 49.2,74.8
		.talk Legassi##19344
		..turnin Helboar, the Other White Meat##9361
		..accept Smooth as Butter##9356
	step
		goto 58.1,71.3
		.kill vultures |n
		.get 12 Plump Buzzard Wing |q 9356/1
		.get 30 Zeppelin Debris |q 10161/1|tip They look like scraps of metal all over the ground.
		'|from Bonestripper Buzzard##16972+
	step
		goto 49.2,74.8
		.talk "Screaming" Screed Luckheed##19367
		..turnin In Case of Emergency...##10161
		..accept Voidwalkers Gone Wild##9351
		.talk Legassi##19344
		..turnin Smooth as Butter##9356
	step
		goto 47.8,65.8
		.kill 15 Marauding Crust Burster##16857+ |q 9355/1|tip They are under the jumping piles of rocks, they come up to fight when you get close to the jumping rocks.
		.kill Marauding Crustbusters|n
		.get Eroded Leather Case|n
		.' Click the Eroded Leather Case|use Eroded Leather Case##23338
		..accept Missing Missive##9373
	step
		goto 52,62.6
		.talk Foreman Biggums##16837
		..turnin A Job for an Intelligent Man##9355
	step
		goto 51.2,60
		.talk Dumphry##21209
		..turnin Laying Waste to the Unwanted##10078
	step
		goto 50.9,60.2
		.talk Honor Guard Wesilow##16827
		..turnin Unyielding Souls##10050
		..accept Looking to the Leadership##10057
	step
		goto 54.3,63.4
		.talk Father Malgor Devidicus##16825
		..turnin An Old Gift##10058
	step
		goto 56.7,66.5
		.talk Warp-Scryer Kryv##16839
		..turnin The Path of Glory##10047
		..accept The Temple of Telhamat##10093
	step
		ding 61
	step
		goto 23.1,40.3
		.talk Anchorite Obadei##16834
		..accept In Search of Sedai##9390
		.talk Ikan##16799
		..accept Cruel Taskmasters##9399
	step
		goto 23.4,39.7
		.talk Scout Vanura##16797
		..accept Deadly Predators##9398
	step
		goto 23.4,36.5
		.talk Amaan the Wise##16796
		..turnin The Temple of Telhamat##10093
		..accept The Pools of Aggonar##9426
	step
		.home Temple of Telhamat
	step
		goto 25.2,37.2
		.talk Kuma##18785
		.fpath Temple of Telhamat
	step
		goto 26.9,37.4
		.' Click Sedai's Corpse|tip Right down the hill from the Temple of Telhamat Flight Path.
		..turnin In Search of Sedai##9390
		..accept Return to Obadei##9423
	step
		goto 23.1,40.3
		.talk Anchorite Obadei##16834
		..turnin Return to Obadei##9423
		.talk Makuru##16833
		..accept Makuru's Vengeance##9424
	step
		goto 34.6,34.7
		.kill Mag'har Grunts and Debilitated Mag'har Grunts|n
		.get 10 Mag'har Ancestral Beads|q 9424/1
		'|from Mag'har Grunts##16846, Debilitated Mag'har Grunt##16847
	step
		goto 38.9,29.1
		.kill 6 Terrorfiend##16951 |q 9426/1
		.kill 6 Blistering Rot##16901 |q 9426/2
	step
		goto 23.1,40.3
		.talk Makuru##16833
		..turnin Makuru's Vengeance##9424
		.talk Anchorite Obadei##16834
		..accept Atonement##9543
	step
		goto 23.4,36.5
		.talk Amaan the Wise##16796
		..turnin Atonement##9543
		..accept Sha'naar Relics##9430
		..turnin The Pools of Aggonar##9426
		..accept Cleansing the Waters##9427
		..accept Helping the Cenarion Post##10443
	step
		goto 23.2,36.7
		.talk Elsaana##17006
		..accept An Ambitious Plan##9383
	step
		goto 40.3,30.9
		.' Get close to the ribcage of the skeleton and next to the poisoned water
		.' Empty your Cleansing Vial in this spot|use Cleansing Vial##23361
		.' Kill Aggonis|goal Aggonar's Presence Cleansed|q 9427/1
	step
		goto 23.4,36.5
		.talk Amaan the Wise##16796
		..turnin Cleansing the Waters##9427
	step
		goto 15.7,52
		.talk Thiah Redmane##16991
		..turnin Missing Missive##9373
		..turnin Helping the Cenarion Post##10443
		..accept Demonic Contamination##9372
	step
		goto 18.4,54.7
		.kill Hulking Helboar##16880+ |n
		.get 6 Helboar Blood Sample|q 9372/1
	step
		goto 15.7,52
		.talk Thiah Redmane##16991
		..turnin Demonic Contamination##9372
		..accept Testing the Antidote##10255
	step
		goto 25,54
		.' Use the Cenarion Antidote on a Hulking Helboar|use Cenarion Antidote##23337
		.' Administer the Antidote|goal Administer Antidote|q 10255/1
	step
		goto 15.7,52
		.talk Thiah Redmane##16991
		..turnin Testing the Antidote##10255
	step
		goto 15.1,55.7
		.kill 4 Illidari Taskmaster##17058+ |q 9399/1 |tip If you kill the taskmaster first, his slaves leave you alone.
		.get 10 Sha'naar Relic |q 9430/1 |tip The Sha'naar Relics look like little blue vases on the ground.
	step
		goto 15.6,58.8
		.talk Akoru the Firecaller##20678
		..accept Naladu##10403
	step
		goto 16.3,65.1
		.talk Naladu##19361
		..turnin Naladu##10403
		..accept A Traitor Among Us##10367
	step
		goto 14.3,63.5
		.' Click the metal coffer on the floor in the big red hut
		.get Sha'naar Key|q 10367/1
	step
		goto 16.3,65.1
		.talk Naladu##19361
		..turnin A Traitor Among Us##10367
		..accept The Dreghood Elders##10368
	step
		goto 15.6,58.8
		.talk Akoru the Firecaller##20678
		..' Free Akoru the Firecaller|goal Akoru Freed|q 10368/2
	step
		goto 13,58.4
		.talk Aylaan the Waterwaker##20679
		..' Free Aylaan the Waterwaker|goal Aylaan Freed|q 10368/3
	step
		goto 13.1,61
		.talk Morod the Windstirrer##20677
		..' Free Morod the Windstirrer|goal Morod Freed|q 10368/1
	step
		goto 16.3,65.1
		.talk Naladu##19361
		..turnin The Dreghood Elders##10368
		..accept Arzeth's Demise##10369
	step
		goto 14.4,62.3
		.' Wait until Arzeth the Merciless is up top of the stairs by himself
		.' Use the Staff of the Dreghood Elders on Arzeth the Merciless|use Staff of the Dreghood Elders##29513
		.kill Arzeth the Powerless##20680 |q 10369/1
	step
		goto 16.3,65.1
		.talk Naladu##19361
		..turnin Arzeth's Demise##10369
	step
		goto 24,72.1
		.talk Gremni Longbeard##16850
		..turnin The Longbeards##9558
		..accept The Arakkoa Threat##9417
		..accept Rampaging Ravagers##9385
	step
		goto 24.0,72.3
		.talk Mirren Longbeard##16851
		..accept Gaining Mirren's Trust##9563
		..turnin Gaining Mirren's Trust##9563
		..accept The Finest Down##9420
	step
		goto 25.6,70.3
		.kill 4 Haal'eshi Windwalker##16966+ |q 9417/1
		.kill 6 Haal'eshi Talonguard##16967+  |q 9417/2
		.' Click the Kaliri nests and kill Kaliri birds|tip The nests look like little brown nests with pink eggs in them.
		.get 8 Kaliri Feather|q 9420/1
	step
		goto 26.1,77.1|n
		.' The path up to Avruu starts here|goto Hellfire Peninsula,26.1,77.1,0.5|noway|c
	step
		goto 25.7,75.1
		.from Avruu##17084
		.get Avruu's Orb|n
		.' Click Avruu's Orb|use Avruu's Orb##23580
		..accept Avruu's Orb##9418
	step
		goto 29,81.5
		.' Click the Haal'eshi Altar|tip It looks like an orb sitting in a claw thing, right in front of a big purple hut.
		.' Fight Aeranas until he's almost dead
		.talk Aeranas##17085
		..turnin Avruu's Orb##9418
	step
		goto 24,72.1
		.talk Gremni Longbeard##16850
		..turnin The Arakkoa Threat##9417
		.talk Mirren Longbeard##16851
		..turnin The Finest Down##9420
	step
		goto 23.7,69.2
		.kill 10 Quillfang Ravager##16934+ |q 9385/1
	step
		goto 24,72.1
		.talk Gremni Longbeard##16850
		..turnin Rampaging Ravagers##9385
	step
		goto 26.9,69.5
		.kill 8 Stonescythe Whelp##16927+ |q 9398/2
	step
		goto 32.1,59.3
		.kill 4 Stonescythe Alpha##16929+ |q 9398/1
		.' You can find 2 more Stonescythe Alphas at [Hellfire Peninsula,33.7,62.1]
	step
		goto 49.5,81.8
		.kill voidwalkers|n
		.get 10 Condensed Voidwalker Essence|q 9351/1
		.' Use your Sanctified Crystal on an Uncontrolled Voidwalker when it's almost dead|use Sanctified Crystal##23417
		.' Click the red floating crystal over its corpse
		.get Glowing Sanctified Crystal|q 9383/1
	step
		goto 53.6,81.1
		.kill Arch Mage Xintor##16977 |q 10057/1|tip Near a bunch of practice fighting dummies.
	step
		goto 54.7,83.7
		.kill Lieutenant Commander Thalvos##16978 |q 10057/2|tip Walking around on a black platform thing. He's a blue ghost dwarf.
	step
		goto 49.2,74.8
		.talk "Screaming" Screed Luckheed##19367
		..turnin Voidwalkers Gone Wild##9351
	step
		'Hearth to the Temple of Telhamat|goto Hellfire Peninsula,23.4,37.2,3|use Hearthstone##6948|noway|c
	step
		goto 23.4,36.5
		.talk Amaan the Wise##16796
		..turnin Sha'naar Relics##9430
		..accept The Seer's Relic##9545
		.talk Elsaana##17006
		..turnin An Ambitious Plan##9383
	step
		goto 23.4,39.7
		.talk Scout Vanura##16797
		..turnin Deadly Predators##9398
	step
		goto 23.1,40.3
		.talk Ikan##16799
		..turnin Cruel Taskmasters##9399
	step
		goto 26.9,37.4
		.' Use the Seer's Relic on Sedai's Corpse|use Seer's Relic##23645|tip Right down the hill from the Temple of Telhamat Flight Path.
		.' See the vision|goal Vision Granted|q 9545/1
	step
		goto 23.4,36.5
		.talk Amaan the Wise##16796
		..turnin The Seer's Relic##9545
	step
		'Fly to Honor Hold|goto Hellfire Peninsula,54.6,62.6,0.5|noway|c
	step
		goto 50.9,60.2
		.talk Honor Guard Wesilow##16827
		..turnin Looking to the Leadership##10057
	step
		goto 64.2,71.8
		.kill Bleeding Hollow Orcs |n
		.get 12 Cursed Talisman |q 10484/1
		'|from Bleeding Hollow Peon##16907, Bleeding Hollow Grunt##16871
	step
		ding 62
	step
		goto 71,63.4
		.talk Corporal Ironridge##21133
		..turnin Cursed Talismans##10484
		..accept Warlord of the Bleeding Hollow##10485
	step
		goto 71.3,62.8
		.talk Wing Commander Dabir'ee##19409
		..accept Zeth'Gor Must Burn!##10895
	step
		goto 70.1,69.1
		.' Use your Smoke Beacon under the tower|use Smoke Beacon##31739
		.' Mark the Forge Tower|q 10895/3
	step
		goto 70.9,71.3
		.' Use your Smoke Beacon under the tower|use Smoke Beacon##31739
		.' Mark the Foothill Tower |q 10895/4
	step
		goto 70.1,76.9
		.from Warlord Morkh##16964
		.get Morkh's Shattered Armor|q 10485/1
	step
		goto 66.4,76.6
		.' Use your Smoke Beacon under the tower|use Smoke Beacon##31739
		.' Mark the Southern Tower|goal Southern Tower Marked|q 10895/2
	step
		goto 67.9,67
		.' Use your Smoke Beacon under the tower|use Smoke Beacon##31739
		.' Mark the Northern Tower|goal Northern Tower Marked|q 10895/1
	step
		goto 71,63.4
		.talk Corporal Ironridge##21133
		..turnin Warlord of the Bleeding Hollow##10485
		..accept Return to Honor Hold##10903
	step
		goto 71.3,62.8
		.talk Wing Commander Dabir'ee##19409
		..turnin Zeth'Gor Must Burn!##10895
	step
		goto 54.3,63.6
		.talk Assistant Klatu##22430
		..turnin Return to Honor Hold##10903
		..accept Fel Spirits##10909
		..accept Digging for Prayer Beads##10916
	step
		'Go outside and behind the inn to 54.2,63.3|goto 54.2,63.3
		.' Click Fei Fei's Cache|tip It's a small mound of dirt behind the inn.
		.get Draenei Prayer Beads|q 10916/1
	step
		goto 45,75
		.' Use the Anchorite Relic in your bags|use Anchorite Relic##31772
		.' Pull orcs to the relic
		.' Kill the orcs and a Fel Spirit will spawn
		.' Kill 10 Fel Spirits|goal 10 Jules Avenged|q 10909/1
	step
		goto 54.3,63.6
		.talk Assistant Klatu##22430
		..turnin Fel Spirits##10909
		..turnin Digging for Prayer Beads##10916
		..accept The Exorcism of Colonel Jules##10935
	step
		goto 54.0,63.5
		.talk Anchorite Barada##22431
		..'Click 'I am ready...'
		..'Target the purple skulls and oozes
		..'Use the Ritual Prayer Beads when enemies are in the room|use Ritual Prayer Beads##31828
		..'After the exorcism is done, talk Colonel Jules on the bed to save him|goal Colonel Jules Saved|q 10935/1
	step
		goto 54.3,63.6
		.talk Assistant Klatu##22430
		..turnin The Exorcism of Colonel Jules##10935
		..accept Trollbane is Looking for You##10936
	step
		goto 56.6,66.7
		.talk Force Commander Danath Trollbane##16819
		..turnin Trollbane is Looking for You##10936
	step
		'Hearth to the Temple of Telhamat|goto Hellfire Peninsula,23.4,36.4,0.5|use Hearthstone##6948|noway|c
	step
		goto 16.0,52.2
		.talk Amythiel Mistwalker##16885
		..accept The Cenarion Expedition##9912
		.talk Mahuram Stouthoof##16888
		..accept Keep Thornfang Hill Clear!##10159
	step
		goto 12.3,49.9
		.kill 8 Thornfang Ravager##19349+ |q 10159/1
		.kill 8 Thornfang Venomspitter##19350+ |q 10159/2
	step
		goto 15.7,52
		.talk Mahuram Stouthoof##16888
		..turnin Keep Thornfang Hill Clear!##10159
	step
		'Go northwest to Zangarmarsh|goto Zangarmarsh|noway|c
]])


--------------------------------------------------------------------------------------------------------------------------------------
-- Leveling Northrend
--------------------------------------------------------------------------------------------------------------------------------------
ZygorGuidesViewer:RegisterInclude("A_Icecrown_Argent_Crusade_Rep",[[
	step
		goto Icecrown,87.8,78.1
		.talk Aedan Moran##30433
		..fpath The Argent Vanguard
	step
		goto 87.5,75.8
		.talk Highlord Tirion Fordring##28179
		..accept Honor Above All Else##13036
	step
		goto 87.1,75.8
		.talk Crusade Commander Entari##30223
		..turnin Honor Above All Else##13036
		..accept Scourge Tactics##13008
	step
		goto 86.8,76.7
		.talk Father Gustav##30226
		..accept Curing The Incurable##13040
	step
		goto 86.1,75.8
		.talk Crusade Lord Dalfors##30224
		..accept Defending The Vanguard##13039
	step
		goto 84.4,74.3
		.kill 15 Forgotten Depths Nerubian |q 13039/1
		.from Carrion Fleshstripper##30206+, Forgotten Depths Acolyte##30205+
		.get 10 Forgotten Depths Venom Sac|q 13040/1
		.' Click Webbed Crusaders|tip They look like white squirming cocoons on the ground around this area.
		.' Free 8 Webbed Crusaders|goal 8 Webbed Crusader Freed|q 13008/1
		'|from Carrion Fleshstripper##30206+, Forgotten Depths Acolyte##30205+
	step
		goto 86.1,75.8
		.talk Crusade Lord Dalfors##30224
		..turnin Defending The Vanguard##13039
	step
		goto 86.8,76.7
		.talk Father Gustav##30226
		..turnin Curing The Incurable##13040
	step
		goto 87.1,75.8
		.talk Crusade Commander Entari##30223
		..turnin Scourge Tactics##13008
		..accept If There Are Survivors...##13044
	step
		goto 87.0,79.0
		.talk Penumbrius##30227
		..turnin If There Are Survivors...##13044
		..accept Into The Wild Green Yonder##13045
	step
		goto 87.1,79.1
		.' Click an Argent Skytalon dragon to ride it |invehicle |tip They look like dragons under white canopies.
	step
		goto 79.0,67.4
		.' Use the Grab Captured Crusader ability near Captured Crusaders to pick them up |petaction Grab Captured Crusader
		.' Once you pick up a Captured Crusader, fly to [86.9,76.5]|n
		.' Use the Drop Off Captured Crusader ability near the tents to drop off the crusaders
		.' Repeat this process 2 more times
		.' Rescue 3 Captured Crusaders |goal 3 Captured Crusader Rescued |q 13045/1
	step
		.' Click the red arrow on your vehicle hot bar to stop riding the dragon |outvehicle
	step
		goto 87.5,75.8
		.talk Highlord Tirion Fordring##28179
		..turnin Into The Wild Green Yonder##13045
		..accept A Cold Front Approaches##13070
	step
		goto 85.6,76.0
		.talk Siegemaster Fezzik##30657
		..turnin A Cold Front Approaches##13070
		..accept The Last Line Of Defense##13086
	step
		goto 85.3,75.9
		.' Click the Argent Cannon to get on it |invehicle |tip It looks like a white cannon on top of a wall tower.
	step
		'Use the skills on your hotbar to kill scourge mobs and dragons
		.kill 100 Scourge Attacker |q 13086/1
		.kill 3 Frostbrood Destroyer |q 13086/2
		'|from Forgotten Depths Slayer##30593, Frostbrood Destroyer##30575
	step
		.' Click the red arrow on your vehicle hot bar to stop using the cannon |outvehicle
	step
		goto 85.6,76.0
		.talk Siegemaster Fezzik##30657
		..turnin The Last Line Of Defense##13086 
	step
		goto 86.0,75.8
		.talk Highlord Tirion Fordring##30677
		..accept Once More Unto The Breach, Hero##13105 |only DeathKnight
		..accept Once More Unto The Breach, Hero##13104 |only !DeathKnight
	step
		goto 83.0,72.9
		.talk The Ebon Watcher##30596
		..turnin Once More Unto The Breach, Hero##13105 |only DeathKnight
		..turnin Once More Unto The Breach, Hero##13104 |only !DeathKnight
		..accept The Purging Of Scourgeholme##13118
		..accept The Scourgestone##13122
	step
		goto 83.0,73.1
		.talk Crusade Architect Silas##30686
		..accept The Stone That Started A Revolution##13130
	step
		goto 83.0,73.1
		.talk Crusade Engineer Spitzpatrick##30714
		..accept It Could Kill Us All##13135
	step
		goto 82.9,72.8
		.talk Father Gustav##30683
		..accept The Restless Dead##13110
	step
		goto 80.4,68.2
		.kill 8 Reanimated Crusader##31043+ |q 13118/3
		.kill 3 Forgotten Depths Underking##31039+ |q 13118/2
		.from Reanimated Crusader##30202+, Forgotten Depths Underking##30541+
		.get 15 Scourgestone |q 13122/1
		.' Use your Holy Water on Reanimated Crusader corpses |use Holy Water##43153
		.' Free 10 Restless Souls |goal 10 Restless Soul Freed |q 13110/1
	step
		goto 78.7,60.2
		.kill 3 Forgotten Depths High Priest##31037+ |q 13118/1
		.' You can find another Forgotten Depths High Priest at [76.2,61.0] |n
	step
		goto 82.9,72.8
		.talk Father Gustav##30683
		..turnin The Restless Dead##13110
	step
		goto 83.0,72.9
		.talk The Ebon Watcher##30596
		..turnin The Purging Of Scourgeholme##13118
		..turnin The Scourgestone##13122
		..accept The Air Stands Still##13125
	step
		goto 77.6,62.2
		.' Use your War Horn of Acherus on Salranax the Flesh Render |use War Horn of Acherus##43206 |tip A Death Knight is summoned to help you, but make sure you get the first hit on Salranax the Flesh Render, or else you won't get credit for the kill.
		.kill Salranax the Flesh Render##30829 |q 13125/1
	step
		goto 79.7,60.9
		.' Use your War Horn of Acherus on High Priest Yath'amon |use War Horn of Acherus##43206 |tip A Death Knight is summoned to help you, but make sure you get the first hit on High Priest Yath'amon, or else you won't get credit for the kill.
		.kill High Priest Yath'amon##30831 |q 13125/3
	step
		goto 76.6,54.1
		.' Use your War Horn of Acherus on Underking Talonox |use War Horn of Acherus##43206 |tip A Death Knight is summoned to help you, but make sure you get the first hit on Underking Talonox, or else you won't get credit for the kill.
		.kill Underking Talonox##30830 |q 13125/2
	step
		'Click the dark portal that spawns after you kill Underking Talonox to return to the Valley of Echoes |goto Icecrown,83.0,72.6,0.5 |noway |c
	step
		goto 83.0,72.9
		.talk The Ebon Watcher##30596
		..turnin The Air Stands Still##13125
	step
		'Go south to Crystalsong Forest |goto Crystalsong Forest |noway |c
	step
		goto Crystalsong Forest,59.9,57.2
		.from Unbound Ent##30862+, Unbound Dryad##30860+
		.get 8 Crystallized Energy |q 13135/1
		.' Click Crystalline Heartwood |tip They look like pink glowing tree stumps on the ground around this area.
		.get 10 Crystalline Heartwood |q 13130/1
	step
		goto 73.6,64.0
		.' Click Ancient Elven Masonry |tip They look like blue stone pieces of a building on the ground around this area.
		.get 10 Ancient Elven Masonry |q 13130/2
		.' You can find more Ancient Elven Masonry around [79.6,61.3] |n
	step
		'Go northwest to Icecrown |goto Icecrown |noway |c
	step
		goto Icecrown,83.0,73.1
		.talk Crusade Architect Silas##30686
		..turnin The Stone That Started A Revolution##13130
	step
		goto 83.0,73.1
		.talk Crusade Engineer Spitzpatrick##30714
		..turnin It Could Kill Us All##13135
	step
		goto 82.9,72.8
		.talk Father Gustav##30683
		..accept Into The Frozen Heart Of Northrend##13139
	step
		goto 86.0,75.8
		.talk Highlord Tirion Fordring##30677
		..turnin Into The Frozen Heart Of Northrend##13139
		..accept The Battle For Crusaders' Pinnacle##13141
	step
		goto 80.1,72.0
		.' Stand next to the Pile of Crusader Skulls
		.' Use your Blessed Banner of the Crusade |use Blessed Banner of the Crusade##43243
		.' Defend the Banner of the Crusade against oncoming attackers
		.' Complete the Battle for Crusaders' Pinnacle |goal Battle for Crusaders' Pinnacle |q 13141/1
	step
		goto 82.9,72.8
		.talk Father Gustav##30683
		..turnin The Battle For Crusaders' Pinnacle##13141
		..accept The Crusaders' Pinnacle##13157
	step
		goto 79.8,71.8
		.talk Highlord Tirion Fordring##31044
		..turnin The Crusaders' Pinnacle##13157
		..accept A Tale of Valor##13068
	step
		goto 79.4,72.9
		.talk Marshal Ivalius##31241
		..accept The Skybreaker##13225
	step
		goto 79.8,30.8
		.talk Crusader Bridenbrad##30562
		..turnin A Tale of Valor##13068
		..accept A Hero Remains##13072
	step
		goto 79.8,71.8
		.talk Highlord Tirion Fordring##31044
		..turnin A Hero Remains##13072
		..accept The Keeper's Favor##13073
	step
		goto 87.1,77.0
		.talk Arch Druid Lilliandra##30630
		..' Ask her for a portal to Moonglade
		..' Click the Moonglade Portal that appears next to you|goto Moonglade|noway|c
	step
		goto Moonglade,36.2,41.8
		.talk Keeper Remulos##11832
		..turnin The Keeper's Favor##13073
		..accept Hope Within the Emerald Nightmare##13074
	step
		goto 33.7,44.1
		.' Click Emerald Acorns|tip They look like brown pinecones on the ground around this area.
		.get 3 Emerald Acorn|q 13074/1
	step
		'Right click your Fitfull Dream buff to awaken from the nightmare|nobuff Spell_Nature_Sleep|q 13074|tip The Fitfull Dream buff icon looks like a closed eye.
	step
		goto 36.2,41.8
		.talk Keeper Remulos##11832
		..turnin Hope Within the Emerald Nightmare##13074
		..accept The Boon of Remulos##13075
	step
		.talk Keeper Remulos##11832
		.' Tell him you wish to return to Arch Druid Lilliandra.
		' Click the Moonglade Return Portal that appears next to you|goto Icecrown|noway|c
	step
		goto 79.8,30.8
		.talk Crusader Bridenbrad##30562
		..turnin The Boon of Remulos##13075
		..accept Time Yet Remains##13076
	step
		goto 79.8,71.8
		.talk Highlord Tirion Fordring##31044
		..turnin Time Yet Remains##13076
		..accept The Touch of an Aspect##13077
	step
		|fly Wyrmrest Temple
	step
		goto Dragonblight,57.9,54.2|n
		.talk Tariolstrasz##26443
		..'Tell him you need to go to the top of the temple|goto Dragonblight,59.7,53.1,0.1|noway|c
	step
		goto 59.8,54.7
		.talk Alexstrasza the Life-Binder##26917
		..turnin The Touch of an Aspect##13077
		..accept Dahlia's Tears##13078
	step
		goto 59.5,53.3|n
		.talk Torastrasza##26949
		..'Tell him you want to go to the ground level of the temple|goto Dragonblight,58.0,55.2,0.1|noway|c
	step
		goto 43.2,51.7
		.' There should be a fight happening, so just wait around until the fight is over|tip If there isn't fight happening, just wait until the fighters spawn again, and there should be some red dragon Ruby Watchers flying above the fight.
		.' At the end of the fight, a Ruby Watcher will blow alot of fire on the ground and the Dahlia's Tears will spawn
		.' Click the Dahlia's Tears|tip They look like yellow flowers on the ground.
		.get Dahlia's Tears|q 13078/1
	step
		goto 57.9,54.2|n
		.talk Tariolstrasz##26443
		..'Tell him you need to go to the top of the temple|goto Dragonblight,59.7,53.1,0.1|noway|c
	step
		goto 59.8,54.7
		.talk Alexstrasza the Life-Binder##26917
		..turnin Dahlia's Tears##13078
		..accept The Boon of Alexstrasza##13079
	step
		goto 59.5,53.3|n
		.talk Torastrasza##26949
		..'Tell him you want to go to the ground level of the temple|goto Dragonblight,58.0,55.2,0.1|noway|c
	step
		|fly Crusader's Pinnacle
	step
		goto 79.8,30.8
		.talk Crusader Bridenbrad##30562
		..turnin The Boon of Alexstrasza##13079
		..accept Hope Yet Remains##13080
	step
		goto 79.8,71.8
		.talk Highlord Tirion Fordring##31044
		..turnin Hope Yet Remains##13080
		..accept The Will of the Naaru##13081
	step
		'Click the Portal to Shattrath that appears near you|goto Shattrath City|noway|c
	step
		goto Shattrath City,54,44.8
		.talk A'dal##18481
		..turnin The Will of the Naaru##13081
		..accept The Boon of A'dal##13082
	step
		|fly Crusader's Pinnacle
	step
		goto Icecrown,79.8,30.8
		.talk Crusader Bridenbrad##30562
		..turnin The Boon of A'dal##13082
	step
		goto 79.8,30.8
		.talk Bridenbrad's Possessions##192833
		..accept Light Within the Darkness##13083
	step
		'You should now be above honored with the _Argent Crusade_.
		.' The fastest way to continue to earn reputation with _Argent Crusade_ is to buy a tabard and run any dungeon that gives experience. 
		|confirm
	step
		goto Icecrown,87.5,75.6
		.talk Veteran Crusader Aliocha Segard##30431
		.collect Tabard of the Argent Crusade##43154
	step
		.' Equipt this Tabard in your bags |equipped Tabard of the Argent Crusade##43154 |use Tabard of the Argent Crusade##43154
		.' You can run any dungeon that grants experience to gain reputation for the Argent Crusade.
		.' Friendly with Argent Crusade |condition rep('Argent Crusade')>=Friendly
		.' Honored with Argent Crusade |condition rep('Argent Crusade')>=Honored
		.' Revered with Argent Crusade |condition rep('Argent Crusade')>=Revered
		.' Become Exalted with Argent Crusade |condition rep('Argent Crusade')==Exalted
	step
		'Congratulations! You are now Exalted with the _Argent Crusade_!
]])

--------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
--------------------------------------------------------------------------------------------------------------------------------------
-- DARKMOON FAIRE --
ZygorGuidesViewer:RegisterInclude("A_Darkmoon_Faire_Dailies",[[
	step
		|fly Goldshire
	step
		goto Elwynn Forest,41.8,69.5
		.click the Portal to Darkmoon Island
		.' Telport to Darkmoon Island |goto Darkmoon Island |noway |c
	step
		goto Darkmoon Island,56.0,52.9 |n
		.' Follow the Path to the Darkmoon Faire |goto Darkmoon Island,56.0,52.9,1 |noway |c
	step
		goto Darkmoon Island,54.3,53.1
		.talk Zina Sharpworth##55266
		.buy Sack o' Tokens##78906 |n
		.' Open your Sack o' Tokens in your bags |use Sack o' Tokens##78906
		.collect 20 Darkmoon Faire Game Tokens##71083
	step
		goto Darkmoon Island,53.3,54.4
		.talk Mola##54601
		..accept It's Hammer Time##29463 |daily
	step
		goto Darkmoon Island,53.3,54.4
		.talk Mola##54601
		.' Tell her:
		.' <Ready to whack!> |havebuff Interface\Icons\inv_hammer_32
	step
		.' Use the _Whack!_ on your bar and whack the Gnolls in the Barrels
		.' The Gnolls  will pop up in the Barrels, but be careful not to hit the _Doll_ or you will get stunned.
		.' Whack 30 Gnolls |q 29463/1
	step
		goto Darkmoon Island,53.3,54.4
		.talk Mola##54601
		..turnin It's Hammer Time##29463
	step
		goto Darkmoon Island,52.5,56.2
		.talk Maxima Blastenheimer##15303
		..accept The Humanoid Cannonball##29436 |daily
		|next "quest"
	step
	label	"target"
		goto Darkmoon Island,57.1,89.6
		.talk Teleportologist Fozlebub##57850
		.' Tell him:
		.' <Teleport me to the cannon.> |goto 52.7,56.0,1 |noway |c
	step
	label	"quest"
		goto Darkmoon Island,52.5,56.2
		.talk Maxima Blastenheimer##15303
		.' Tell her:
		.' <Launch me!>
		'Wait for the Cannon to Launch you |havebuff Interface\Icons\Spell_Magic_FeatherFall
	step
		goto Darkmoon Island,56.4,93.3
		.' You will be launched throught the air. 
		.' Use the ability on your action bar to drop dpwn into the target. You will gain more points for getting closer to the middle.
		.' Earn 5 Target Points |q 29436/1
		.' Click here to try again |confirm |next "target"
	step
		goto Darkmoon Island,57.1,89.6
		.talk Teleportologist Fozlebub##57850
		.' Tell him:
		.' <Teleport me to the cannon.> |goto 52.7,56.0,1 |noway |c
	step
		goto Darkmoon Island,52.5,56.2
		.talk Maxima Blastenheimer##15303
		..turnin The Humanoid Cannonball##29436
	step
		goto 49.3,60.8
		.talk Rinling##14841
		..accept He Shoots, He Scores!##29438 |daily
	step
		goto 49.3,60.8
		.talk Rinling##14841	
		.' Tell him:
		.' <Let's shoot!> |havebuff Interface\Icons\INV_Weapon_Rifle_05
	step
		'Shoot at the 3 targets. 
		.' When you see a green marker appear over a target, make sure that you are aimed at it and _shoot_ |tip To aim, simply move the camera to face your current target.
		.' Shoot 25 Targets |q 29438/1
	step
		goto 49.3,60.8
		.talk Rinling##14841
		..turnin He Shoots, He Scores!##29438 |daily
	step
		goto Darkmoon Island,50.7,65.1
		.talk Finlay Coolshot##54605
		..accept Tonk Commander##29434 |daily
	step
		goto Darkmoon Island,50.7,65.1
		.talk Finlay Coolshot##54605
		.' Tell him:
		.' <Ready to Play.> |invehicle |c
	step
		'Use your _Cannon_ ability to shoot _Tonk Targets_.
		.from Tonk Target##33081+
		.' Destroy 30 Tonk Targets |q 29434/1
	step
		goto Darkmoon Island,50.7,65.1
		.talk Finlay Coolshot##54605
		..turnin Tonk Commander##29434
	step
		goto 51.6,77.8
		.talk Jessica Rogers##54485
		..accept Target: Turtle##29455 |daily
	step
		goto 51.6,77.8
		.talk Jessica Rogers##54485
		.' Tell her: 
		.' <Ready to play!> |havebuff Interface\Icons\INV_Jewelry_Ring_03
	step
		'Use your _Ring Toss_ ability to throw rings on the turtle.  |tip When aiming, move the marker over the middle of the turtle.
		.' Land 3 Rings on Dubenko |q 29455/1
		'|modelnpc 54490
	step
		goto 51.6,77.8
		.talk Jessica Rogers##54485
		..turnin Target: Turtle##29455
]])

ZygorGuidesViewer:RegisterInclude("A_Darkmoon_Faire_Quests",[[
	step
		|fly Goldshire
	step
		goto Elwynn Forest,41.8,69.5
		.click the Portal to Darkmoon Island
		.' Telport to Darkmoon Island |goto Darkmoon Island |noway |c
	step
		goto Darkmoon Island,56.0,52.9 |n
		.' Follow the Path to the Darkmoon Faire |goto Darkmoon Island,56.0,52.9,1 |noway |c
	step
		goto Darkmoon Island,51.9,60.9
		.talk Professor Thaddeus Paleo##14847
		..accept Fun for the Little Ones##29507
		|only if skill("Archaeology")>74
	step
		goto Darkmoon Island,49.3,60.8
		.talk Rinling##14841
		..accept Talkin' Tonks##29511
		|only if skill("Engineering")>74
	step
		goto Darkmoon Island,49.3,60.7
		.talk Rinling##14841
		..accept Rearm, Reuse, Recycle##29518
		|only if skill("Mining")>74
	step
		goto 49.3,60.9
		.talk Rinling##14841
		..accept Eyes on the Prizes##29517
		|only if skill("Leatherworking")>74
	step
		goto Darkmoon Island,52.9,68.0
		.talk Stamp Thunderhorn##14845
		..accept Putting the Crunch in the Frog##29509
		|only if skill("Cooking")>74
	step
		goto Darkmoon Island,52.9,68.0
		.talk Stamp Thunderhorn##14845		
		..accept Spoilin' for Salty Sea Dogs##29513
		|only if skill("Fishing")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..accept Putting the Carnies Back Together Again##29512
		|only if skill("First Aid")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..accept Tan My Hide##29519
		|only if skill("Skinning")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..accept Herbs for Healing##29514
		|only if skill("Herbalism")>74
	step
		goto 50.5,69.6
		.talk Sylannia##14844
		..accept A Fizzy Fusion##29506
		|only if skill("Alchemy")>74
	step
		goto 55.0,70.8
		.talk Chronos##14833
		..accept Keeping the Faire Sparkling##29516
		|only if skill("Jewelcrafting")>74
	step
		goto Darkmoon Island,53.2,75.8
		.talk Sayge##14822
		..accept Putting Trash to Good Use##29510
		|only if skill("Enchanting")>74
	step
		goto Darkmoon Island,51.1,82.0
		.talk Yebb Neblegear##14829
		..accept Baby Needs Two Pair of Shoes##29508
		|only if skill("Blacksmithing")>74
	step
		goto 52.5,88.7
		.buy Fishing Pole##6256
		|only if skill("Fishing")>74
	step
		goto Darkmoon Island,51.7,91.6
		.' Equip your Fishing Pole |equipped Fishing Pole##6256 |use Fishing Pole##6256 |q 29513
		.' Use your Fishing ability to catch _Sea Herrings_ |cast Fishing##7620
		.' Catch 5 Great Sea Herring |q 29513/1
		|only if skill("Fishing")>74
	step
		goto Darkmoon Island,47.9,74.5
		.' Use your Darkmoon Bandage on Injured Carnies |use Darkmoon Bandage##71978
		.' Heal 4 Injured Carnies |q 29512/1
		'|modelnpc 54518
		|only if skill("First Aid")>74
	step
		'All around the Island
		.click Discarded Weapon##10777+
		.collect 6 Discarded Weapon##72018 |n
		.' Disenchant the Discarded Weapons |use Discarded Weapon##72018
		.' Collect 6 Soothsayer's Dust |q 28825/1
	step
		'All around the Island
		.click Tonk Scrap##6314
		.' Collect 6 pieces of Tonk Scrap |q 29518/1
		|only if skill("Mining")>74
		'|model 7975
	step
		'All around the Island
		.click Bits of Glass##238
		.collect 5 Bits of Glass##72052 |n
		.' Click the Bits of Glass in your bags |use Bit of Glass##72052
		.' Make 5 Sparkling Gemstones |q 29516/1
		|only if skill("Jewelcrafting")>74
	step
		.' All around the Island
		.' Use your Battered Wrench to repair Damaged Tonk's |use Battered Wrench##72110
		.' Repair 5 Damaged Tonk's |q 29511/1
		'|modelnpc 54504
		|only if skill("Engineering")>74
	step
		.' All around the Island
		.click Darkblossom##209284
		.' Gather 6 Darkblossom |q 29514/1
		|only if skill("Herbalism")>74
	step
		.' All around the Island
		.click Staked Skins##10750
		.' Scrape 4 Staked Skins |q 29519/1
	step
		goto 50.5,69.6
		.talk Sylannia##14844
		.buy 5 Fizzy Faire Drink##19299 |q 29506
		|only if skill("Alchemy")>74
	step
		 goto Darkmoon Island,50.7,90.8
		.click Portal to Elwynn Forest##04396
		.' Teleport to Elwynn Forest |goto Elwynn Forest |noway |c
		|only if skill("Cooking")>74 or skill("Alchemy")>74 or skill("Archaeology")>74
	step
		goto Elwynn Forest,43.8,65.8
		.talk Innkeeper Farley##295
		.buy 5 Moonberry Juice##1645 |q 29506
		|only if skill("Alchemy")>74
	step
		goto Stormwind City,77.6,53.0
		.talk Erika Tate##5483
		.buy 5 Simple Flour##30817 |q 29509
		|only if skill("Cooking")>74
	step
		'Open your world map, find dig sites in Kalimdor and go to them |tip They look like small shovel icons on your world map that spawn in random places.  Once you get to the zone where the dig site is located, you will see the dig site on your map as a red highlighted area.
		.' You can find _Fossil Fragments_ in these locations: 
		.' Desolace
		.' Dustwallow Marsh
		.' Stonetalon Mountains
		.' Southern Barrens
		.' Tanaris
		.' Un'Goro Crater
		.' Use your Survey ability inside the dig site area and follow the Telesope until you find a fragment |cast Survey##80451
		.earn 15 Fossil Fragments##393 |q 29507
		|only if skill("Archaeology")>74
	step
		 goto Elwynn Forest,41.8,69.6
		.click Portal to Darkmoon Island
		.' Telport to Darkmoon Island |goto Darkmoon Island |noway |c
		|only if skill("Cooking")>74 or skill("Alchemy")>74 or skill("Archaeology")>74
	step
		goto Darkmoon Island,56.0,52.9 |n
		.' Follow the Path to the Darkmoon Faire |goto Darkmoon Island,56.0,52.9,1 |noway |c
		|only if skill("Cooking")>74 or skill("Alchemy")>74 or skill("Archaeology")>74
	step
		goto Darkmoon Island,50.4,69.5
		.' Use the Cocktail Shaker in your bags to make Moonberry Fizz |use Cocktail Shaker##72043
		.' Create 5 Sevings of Moonberry Fizz |q 29506/1
		|only if skill("Alchemy")>74
	step
		goto Darkmoon Island,52.7,68.1
		.' Click the Plump Frogs in your bags |use Plump Frogs##72056
		.collect 5 Breaded Frog##72057 |n
		.' Throw the Breaded Frogs in the cauldron |use Breaded Frog##72057
		.' Fry 5 Crunchy Frogs |q 29509/1
		|only if skill("Cooking")>74
	step
		goto 55.3,71.7
		.' Use the Iron Stock in your bags to make Horseshoes |use Iron Stock##71964
		.collect 4 Horseshoes##71967 |q 29508
		|only if skill("Blacksmithing")>74
	step
		goto Darkmoon Island,51.9,60.9
		.talk Professor Thaddeus Paleo##14847
		..turnin Fun for the Little Ones##29507
		|only if skill("Archaeology")>74
	step
		goto Darkmoon Island,52.9,68.0
		.talk Stamp Thunderhorn##14845
		..turnin Putting the Crunch in the Frog##29509
		|only if skill("Cooking")>74
	step
		goto Darkmoon Island,52.9,68.0
		.talk Stamp Thunderhorn##14845		
		..turnin Spoilin' for Salty Sea Dogs##29513
		|only if skill("Fishing")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..turnin Putting the Carnies Back Together Again##29512
		|only if skill("First Aid")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..accept Tan My Hide##29519
		|only if skill("Skinning")>74
	step
		goto 55.0,70.8
		.talk Chronos##14833
		..turnin Keeping the Faire Sparkling##29516
		|only if skill("Jewelcrafting")>74
	step
		goto Darkmoon Island,49.3,60.8
		.talk Rinling##14841
		..turnin Talkin' Tonks##29511
		|only if skill("Engineering")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..turnin Herbs for Healing##29514
		|only if skill("Herbalism")>74
	step
		goto 50.5,69.6
		.talk Sylannia##14844
		..turnin A Fizzy Fusion##29506
		|only if skill("Alchemy")>74
	step
		goto Darkmoon Island,49.3,60.7
		.talk Rinling##14841
		..accept Rearm, Reuse, Recycle##29518
		|only if skill("Mining")>74
	step
		goto Darkmoon Island,53.2,75.8
		.talk Sayge##14822
		..accept Putting Trash to Good Use##29510
		|only if skill("Enchanting")>74
	step
		goto Darkmoon Island,51.3,81.8
		.' Use the Horshoes in your bag on Baby|use Horseshoe##71967
		.' Put New Horshoes On Baby |q 29508/1
		|only if skill("Blacksmithing")>74
		'|modelnpc 54510
	step
		goto Darkmoon Island,51.1,82.0
		.talk Yebb Neblegear##14829
		..turnin Baby Needs Two Pair of Shoes##29508
		|only if skill("Blacksmithing")>74
	step
		goto Darkmoon Island,47.9,67.1
		.talk Kerri Hicks##14832
		..accept Test Your Strength##29433
	step
		goto Darkmoon Island,55.6,55.0
		.talk Selina Dourman##10445
		.' Tell her:
		.' <Darkmoon Adventurer's Guide?>
		.collect Darkmoon Adventurer's Guide##71634 |q 29433
	step
		'These next 3 items have to be _obtained from Battlegrounds_
		.' When you kill an opponent, _loot_ their body for a chance to get _each item_.
		.collect Adventurer's Journal##71953 |n
		.accept The Captured Journal##29458 |use Adventurer's Journal##71953
		.collect Banner of the Fallen##71951 |n
		.accept A Captured Banner##29456 |use Banner of the Fallen##71951
		.collect Captured Insignia##71952 |n
		.accept The Enemy's Insignia##29457 |use Captured Insignia##71952
	step
		'These next 4 items have to be _obtained from Dungeons_ listed below
		.collect Mysterious Grimoire##71637 |n |tip You can get this in Zul'Farrak from Hydromancer Velratha
		..accept An Inriguing Grimoire##29445 |use Mysterious Grimoire##71637
		.collect Monstrous Egg##71636 |n |tip You can get this in Zul'Farrak from Gahz'rilla
		..accept An Exotic Egg##29444 |use Monstrous Egg##71636
		.collect A Treatise on Strategy##7175 |n |tip You can get this in Grim Batol from General Umbriss
		..accept The Master Strategist##29451 |use A Treatise on Strategy##7175
		.collect Ornate Weapon##71638 |n |tip You can get this in Scarlet Monastery from Herod
		..accept A Wondrous Weapon##29446 |use Ornate Weapon##71638
		.collect Imbued Crystal##71635 |n |tip You can get this in Scarlet Monastery from High Inquisitor Whitemane
		..accept A Curious Crystal##29443 |use Imbued Crystal##71635
	step
		'The next item can only be obtained from any 10 man Cataclysm Raid Boss
		.collect Soothsayer's Runes##71716 |n
		..accept Tools of Divination##29464 |use Soothsayer's Runes##71716
	step
		.' Kill any Creature Player or NPC that gives _experience or honor_ to gain Grisly Trophies |tip You need to leave Darkmoon Island to find anything to kill.
		.' Collect 250 Grisly Trophy's |q 29433/1
	step
		goto Darkmoon Island,47.9,67.1
		.talk Kerri Hicks##14832
		..turnin Test Your Strength##29433
	step
		goto Darkmoon Island,51.9,60.9
		.talk Professor Thaddeus Paleo##14847
		..turnin The Captured Journal##29458
		..turnin A Captured Banner##29456
		..turnin The Enemy's Insignia##29457
		..turnin An Inriguing Grimoire##29445
		..turnin An Exotic Egg##29444
		..turnin The Master Strategist##29451
		..turnin A Wondrous Weapon##29446
		..turnin A Curious Crystal##29443
		..turnin Tools of Divination##29464		
]])

ZygorGuidesViewer:RegisterInclude("A_Darkmoon_Faire_Achievements",[[
	step
	label	"main"
		'To earn Achievements for the Darkmoon Faire, you will need to complete Dailies, Quests and other things. 
		.' Click here to do the Dailies Achievements |confirm always |next "dailies" |or
		.' or
		.' Click here to do the Profession Quests Achievements |confirm always |next "professions" |or
		.' or
		.' Click here for the Non-Questing Achievements |confirm always |next "no_quest" |or
	step
	label	"dailies"
		'You have earned the Achievement Bullseye! |achieve 6021 |only if achieved(6021)
		.' You still need to earn the Achievement Bullseye! |achieve 6021 |only if not achieved(6021)
		.' You have earned the Achievement Quick Shot! |achieve 6022 |only if achieved(6022)
		.' You still need to earn the Achievement Quick Shot! |achieve 6022 |only if not achieved(6022)
		.' You have earned the Achievement Step Right Up! |achieve 6020 |only if achieved(6020)
		.' You still need to earn the Achievement Step Right Up! |achieve 6020 |only if not achieved(6020)
		|confirm always
	step
		|fly Goldshire
	step
		 goto Darkmoon Island,50.7,90.8
		.click Portal to Elwynn Forest##04396
		.' Teleport to Elwynn Forest |goto Elwynn Forest |noway |c
	step
		goto Darkmoon Island,56.0,52.9 |n
		.' Follow the Path to the Darkmoon Faire |goto Darkmoon Island,56.0,52.9,1 |noway |c
	step
		goto Darkmoon Island,54.3,53.1
		.talk Zina Sharpworth##55266
		.buy Sack o' Tokens##78909 |n
		.' Open your Sack o' Tokens in your bags |use Sack o' Tokens##78909
		.collect 20 Darkmoon Faire Game Tokens##71083
	step
		goto Darkmoon Island,53.3,54.4
		.talk Mola##54601
		..accept It's Hammer Time##29463 |daily
	step
		goto Darkmoon Island,53.3,54.4
		.talk Mola##54601
		.' Tell her:
		.' <Ready to whack!> |havebuff Interface\Icons\inv_hammer_32
	step
		.' Use the _Whack!_ on your bar and whack the Gnolls in the Barrels
		.' The Gnolls  will pop up in the Barrels, but be careful not to hit the _Doll_ or you will get stunned.
		.' Whack 30 Gnolls |q 29463/1
	step
		goto Darkmoon Island,53.3,54.4
		.talk Mola##54601
		..turnin It's Hammer Time##29463
	step
		goto Darkmoon Island,52.5,56.2
		.talk Maxima Blastenheimer##15303
		..accept The Humanoid Cannonball##29436 |daily
		|next "quest"
	step
	label	"target"
		goto Darkmoon Island,57.1,89.6
		.talk Teleportologist Fozlebub##57850
		.' Tell him:
		.' <Teleport me to the cannon.> |goto 52.7,56.0,1 |noway |c
	step
	label	"quest"
		goto Darkmoon Island,52.5,56.2
		.talk Maxima Blastenheimer##15303
		.' Tell her:
		.' <Launch me!>
		'Wait for the Cannon to Launch you |havebuff Interface\Icons\Spell_Magic_FeatherFall
	step
		goto Darkmoon Island,56.4,93.3
		.' You will be launched through the air. 
		.' Use the ability on your action bar to drop down into the target. You will gain more points for getting closer to the middle.
		.' Earn 5 Target Points |q 29436/1
		.' Score a Bullseye by landing in the middle of the target
		.' Earn the Achievement Bullseye! |achieve 6021
		.' Click here to try again |confirm |next "target"
	step
		goto Darkmoon Island,57.1,89.6
		.talk Teleportologist Fozlebub##57850
		.' Tell him:
		.' <Teleport me to the cannon.> |goto 52.7,56.0,1 |noway |c
	step
		goto Darkmoon Island,52.5,56.2
		.talk Maxima Blastenheimer##15303
		..turnin The Humanoid Cannonball##29436
	step
		goto 49.3,60.8
		.talk Rinling##14841
		..accept He Shoots, He Scores!##29438 |daily
	step
		goto 49.3,60.8
		.talk Rinling##14841	
		.' Tell him:
		.' <Let's shoot!> |havebuff Interface\Icons\INV_Weapon_Rifle_05
	step
		'Shoot at the 3 targets. 
		.' When you see a green marker appear over a target, make sure that you are aimed at it and _shoot_ |tip To aim, simply move the camera to face your current target.
		.' Shoot 25 Targets |q 29438/1
		.' Shoot your gun and hit a target very fast
		.' Earn the Achievement Quick Shot! |achieve 6022
	step
		goto 49.3,60.8
		.talk Rinling##14841
		..turnin He Shoots, He Scores!##29438 |daily
	step
		goto Darkmoon Island,50.7,65.1
		.talk Finlay Coolshot##54605
		..accept Tonk Commander##29434 |daily
	step
		goto Darkmoon Island,50.7,65.1
		.talk Finlay Coolshot##54605
		.' Tell him:
		.' <Ready to Play.> |invehicle |c
	step
		'Use your _Cannon_ ability to shoot _Tonk Targets_.
		.from Tonk Target##33081+
		.' Destroy 30 Tonk Targets |q 29434/1
	step
		goto Darkmoon Island,50.7,65.1
		.talk Finlay Coolshot##54605
		..turnin Tonk Commander##29434
	step
		goto 51.6,77.8
		.talk Jessica Rogers##54485
		..accept Target: Turtle##29455 |daily
	step
		goto 51.6,77.8
		.talk Jessica Rogers##54485
		.' Tell her: 
		.' <Ready to play!> |havebuff Interface\Icons\INV_Jewelry_Ring_03
	step
		'Use your _Ring Toss_ ability to throw rings on the turtle.  |tip When aiming, move the marker over the middle of the turtle.
		.' Land 3 Rings on Dubenko |q 29455/1
		.' Earn the Achievement Step Right Up! |achieve 6020
		'|modelnpc 54490
	step
		goto 51.6,77.8
		.talk Jessica Rogers##54485
		..turnin Target: Turtle##29455
		|next "main"
	step
	label	"professions"
		'You have earned the Achievement Faire Favors |achieve 6032 |only if achieved(6032)
		.' You still need to earn the Achievement Faire Favors |achieve 6032 |only if not achieved(6032)
		.' You have earned the Achievement Darkmoon Dungeoneer |achieve 6027 |only if achieved(6027)
		.' You still need to earn the Achievement Darkmoon Dungeoneer |achieve 6027 |only if not achieved(6027)
		.' You have earned the Achievement Darkmoon Defender |achieve 6028 |only if achieved(6028)
		.' You still need to earn the Achievement Darkmoon Defender |achieve 6028 |only if not achieved(6028)
		.' You have earned the Achievement Darkmoon Despoiler |achieve 6029 |only if achieved(6029)
		.' You still need to earn the Achievement Darkmoon Despoiler |achieve 6029 |only if not achieved(6029) |tip   
		|confirm always
	step
		|fly Goldshire
	step
		goto Elwynn Forest,41.8,69.5
		.click the Portal to Darkmoon Island
		.' Telport to Darkmoon Island |goto Darkmoon Island |noway |c
	step
		goto Darkmoon Island,56.0,52.9 |n
		.' Follow the Path to the Darkmoon Faire |goto Darkmoon Island,56.0,52.9,1 |noway |c
	step
		goto Darkmoon Island,51.9,60.9
		.talk Professor Thaddeus Paleo##14847
		..accept Fun for the Little Ones##29507
		|only if skill("Archaeology")>74
	step
		goto Darkmoon Island,49.3,60.8
		.talk Rinling##14841
		..accept Talkin' Tonks##29511
		|only if skill("Engineering")>74
	step
		goto Darkmoon Island,49.3,60.7
		.talk Rinling##14841
		..accept Rearm, Reuse, Recycle##29518
		|only if skill("Mining")>74
	step
		goto 49.3,60.9
		.talk Rinling##14841
		..accept Eyes on the Prizes##29517
		|only if skill("Leatherworking")>74
	step
		goto Darkmoon Island,52.9,68.0
		.talk Stamp Thunderhorn##14845
		..accept Putting the Crunch in the Frog##29509
		|only if skill("Cooking")>74
	step
		goto Darkmoon Island,52.9,68.0
		.talk Stamp Thunderhorn##14845		
		..accept Spoilin' for Salty Sea Dogs##29513
		|only if skill("Fishing")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..accept Putting the Carnies Back Together Again##29512
		|only if skill("First Aid")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..accept Tan My Hide##29519
		|only if skill("Skinning")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..accept Herbs for Healing##29514
		|only if skill("Herbalism")>74
	step
		goto 50.5,69.6
		.talk Sylannia##14844
		..accept A Fizzy Fusion##29506
		|only if skill("Alchemy")>74
	step
		goto 55.0,70.8
		.talk Chronos##14833
		..accept Keeping the Faire Sparkling##29516
		|only if skill("Jewelcrafting")>74
	step
		goto Darkmoon Island,53.2,75.8
		.talk Sayge##14822
		..accept Putting Trash to Good Use##29510
		|only if skill("Enchanting")>74
	step
		goto Darkmoon Island,51.1,82.0
		.talk Yebb Neblegear##14829
		..accept Baby Needs Two Pair of Shoes##29508
		|only if skill("Blacksmithing")>74
	step
		goto 52.5,88.7
		.buy Fishing Pole##6256
		|only if skill("Fishing")>74
	step
		goto Darkmoon Island,51.7,91.6
		.' Equip your Fishing Pole |equipped Fishing Pole##6256 |use Fishing Pole##6256 |q 29513
		.' Use your Fishing ability to catch _Sea Herrings_ |cast Fishing##7620
		.' Catch 5 Great Sea Herring |q 29513/1
		|only if skill("Fishing")>74
	step
		goto Darkmoon Island,47.9,74.5
		.' Use your Darkmoon Bandage on Injured Carnies |use Darkmoon Bandage##71978
		.' Heal 4 Injured Carnies |q 29512/1
		'|modelnpc 54518
		|only if skill("First Aid")>74
	step
		'All around the Island
		.click Discarded Weapon##10777+
		.collect 6 Discarded Weapon##72018 |n
		.' Disenchant the Discarded Weapons |use Discarded Weapon##72018
		.' Collect 6 Soothsayer's Dust |q 28825/1
	step
		'All around the Island
		.click Tonk Scrap##6314
		.' Collect 6 pieces of Tonk Scrap |q 29518/1
		|only if skill("Mining")>74
		'|model 7975
	step
		'All around the Island
		.click Bits of Glass##238
		.collect 5 Bits of Glass##72052 |n
		.' Click the Bits of Glass in your bags |use Bit of Glass##72052
		.' Make 5 Sparkling Gemstones |q 29516/1
		|only if skill("Jewelcrafting")>74
	step
		.' All around the Island
		.' Use your Battered Wrench to repair Damaged Tonk's |use Battered Wrench##72110
		.' Repair 5 Damaged Tonk's |q 29511/1
		'|modelnpc 54504
		|only if skill("Engineering")>74
	step
		.' All around the Island
		.click Darkblossom##209284
		.' Gather 6 Darkblossom |q 29514/1
		|only if skill("Herbalism")>74
	step
		.' All around the Island
		.click Staked Skins##10750
		.' Scrape 4 Staked Skins |q 29519/1
	step
		goto 50.5,69.6
		.talk Sylannia##14844
		.buy 5 Fizzy Faire Drink##19299 |q 29506
		|only if skill("Alchemy")>74
	step
		 goto Darkmoon Island,50.7,90.8
		.click Portal to Elwynn Forest##04396
		.' Teleport to Elwynn Forest |goto Elwynn Forest |noway |c
		|only if skill("Cooking")>74 or skill("Alchemy")>74 or skill("Archaeology")>74
	step
		goto Elwynn Forest,43.8,65.8
		.talk Innkeeper Farley##295
		.buy 5 Moonberry Juice##1645 |q 29506
		|only if skill("Alchemy")>74
	step
		goto Stormwind City,77.6,53.0
		.talk Erika Tate##5483
		.buy 5 Simple Flour##30817 |q 29509
		|only if skill("Cooking")>74
	step
		'Open your world map, find dig sites in Kalimdor and go to them |tip They look like small shovel icons on your world map that spawn in random places.  Once you get to the zone where the dig site is located, you will see the dig site on your map as a red highlighted area.
		.' You can find _Fossil Fragments_ in these locations: 
		.' Desolace
		.' Dustwallow Marsh
		.' Stonetalon Mountains
		.' Southern Barrens
		.' Tanaris
		.' Un'Goro Crater
		.' Use your Survey ability inside the dig site area and follow the Telesope until you find a fragment |cast Survey##80451
		.earn 15 Fossil Fragments##393 |q 29507
		|only if skill("Archaeology")>74
	step
		 goto Elwynn Forest,41.8,69.6
		.click Portal to Darkmoon Island
		.' Telport to Darkmoon Island |goto Darkmoon Island |noway |c
		|only if skill("Cooking")>74 or skill("Alchemy")>74 or skill("Archaeology")>74
	step
		goto Darkmoon Island,56.0,52.9 |n
		.' Follow the Path to the Darkmoon Faire |goto Darkmoon Island,56.0,52.9,1 |noway |c
		|only if skill("Cooking")>74 or skill("Alchemy")>74 or skill("Archaeology")>74
	step
		goto Darkmoon Island,50.4,69.5
		.' Use the Cocktail Shaker in your bags to make Moonberry Fizz |use Cocktail Shaker##72043
		.' Create 5 Sevings of Moonberry Fizz |q 29506/1
		|only if skill("Alchemy")>74
	step
		goto Darkmoon Island,52.7,68.1
		.' Click the Plump Frogs in your bags |use Plump Frogs##72056
		.collect 5 Breaded Frog##72057 |n
		.' Throw the Breaded Frogs in the cauldron |use Breaded Frog##72057
		.' Fry 5 Crunchy Frogs |q 29509/1
		|only if skill("Cooking")>74
	step
		goto 55.3,71.7
		.' Use the Iron Stock in your bags to make Horseshoes |use Iron Stock##71964
		.collect 4 Horseshoes##71967 |q 29508
		|only if skill("Blacksmithing")>74
	step
		goto Darkmoon Island,51.9,60.9
		.talk Professor Thaddeus Paleo##14847
		..turnin Fun for the Little Ones##29507
		|only if skill("Archaeology")>74
	step
		goto Darkmoon Island,52.9,68.0
		.talk Stamp Thunderhorn##14845
		..turnin Putting the Crunch in the Frog##29509
		|only if skill("Cooking")>74
	step
		goto Darkmoon Island,52.9,68.0
		.talk Stamp Thunderhorn##14845		
		..turnin Spoilin' for Salty Sea Dogs##29513
		|only if skill("Fishing")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..turnin Putting the Carnies Back Together Again##29512
		|only if skill("First Aid")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..accept Tan My Hide##29519
		|only if skill("Skinning")>74
	step
		goto 55.0,70.8
		.talk Chronos##14833
		..turnin Keeping the Faire Sparkling##29516
		|only if skill("Jewelcrafting")>74
	step
		goto Darkmoon Island,49.3,60.8
		.talk Rinling##14841
		..turnin Talkin' Tonks##29511
		|only if skill("Engineering")>74
	step
		goto Darkmoon Island,55.0,70.8
		.talk Chronos##14833
		..turnin Herbs for Healing##29514
		|only if skill("Herbalism")>74
	step
		goto 50.5,69.6
		.talk Sylannia##14844
		..turnin A Fizzy Fusion##29506
		|only if skill("Alchemy")>74
	step
		goto Darkmoon Island,49.3,60.7
		.talk Rinling##14841
		..accept Rearm, Reuse, Recycle##29518
		|only if skill("Mining")>74
	step
		goto Darkmoon Island,53.2,75.8
		.talk Sayge##14822
		..accept Putting Trash to Good Use##29510
		|only if skill("Enchanting")>74
	step
		goto Darkmoon Island,51.3,81.8
		.' Use the Horshoes in your bag on Baby|use Horseshoe##71967
		.' Put New Horshoes On Baby |q 29508/1
		|only if skill("Blacksmithing")>74
		'|modelnpc 54510
	step
		goto Darkmoon Island,51.1,82.0
		.talk Yebb Neblegear##14829
		..turnin Baby Needs Two Pair of Shoes##29508
		|only if skill("Blacksmithing")>74
	step
		goto Darkmoon Island,47.9,67.1
		.talk Kerri Hicks##14832
		..accept Test Your Strength##29433
	step
		goto Darkmoon Island,55.6,55.0
		.talk Selina Dourman##10445
		.' Tell her:
		.' <Darkmoon Adventurer's Guide?>
		.collect Darkmoon Adventurer's Guide##71634 |q 29433
	step
		'These next 3 items have to be _obtained from Battlegrounds_
		.' When you kill an opponent, _loot_ their body for a chance to get _each item_.
		.collect Adventurer's Journal##71953 |n
		.accept The Captured Journal##29458 |use Adventurer's Journal##71953
		.collect Banner of the Fallen##71951 |n
		.accept A Captured Banner##29456 |use Banner of the Fallen##71951
		.collect Captured Insignia##71952 |n
		.accept The Enemy's Insignia##29457 |use Captured Insignia##71952
	step
		'These next 4 items have to be _obtained from Dungeons_ listed below
		.collect Mysterious Grimoire##71637 |n |tip You can get this in Zul'Farrak from Hydromancer Velratha
		..accept An Inriguing Grimoire##29445 |use Mysterious Grimoire##71637
		.collect Monstrous Egg##71636 |n |tip You can get this in Zul'Farrak from Gahz'rilla
		..accept An Exotic Egg##29444 |use Monstrous Egg##71636
		.collect A Treatise on Strategy##7175 |n |tip You can get this in Grim Batol from General Umbriss
		..accept The Master Strategist##29451 |use A Treatise on Strategy##7175
		.collect Ornate Weapon##71638 |n |tip You can get this in Scarlet Monastery from Herod
		..accept A Wondrous Weapon##29446 |use Ornate Weapon##71638
		.collect Imbued Crystal##71635 |n |tip You can get this in Scarlet Monastery from High Inquisitor Whitemane
		..accept A Curious Crystal##29443 |use Imbued Crystal##71635
	step
		'The next item can only be obtained from any 10 man Cataclysm Raid Boss
		.collect Soothsayer's Runes##71716 |n
		..accept Tools of Divination##29464 |use Soothsayer's Runes##71716
	step
		.' Kill any Creature Player or NPC that gives _experiance or honor_ to gain Grisly Trophy's |tip You need to leave Darkmoon Island to find anything to kill.
		.' Collect 250 Grisly Trophy's |q 29433/1
	step
		goto Darkmoon Island,47.9,67.1
		.talk Kerri Hicks##14832
		..turnin Test Your Strength##29433
	step
		goto Darkmoon Island,51.9,60.9
		.talk Professor Thaddeus Paleo##14847
		..turnin The Captured Journal##29458
		..turnin A Captured Banner##29456
		..turnin The Enemy's Insignia##29457
		..turnin An Inriguing Grimoire##29445
		..turnin An Exotic Egg##29444
		..turnin The Master Strategist##29451
		..turnin A Wondrous Weapon##29446
		..turnin A Curious Crystal##29443
		..turnin Tools of Divination##29464
		.' Earn the Achievement Darkmoon Dungeoneer |achieve 6027
		.' Earn the Achievement Darkmoon Defender |achieve 6028
		.' Earn the Achievement Darkmoon Despoiler |achieve 6029
		|next "main"
	step
	label	"no_quest"
		'You have earned the Achievement Darkmoon Duelist! |achieve 6023 |only if achieved(6023)
		.' You still need to earn the Achievement Darkmoon Duelist! |achieve 6023 |only if not achieved(6023)
		'You have earned the Achievement Fairegoer's Feast! |achieve 6026 |only if achieved(6026)
		.' You still need to earn the Achievement Fairegoer's Feast! |achieve 6026 |only if not achieved(6026)
		'You have earned the Achievement Taking the Show on the Road! |achieve 6030 |only if achieved(6030)
		.' You still need to earn the Taking the Show on the Road! |achieve 6030 |only if not achieved(6030)
		'You have earned the Achievement I Was Promised a Pony! |achieve 6025 |only if achieved(6025)
		.' You still need to earn the I Was Promised a Pony! |achieve 6025 |only if not achieved(6025) |tip    
		|confirm always
	step
		goto Darkmoon Island,50.5,69.5
		.talk Sylannia##14844
		.buy Cheap Beer##19222 |n
		.' Drink Cheap Beer |achieve 6026/12 |use Cheap Beer##19222
		.buy Darkmoon Special Reserve##19221 |n
		.' Drink Darkmoon Special Reserve |achieve 6026/13 |use Special Reserve##19221
		.buy Fizzy Faire Drink##19299 |n
		.' Drink Fizzy Faire Drink |achieve 6026/14 |use Fizzy Faire Drink##19299
		.buy Bottled Winterspring Water##19300 |n
		.' Drink Bottled Winterspring Water |achieve 6026/11 |use Bottled Winterspring Water##19300
		.buy Iced Berry Slush##33234 |n
		.' Drink Iced Berry Slush |achieve 6026/17 |use Iced Berry Slush##33234
		.buy Fizzy Faire Drink "Classic"##33236 |n
		.' Drink Fizzy Faire Drink "Classic" |achieve 6026/15 |use Fizzy Faire Drink "Classic"##33236
		.buy Fresh-Squeezed Limeade##44941 |n
		.' Drink Fresh-Squeezed Limeade |achieve 6026/16 |use Fresh-Squeezed Limeade##44941
		.buy Sasparilla Sinker##74822 |n
		.' Drink Sasparilla Sinker |achieve 6026/18 |use Sasparilla Sinker##74822
	step
		goto Darkmoon Island,52.8,68.0
		.talk Stamp Thunderhorn##14845
		.buy Darkmoon Dog##19223 |n
		.' Eat Darkmoon Dog |achieve 6026/3 |use Darkmoon Dog##19223
		.buy Spiced Beef Jerky##19304 |n
		.' Eat Spiced Beef Jerky |achieve 6026/10 |use Spiced Beef Jerky##19304
		.buy Pickled Kodo Foot##19305 |n
		.' Eat Pickled Kodo Foot |achieve 6026/7 |use Pickled Kodo Foot##19305
		.buy Red Hot Wings##19224 |n
		.' Eat Red Hot Wings |achieve 6026/8 |use Red Hot Wings##19224
		.buy Crunchy Frog##19306 |n
		.' Eat Crunchy Frog |achieve 6026/2 |use Crunchy Frog##19306
		.buy Deep Fried Candybar##19225 |n
		.' Eat Deep Fried Candybar |achieve 6026/4 |use Deep Fried Candybar##19225
		.buy Funnel Cake##33246 |n
		.' Eat Funnel Cake |achieve 6026/6 |use Funnel Cake##33246 
		.buy Forest Strider Drumstick##33254 |n
		.' Eat Forest Strider Drumstick |achieve 6026/5 |use Forest Strider Drumstick##33254
		.buy Corn-Breaded Sausage##44940 |n
		.' Eat Corn-Breaded Sausage |achieve 6026/1 |use Corn-Breaded Sausage##44940
		.buy Salty Sea Dog##73260 |n
		.' Eat Salty Sea Dog |achieve 6026/9 |use Salty Sea Dog##73260
		.' Earn the Achievement Fairegoer's Feast |achieve 6026
	step
		goto Darkmoon Island,56.8,81.4
		.clicknpc Darkmoon Pony##55715
		.' Earn the Achievement I Was Promised a Pony |achieve 6025
	step
		goto Darkmoon Island,48.4,71.9
		.talk Boomie Sparks##55278
		.buy 6 Darkmoon Firework##74142 |future |achieve 6030
	step
		 goto Darkmoon Island,50.7,90.8
		.click Portal to Elwynn Forest##04396
		.' Teleport to Elwynn Forest |goto Elwynn Forest |noway |c
	step
		'Goto Stormwind |goto Stormwind City |c
		.' Use your Darkmoon Firework |achieve 6030/6 |use Darkmoon Firework##74142
	step
		|fly Ironforge
	step
		'Goto Ironforge |goto Ironforge |c
		.' Use your Darkmoon Firework |achieve 6030/4 |use Darkmoon Firework##74142
	step
		|fly Stormwind City
	step
		#include "rideto_ruttheranvillage"
	step
		goto Teldrassil,55.0,88.3
		.' Go through the Pink Portal here
		.' Teleport to Darnassus |goto Darnassus |noway |c
	step
		'Goto Darnassus |goto Darnassus |c
		.' Use your Darkmoon Firework |achieve 6030/2 |use Darkmoon Firework##74142
	step
		goto Darnassus,44.2,78.7
		.click Portal to Exodar##06955
		.' Teleport to The Exodar |goto The Exodar |noway |c
	step
		'Goto The Exodar |goto The Exodar |c
		.' Use your Darkmoon Firework |achieve 6030/3 |use Darkmoon Firework##74142
	step
		goto The Exodar,48.2,63.0
		.click Portal to Blasted Lands##09383
		.' Teleport to Blasted Lands |goto Blasted Lands |noway |c
	step
		goto Blasted Lands,54.9,54.2
		.' Go through the Green Portal here
		.' Teleport to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
	step
		|fly Shattrath
	step
		goto Shattrath City,63.8,41.7
		.' Use your Darkmoon Firework |achieve 6030/5 |use Darkmoon Firework##74142
	step
		goto Shattrath City,57.2,48.2
		.click Portal to Stormwind##04396
		.' Teleport to Stormwind |goto Stormwind City |noway |c
	step
		#include "rideto_borean"
	step
		|fly Dalaran
	step
		'Goto Dalaran |goto Dalaran |c
		.' Use your Darkmoon Firework |achieve 6030/1 |use Darkmoon Firework##74142
	step
		goto Dalaran,40.1,62.9
		.click Portal to Stormwind 
		.' Teleport to Stormwind City |goto Stormwind City |noway |c
	step
		|fly Goldshire
	step
		goto Elwynn Forest,41.8,69.5
		.click the Portal to Darkmoon Island
		.' Telport to Darkmoon Island |goto Darkmoon Island |noway |c
	step
		goto Darkmoon Island,56.0,52.9 |n
		.' Follow the Path to the Darkmoon Faire |goto Darkmoon Island,56.0,52.9,1 |noway |c
	step
		goto Darkmoon Island,46.8,78.8
		.' Click Darkmoon Deathmatch Gate and enter the Deathmatch Arena
		.' Once inside, you will need to fight anyone inside, if you win, you will earn an achievement.
		.' Earn the Achievement Darkmoon Duelist! |achieve 6023
		.' Deafeat 12 combatants in the Deathmatch Arena
		.' Earn the Achievement Darkmoon Dominator |achieve 6024
		|next "main"
]])

-- HALLOWS END --
ZygorGuidesViewer:RegisterInclude("Hallows_End_Quests_Alliance",[[
	step
		goto Stormwind City,61.7,74.2
		.talk Human Commoner##18927
		..accept Costumed Orphan Matron##11310/24/201156
		..accept A Season for Celebration##29074
	step
		'Go outside to Elwynn Forest |goto Elwynn Forest |noway |c
	step
		goto Elwynn Forest,32.0,50.4
		.talk Jesper##15310
		..accept Hallow's End Treats for Jesper!##8311
	step
		goto Elwynn Forest,32.0,50.5
		.talk Celestine of the Harvest##51665
		..turnin A Season for Celebration##29074
	step
		goto 32.4,50.9
		.talk Gretchen Fenlow##51934
		..accept A Friend in Need##29430
	step
		goto Elwynn Forest,42.6,64.4
		.talk Costumed Orphan Matron##24519
		..turnin Costumed Orphan Matron##11356
		..accept Fire Brigade Practice##11360
	step
		goto 42.5,64.5
		.' Click the Water Barrel |tip It looks like a huge bucket of water.
		.collect Water Bucket##32971 |q 11360
	step
		goto 42.6,60.2
		.' Use your Water Bucket on the burning scarecrows |use Water Bucket##32971
		.' Fight 5 Fires |q 11360/1
		.' Collect more Water Buckets from the Water Barrel at [42.7,62.0]
	step
		goto 42.6,64.4
		.talk Costumed Orphan Matron##24519
		..' You will only be able to accept 1 of the 2 daily quests
		..turnin Fire Training##11360
		..accept Stop the Fires!##11131 |or
		..accept "Let the Fires Come!"##12135|or
	step
		goto 42.5,64.5
		.' Click the Water Barrel |tip It looks like a huge bucket of water.
		.collect Water Bucket##32971 |q 11131
	step
		goto 42.4,65.6
		.' Use your Water Bucket on the fires all around this area |use Water Bucket##32971
		.' Put Out the Fires |q 11131/1 |tip You will need a group of people to complete this quest.  It is best to do this quest at peak hours.
		.' Collect more Water Buckets from the Water Barrel at [42.5,64.5]
	step
		goto 42.5,64.5
		.' Click the Water Barrel |tip It looks like a huge bucket of water.
		.collect Water Bucket##32971 |q 12135
	step
		goto 42.4,65.6
		.' Wait until the fires appear on the buildings in Goldshire
		.' Use your Water Bucket on the fires all around this area |use Water Bucket##32971
		.' Put Out the Fires |q 12135/1 |tip You will need a group of people to complete this quest.  It is best to do this quest at peak hours.
		.' Collect more Water Buckets from the Water Barrel at [42.5,64.5]
	step
		goto 42.4,65.9
		.' Click the Large Jack-o'-Lantern |tip It's a burning pumpkin laying in the road.
		..accept Smash the Pumpkin##12133
	step
		goto 42.6,64.4
		.talk Costumed Orphan Matron##24519
		..' You will only be able to accept 1 of the 2 daily quests
		..turnin Stop the Fires!##11131
		..turnin "Let the Fires Come!"##12135
		..turnin Smash the Pumpkin##12133
	step
		'Go northwest into Stormwind |goto Stormwind City |noway |c
	step
		goto 60.4,75.3
		.talk Innkeeper Allison##6740
		..accept Flexing for Nougat##8356
	step
		goto 60.4,75.3
		.' While targeting Inkeeper Allison:
		.' Flex for Innkeeper Allison |script DoEmote("FLEX") |q 8356/1
	step
		goto 60.4,75.3
		.talk Innkeeper Allison##6740
		..turnin Flexing for Nougat##8356
	step
		goto Stormwind City,60.1,75.1
		.talk Anson Hastings##53949
		..turnin A Friend in Need##29430
		..accept Missing Heirlooms##29392
	step
		goto Stormwind City,71.0,72.5
		.talk Dungar Longdrink##352
		.' Fly to Ironforge, Dun Morogh |goto Ironforge,55.9,47.9,0.5 |noway |c
	step
		goto Ironforge,18.1,51.5
		.talk Innkeeper Firebrew##5111
		..accept Chicken Clucking for a Mint##8353
	step
		goto 18.1,51.5
		.' While targeting Innkeeper Firebrew:
		.' Cluck like a Chicken for Innkeeper Firebrew |script DoEmote("CHICKEN") |q 8353/1
	step
		goto 18.1,51.5
		.talk Innkeeper Firebrew##5111
		..turnin Chicken Clucking for a Mint##8353
	step
		goto 36.4,3.6
		.talk Talvash del Kissel##6826
		..accept Incoming Gumdrop##8355
	step
		goto 36.4,3.6
		.' While targeting Talvash del Kissel:
		.' Make Train sounds for Talvash del Kissel |script DoEmote("TRAIN") |q 8355/1
	step
		goto 36.4,3.6
		.talk Talvash del Kissel##6826
		..turnin Incoming Gumdrop##8355
	step
		|fly Stormwind City
	step
		goto 24.0,44.8
		.talk Hired Courier##53950
		..turnin Missing Heirlooms##29392
		..accept Fencing the Goods##29398
	step
		goto 61.2,70.8
		.talk Auctioneer Fitch##8719
		.' Ask if anyone suspicious tried to list a crate of goods recently
		..turnin Fencing the Goods##29398
		..accept Shopping Around##29399
	step
		goto 64.2,46.3
		.talk Hudson Barnes##54021
		..turnin Shopping Around##29399 |tip You will have to wait until he finishes talking and the white question mark turns yellow to turn this in.
		..accept Taking Precautions##29402
	step
		goto Stormwind City,52.4,45.8
		.talk Brother Cassius##1351
		.buy 5 Arcane Powder##17020 |q 29402/2
	step
		goto 55.2,14.5
		.' Click Blood Nettle
		..get 5 Blood Nettle |q 29402/3
	step
		goto 55.9,85.6
		.talk Maria Lumere##1313
		..get 5 Crystal Vial |q 29402/1
	step
		goto 64.2,46.3
		.talk Hudson Barnes##54021
		..turnin Taking Precautions##29402
		..accept The Collector's Agent##29403
	step
		'Enter the Cathedral of Light |goto Stormwind City,52.7,50.5,0.5 |c
	step
		'Go down into the Cathedral of Light catacombs |goto 51.3,44.2 |c
	step
		goto 55.3,43.5
		.from Unleashed Void##54114+
		.' Click the Stolen Crate
		..turnin The Collector's Agent##29403
		..accept What Now?##29411
	step
		goto Stormwind City,60.1,75.1
		.talk Anson Hastings##53949
		..turnin What Now?##29411
	step
		goto 60.1,75.1
		.' Click Anson's Crate
		..turnin The Creepy Crate##29413
	step
		goto Stormwind City,22.6,56.0 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.1,88.5 |n
		.' Go inside the pink portal to Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,62.5,32.8
		.talk Innkeeper Saelienne##6735
		..accept Dancing for Marzipan##8357
	step
		goto 67.4,15.7
		.' While targeting Innkeeper Saelienne:
		.' Dance for Innkeeper Saelienne |script DoEmote("DANCE") |q 8357/1
	step
		goto 62.5,32.8
		.talk Innkeeper Saelienne##6735
		..turnin Dancing for Marzipan##8357
	step
		goto 36.8,50.5 |n
		.' Go inside the pink portal to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.0,93.7 |n
		.' Ride the boat to Stormwind |goto Stormwind City |noway |c
	step
		'Go outside to Elwynn Forest |goto Elwynn Forest |noway |c
	step
		goto Elwynn Forest,32.0,50.4
		.talk Jesper##15310
		..turnin Hallow's End Treats for Jesper!##8311
]])

ZygorGuidesViewer:RegisterInclude("Hallows_End_Dailies_Alliance",[[
	step
		goto Elwynn Forest,32.0,50.5
		.talk Celestine of the Harvest##51665
		..accept A Time to Gain##29075 |daily
	step
		goto Elwynn Forest,32.7,49.5
		.' Click the Bonfire
		.' Use the Bonfire |q 29075/1
	step
		goto Elwynn Forest,32.0,50.5
		.talk Celestine of the Harvest##51665
		..turnin A Time to Gain##29075
	step
		goto 32.1,50.6
		.talk Keira##52064
		..accept A Time to Lose##29371 |daily
	step
		goto 32.4,50.9
		.talk Gretchen Fenlow##51934
		..accept Stink Bombs Away!##29054 |daily
		..accept Clean Up in Stormwind##29144 |daily
	step
		goto Stormwind City,71.6,87.4
		.' Use Arcane Cleanser on Stink Bombs |tip They look like orange mists all around Stormwind. |use Arcane Cleanser##69191
		.' Remove 10 Stink Bombs |q 29144/1
		.' You can find more at [63.2,72.0]
		.' You can find more at [73.0,59.0]
		.' You can find more at [79.1,40.1]
		.' You can find more at [65.0,38.5]
		.' You can find more at [54.6,54.2]
		.' You can find more at [49.5,83.0]
	step
		goto Elwynn Forest,32.4,50.9
		.talk Gretchen Fenlow##51934
		..turnin Clean Up in Stormwind##29144
	step
		goto 32.2,50.8
		.talk Gertrude Fenlow##52548
		.' Tell her you are ready to fly |invehicle
	step
		.' Use the _Toss Stink Bomb_ ability on your action bar all around _Undercity_
		.' Drop 25 Stink Bombs |q 29054/1
		.' Click the _Return Home_ button on your action bar |outvehicle
	step
		goto Elwynn Forest,32.3,50.9
		.talk Gretchen Fenlow##51934
		..turnin Stink Bombs Away!##29054
	step
		goto Elwynn Forest,42.6,64.4
		.talk Costumed Orphan Matron##24519
		..' You will only be able to accept 1 of the 2 daily quests
		..accept Stop the Fires!##11131 |daily |or
		..accept "Let the Fires Come!"##12135 |daily |or
	step
		goto 42.5,64.5
		.' Click the Water Barrel |tip It looks like a huge bucket of water.
		.collect Water Bucket##32971 |q 11131
	step
		goto 42.4,65.6
		.' Use your Water Bucket on the fires all around this area |use Water Bucket##32971
		.' Put Out the Fires |q 11131/1 |tip You will need a group of people to complete this quest.  It is best to do this quest at peak hours.
		.' Collect more Water Buckets from the Water Barrel at [42.5,64.5]
	step
		goto 42.5,64.5
		.' Click the Water Barrel |tip It looks like a huge bucket of water.
		.collect Water Bucket##32971 |q 12135
	step
		goto 42.4,65.6
		.' Wait until the fires appear on the buildings in Goldshire
		.' Use your Water Bucket on the fires all around this area |use Water Bucket##32971
		.' Put Out the Fires |q 12135/1 |tip You will need a group of people to complete this quest.  It is best to do this quest at peak hours.
		.' Collect more Water Buckets from the Water Barrel at [42.5,64.5]
	step
		goto 42.4,65.9
		.' Click the Large Jack-o'-Lantern |tip It's a burning pumpkin laying in the road.
		..accept Smash the Pumpkin##12133 |daily
	step
		goto 42.6,64.4
		.talk Costumed Orphan Matron##24519
		..' You will only be able to accept 1 of the 2 daily quests
		..turnin Stop the Fires!##11131
		..turnin "Let the Fires Come!"##12135
		..turnin Smash the Pumpkin##12133
	step
		|fly Andorhal
	step
		'Go west to Tirisfal Glades |goto Tirisfal Glades |noway |c
	step
		goto Undercity,68.2,15.6
		.' Use the Dousing Agent in your Bags on the Burning Wickerman |use Dousing Agent##68648
		.' Douse the Horde's Wickerman |q 29371/1
	step
		'Go east to Western Plaguelands |goto Western Plaguelands |noway |c
	step
		|fly Stormwind City
	step
		goto Elwynn Forest,32.1,50.6
		.talk Keira##52064
		..turnin A Time to Lose##29371
]])

ZygorGuidesViewer:RegisterInclude("Hallows_End_Achievements_Alliance",[[
	step
		goto Stormwind City,60.5,75.3
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Stormwind, The Trade District |achieve 966/10
	step
		'Go outside to Elwynn Forest |goto Elwynn Forest |noway |c
	step
		goto Elwynn Forest,43.7,65.9
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Elwynn Forest, Goldshire |achieve 966/5
	step
		|fly Thelsamar
	step
		goto Loch Modan,35.5,48.5
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Loch Modan, Thelsamar |achieve 966/8
	step
		goto 33.9,51.0
		.talk Thorgrum Borrelson##1572
		.' Fly to Ironforge, Dun Morogh |goto Ironforge,55.9,47.9,0.5 |noway |c
	step
		goto Ironforge,18.3,51.0
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Ironforge, The Commons |achieve 966/7
	step
		|fly Kharanos
	step
		goto Dun Morogh,54.5,50.8
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Dun Morogh, Kharanos |achieve 966/2
	step
		|fly Menethil Harbor
	step
		goto Wetlands,10.8,61.0
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Wetlands, Menethil Harbor |achieve 966/12
	step
		|fly Aerie Peak
	step
		goto The Hinterlands,14.2,44.6
		.' Go upstairs in the inn
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Hinterlands, Aerie Peak |achieve 966/6
	step
		|fly Light's Hope Chapel
	step
		goto Eastern Plaguelands,75.6,52.3
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Eastern Plaguelands, Light's Hope Chapel |achieve 966/4
	step
		|fly Lakeshire
	step
		goto Redridge Mountains,26.5,41.5
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Redridge Mountains, Lakeshire |achieve 966/9
	step
		|fly Darkshire
	step
		goto Duskwood,73.8,44.3
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Duskwood, Darkshire |achieve 966/3
	step
		|fly Sentinel Hill
	step
		goto Westfall,52.9,53.7
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Westfall, Sentinel Hill |achieve 966/11
	step
		|fly Booty Bay
	step
		goto The Cape of Stranglethorn,40.9,73.7
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Stranglethorn Vale, Booty Bay |achieve 966/1
	step
		#include "rideto_ratchet"
	step
		goto Northern Barrens,67.3,74.7
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Barrens, Ratchet |achieve 963/11
	step
		|fly Theramore Isle
	step
		goto Dustwallow Marsh,66.6,45.3
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Dustwallow Marsh, Theramore Isle |achieve 963/8
	step
		|fly Mudsprocket
	step
		goto 41.9,74.1
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Dustwallow Marsh, Mudsprocket |achieve 963/7
	step
		|fly Gadgetzan
	step
		goto Tanaris,52.5,27.1
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Tanaris, Gadgetzan |achieve 963/14
	step
		|fly Cenarion Hold
	step
		goto Silithus,55.5,36.8
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Silithus, Cenarion Hold |achieve 963/12
	step
		|fly Feathermoon Stronghold
	step
		goto Feralas,46.3,45.2
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Feralas, Feathermoon Stronghold |achieve 963/10
	step
		|fly Nijel's Point
	step
		goto Desolace,66.3,6.6
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Desolace, Nijel's Point |achieve 963/6
	step
		|fly Thal'darah Overlook
	step
		goto Stonetalon Mountains,39.5,32.8
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Stonetalon Mountains, Stonetalon Peak |achieve 963/13
	step
		|fly Astranaar
	step
		goto Ashenvale,37.0,49.3
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Ashenvale, Astranaar |achieve 963/1
	step
		|fly Everlook
	step
		goto Winterspring,59.8,51.2
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Winterspring, Everlook |achieve 963/16
	step
		|fly Lor'danel
	step
		goto Darkshore,50.8,18.9
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Darkshore, Auberdine |achieve 963/4
	step
		|fly Rut'theran Village
	step
		goto Teldrassil,52.3,89.5 |n
		.' Ride the boat to Azuremyst Isle |goto Azuremyst Isle |noway |c
	step
		goto The Exodar,41.9,72.8 |n
		.' Enter The Exodar |goto The Exodar |noway |c
	step
		goto The Exodar,59.3,18.5
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Exodar, Seat of the Naaru |achieve 963/9
	step
		'Go outside to Azuremyst Isle |goto Azuremyst Isle |noway |c
	step
		goto Azuremyst Isle,48.5,49.0
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Azuremyst Isle, Azure Watch |achieve 963/2
	step
		|fly Blood Watch
	step
		goto Bloodmyst Isle,55.7,60.0
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Bloodmyst Isle, Blood Watch |achieve 963/3
	step
		|fly Seat of the Naaru
	step
		'Go outside to Azuremyst Isle |goto Azuremyst Isle |noway |c
	step
		goto Azuremyst Isle,20.5,54.2 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.1,88.4 |n
		.' Go inside the pink portal to Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,62.3,33.2
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Darnassus, Craftsmen's Terrace |achieve 963/5
	step
		'Go out of the eastern entrance of Darnassus to Teldrassil |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.4,52.3
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Teldrassil, Dolanaar |achieve 963/15
	step
		'Go west into Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,44.0,78.1 |n
		.' Click the Portal to Blasted Lands
		.' Teleport to Blasted Lands |goto Blasted Lands |noway |c
	step
		goto Blasted Lands,55.0,53.8 |n
		.' Enter the huge green portal to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
	step
		goto Hellfire Peninsula,54.3,63.7
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Hellfire Peninsula, Honor Hold |achieve 969/4
	step
		goto 23.4,36.4 
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Hellfire Peninsula, Temple of Telhamat |achieve 969/5
	step
		goto Shattrath City,56.3,81.9
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Shattrath City, Scryer's Tier |achieve 969/11
		only if rep ('The Scryers') >= Friendly
	step
		goto Shattrath City,28.2,49.1
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Shattrath City, Aldor Rise |achieve 969/11
		only if rep ('The Aldor') >= Friendly
	step
		goto Terokkar Forest,56.6,53.2
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Terokkar Forest, Allerian Stronghold |achieve 969/12
	step
		goto Shadowmoon Valley,37.0,58.3 
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Shadowmoon Valley, Wildhammer Stronghold |achieve 969/10
	step
		goto 56.4,59.8
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Shadowmoon Valley, Sanctum of the Stars |achieve 969/9
		only if rep ('The Scryers') >= Friendly
	step
		goto 61.0,28.2
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Shadowmoon Valley, Altar of Sha'tar |achieve 969/9
		only if rep ('The Aldor') >= Friendly
	step
		goto Nagrand,54.2,75.9
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Nagrand, Telaar |achieve 969/6
	step
		goto Zangarmarsh,78.5,62.9
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Zangarmarsh, Cenarion Refuge |achieve 969/13
	step
		goto 67.2,49.0
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Zangarmarsh, Telredor |achieve 969/15
	step
		goto 41.9,26.2
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Zangarmarsh, Orebor Harborage |achieve 969/14
	step
		goto Blade's Edge Mountains,35.8,63.7
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Blade's Edge Mountains, Sylvanaar |achieve 969/2
	step
		goto 61.0,68.1
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Blade's Edge Mountains, Toshley's Station |achieve 969/3
	step
		goto 62.9,38.3
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Blade's Edge Mountains, Evergrove |achieve 969/1
	step
		goto Netherstorm,32.0,64.4
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Netherstorm, Area 52 |achieve 969/7
	step
		goto 43.3,36.1
		.' Click the Candy Bucket |tip It looks like a jack-o-lantern bucket sitting on the ground inside the inn.
		..' Complete the Candy Bucket quest |tip If you cannot complete this quest because of a "Duplicate item found" message, open the Handful of Treats item in your bags and take out the contents. |use Handful of Treats##37586
		.' Visit the Candy Bucket in Netherstorm, The Stormspire |achieve 969/8
	step
		'You must be at least level 75 to complete this step:
		.' Use the Dungeon Finder to queue for The Headless Horseman
		.from Headless Horseman##23682
		.' Complete the Bring Me The Head of... Oh Wait achievement |achieve 255
	step
		'Use your Tricky Treats times in a row quickly until you puke |use Tricky Treat##33226 |tip You get these by completing Hallows End quests.
		.' Complete the Out With It achievement |achieve 288
	step
		goto Elwynn Forest,31.8,50.1
		.talk Dorothy##53728
		.buy Tooth Pick##37604 |n
		.' Use your Tooth Pick |use Tooth Pick##37604
		.' Show off your sparkling smile by using a Tooth Pick |achieve 981
	step
		'Use your Weighted Jack-o'-Lanterns on the following races: |use Weighted Jack-o'-Lantern##34068 |tip You receive Weighted Jack-o'-Lanterns by doing the Hallow's End daily quests.  Make sure the player doesn't already have a jack-o-lantern on their head or you won't get credit.  The best place to complete this is in Dalaran, but it can be done anywhere in the world.
		.' Gnome |achieve 291/4
		.' Goblin |achieve 291/5
		.' Blood Elf |achieve 291/1
		.' Draenei |achieve 291/2
		.' Dwarf |achieve 291/3
		.' Human |achieve 291/6
		.' Night Elf |achieve 291/7
		.' Orc |achieve 291/8
		.' Tauren |achieve 291/9
		.' Troll |achieve 291/10
		.' Undead |achieve 291/11
		.' Worgen |achieve 291/12
	step
		'Have other players use Hallowed Wands on you while in a party to transform into the following:
		.' Transform into a Bat |achieve 283/1
		.' Transform into a Ghost |achieve 283/2
		.' Transform into a Leper Gnome |achieve 283/3
		.' Transform into a Ninja |achieve 283/4
		.' Transform into a Pirate |achieve 283/5
		.' Transform into a Skeleton |achieve 283/6
		.' Transform into a Wisp |achieve 283/7
	step
		goto Elwynn Forest,31.8,50.1
		.talk Dorothy##53728		
		.buy Sinister Squashling##33154 |n
		.buy Hallowed Helm##33292 |n
		.' Use the Sinister Squashling |use Sinister Squashling##33154
		.' Obtain a Sinister Squashling pet |achieve 292/1
		.' Obtain a Hallowed Helm |achieve 292/2
	step
		'Use your G.N.E.R.D.S. |use G.N.E.R.D.S.##37583 |tip You can buy these from the Hallows End vendor. Use them every 30 minutes while PvPing to keep the buff on.  If you don't have the buff active while killing players, you won't get credit.
		.' Do any type of PvP of your choice |tip You must be killing players that give you honor.
		.' Earn 10 honorable kills while under the influence of the G.N.E.R.D. buff |achieve 1261
	step
		'Congratulations, you are now one of The Hallowed!
]])

--  Pilgrims Bounty --
ZygorGuidesViewer:RegisterInclude("Pilgrims_Bounty_Quests_Alliance",[[
	step
		goto Elwynn Forest,34.2,51.1
		.talk Bountiful Table Hostess##34653
		..accept Sharing a Bountiful Feast##14064
	step
		goto 34.3,51.1
		.clicknpc The Turkey Chair##34812 |tip They look like wooden chairs around a round white and green table with food on it.
		.' Use the first ability on your hotbar to Pass the food to other players who are sitting at the table |tip You must target the other players and use the Pass the Food ability.  Do this repeatedly until you get an achievement.
		.' Start a Food Fight! |achieve 3579
		.' Use the other abilities on your hotbar to eat the food |tip You will only be able to eat certain foods at each place on the table.  Once you eat the foods available to your spot 5 times, click the red arrow above your action bar to get out of the Turkey Chair.  Then, go sit in another Turkey Chair that has a type of food you haven't eaten yet.
		.' Eat each type of food 5 times in a row |tip You can see how many times you've eaten the food by looking at it's buff that it gives you next to your mini map.
		.' Gain the Spirit of Sharing |q 14064/1
	step
		goto 34.2,51.1
		.talk Bountiful Table Hostess##34653
		..turnin Sharing a Bountiful Feast##14064
	step
		goto 33.7,50.6
		.talk Ellen Moore##34710
		.skillmax Cooking,75
		.learn Spice Bread##37836
	step
		goto 34.1,51.5
		.talk Wilmina Holbeck##34682
		.buy Bountiful Cookbook##46809
	step
		'Use your Bountiful Cookbook |use Bountiful Cookbook##46809
		.collect Recipe: Spice Bread Stuffing##44860
		.collect Recipe: Pumpkin Pie##44862
		.collect Recipe: Cranberry Chutney##44858
		.collect Recipe: Candied Sweet Potato##44859
		.collect Recipe: Slow-Roasted Turkey##44859
	step
		'Use your Recipe: Spice Bread Stuffing to learn the recipe |use Recipe: Spice Bread Stuffing##44860
		.learn Spice Bread Stuffing##62050
	step
		goto 34.1,51.5
		.talk Gregory Tabor##34675
		..accept Spice Bread Stuffing##14023
	step
		goto 34.1,51.5
		.talk Wilmina Holbeck##34682
		.buy Simple Flour##30817 |n
		.buy Mild Spices##2678 |n
		.buy Autumnal Herbs##44835 |n
		.' Cook next to the Pilgrim's Bounty Cooking Fire at [33.8,50.8]
		.create 5 Spice Bread##37836,Cooking,5 total
	step
		.create 5 Spice Bread Stuffing##62050,Cooking,5 total  |q 14023/1
		.get 5 Spice Bread Stuffing |q 14023/2
		skill Cooking,100
		.' If you need to train your Cooking skill to allow a higher max level, talk to Ellen Moore at [33.7,50.6]
	step
		'Use your Recipe: Pumpkin Pie to learn the recipe |use Recipe: Pumpkin Pie##44862
		.learn Pumpkin Pie##62044
	step
		goto 33.9,50.8
		.talk Jasper Moore##34744
		..turnin Spice Bread Stuffing##14023
		..accept Pumpkin Pie##14024
	step
		goto 34.1,51.5
		.talk Wilmina Holbeck##34682
		.buy 5 Ripe Elwynn Pumpkin##46784 |n
		.buy 5 Honey##44853 |n
		.buy 5 Autumnal Herbs##44835 |n
		.buy 5 Mild Spices##2678 |n
		.buy 5 Simple Flour##30817 |n
		.' Cook next to the Pilgrim's Bounty Cooking Fire at [33.8,50.8]
		.create Pumpkin Pie##62044,Cooking,5 total |q 14024/1
		.get 5 Pumpkin Pie |q 14024/2
		.create 5 Spice Bread Stuffing##62050,Cooking,5 total  |q 14023/1
	step
		goto 33.8,50.8
		.get 5 Spice Bread Stuffing |q 14023/2
		.skill Cooking,160
		.' If you need to train your Cooking skill to allow a higher max level, talk to Ellen Moore at [33.7,50.6]
	step
		'Use your Recipe: Cranberry Chutney to learn the recipe |use Recipe: Cranberry Chutney##44858
		.learn Cranberry Chuntney##62049
	step
		'Go inside Stormwind City |goto Stormwind City |noway |c
	step
		|fly Ironforge
	step
		'Go outside to Dun Morogh |goto Dun Morogh |noway |c
	step
		goto Dun Morogh,59.8,34.3
		.talk Edward Winslow##34644
		..turnin Pumpkin Pie##14024
		..accept Cranberry Chutney##14028
	step
		goto 59.77,34.34
		.talk Elizabeth Barker Winslow##34645
		.buy Tangy Southfury Cranberries##44854 |n
		.buy Honey##44853 |n
		.' Cook next to the Pilgrim's Bounty Cooking Fire at [59.61,34.94]
		.create 5 Cranberry Chutney##62049,Cooking,5 total |q 14028/1
		.get 5 Cranberry Chutney |q 14028/2
		.skill Cooking,220
		.' If you need to train your Cooking skill to allow a higher max level, talk to Caitrin Ironkettle at [52.9,36.1]
	step
		'Go inside Ironforge |goto Ironforge |noway |c
	step
		goto Ironforge,58.1,49.4
		.talk Gnome Commoner##19172
		..accept Pilgrim's Bounty##14022
	step
		.fly Stormwind City
	step
		'Go outside to Elwynn Forest |goto Elwynn Forest |noway |c
	step
		goto Elwynn Forest,33.9,50.8
		.talk Jasper Moore##34744
		..turnin Cranberry Chutney##14028
		..accept They're Ravenous In Darnassus##14030
	step
		'Use your Recipe: Candied Sweet Potato to learn the recipe |use Recipe: Candied Sweet Potato##44859
		.learn Candied Sweet Potato##62051
	step
		goto 34.1,51.5
		.talk Gregory Tabor##34675
		..turnin Pilgrim's Bounty##14022
	step
			step
		goto 34.1,51.5
		.talk Wilmina Holbeck##34682
		.buy 5 Ripe Elwynn Pumpkin##46784 |n
		.buy 5 Honey##44853 |n
		.buy 5 Autumnal Herbs##44835 |n
		.buy 5 Mild Spices##2678 |n
		.buy 5 Simple Flour##30817 |n
		.' Cook next to the Pilgrim's Bounty Cooking Fire at [33.8,50.8]
		.create Pumpkin Pie##62044,Cooking,5 total |q 14030
		.get 5 Pumpkin Pie |q 14030/2
	step
		goto 33.8,50.8
		.create 5 Spice Bread##37836,Cooking,5 total |n
		.' and
		.create 5 Spice Bread Stuffing##62050,Cooking,5 total  |q 14030
		.get 5 Spice Bread Stuffing |q 14030/1
		.skill Cooking,160
		.' If you need to train your Cooking skill to allow a higher max level, talk to Ellen Moore at [33.7,50.6]
	step
		#include "rideto_ruttheranvillage"
	step
		goto Teldrassil,55.0,88.2 |n
		.' Go inside the pink portal to Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,61.5,49.0
		.talk Isaac Allerton##34676
		..turnin They're Ravenous In Darnassus##14030
		..accept Candied Sweet Potatoes##14033
	step
		goto 62.1,46.0
		.talk Ikaneba Summerset##34681
		.buy Teldrassil Sweet Potato##44855 |n
		.buy Honey##44853 |n
		.buy Autumnal Herbs##44835 |n
		.' Cook next to the Pilgrim's Bounty Cooking Fire at [61.6,49.1]
		.create 5 Candied Sweet Potatoes##62051,Cooking,5 total |q 14033/1
		.get 5 Candied Sweet Potatoes |q 14033/2
		.skill Cooking,280
		.' If you need to train your Cooking skill to allow a higher max level, talk to Mary Allerton at [66.5,35.1]
	step
		goto 36.1,50.1 |n
		.' Go into the pink portal to Rut'theran Village |goto Teldrassil |noway |c
	step
		#include "rideto_stormwind"
	step
		'Go outside to Elwynn Forest |goto Elwynn Forest |noway |c
	step
		goto Elwynn Forest,34.1,51.5
		.talk Gregory Tabor##34675
		..turnin Candied Sweet Potatoes##14033
		..accept Slow-roasted Turkey##14035
	step
		'Use your Recipe: Slow-Roasted Turkey to learn the recipe |use Recipe: Slow-Roasted Turkey##44861
		.learn Slow-Roasted Turkey##62045
	step
		goto 42.5,62.8
		.from Wild Turkey##32820+ |tip You can find these all around Elwynn Forest, so you are not limited to staying in this area.  Ride around Elwynn Forest and look for Wild Turkeys, you should be able to find them easily if you ride around.
		.collect 20 Wild Turkey##44834 |q 14035
	step
		goto 34.1,51.5
		.talk Wilmina Holbeck##34682
		.buy 10 Honey##44853 |n
		.buy Autumnal Herbs##44835 |n
		.' Cook next to the Pilgrim's Bounty Cooking Fire at [33.8,50.8]
		.create 5 Slow-Roasted Turkey##62045,Cooking,5 total |q 14035/1
		.get 5 Slow-Roasted Turkey |q 14035/2
		.' Earn the Now We're Cookin' Achievement |achieve 3576
		.skill Cooking,300
		.' If you need to train your Cooking skill to allow a higher max level, talk to Ellen Moore at [33.7,50.6]
	step
		'Go inside Stormwind City |goto Stormwind City |noway |c
	step
		#include "rideto_ruttheranvillage"
	step
		goto Teldrassil,55.0,88.3 |n
		.' Go inside the pink portal to Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,61.5,49.1
		.talk Isaac Allerton##34676
		..turnin Slow-roasted Turkey##14035
]])

ZygorGuidesViewer:RegisterInclude("Pilgrims_Bounty_Dailies_Alliance",[[
	step
	label	"start"
		These are the Dailies and Achievements for Pilgrim's Bounty. You can only do the Dailies once per day.
		|confirm always
	step
		#include "home_TradeDistrict"
	step
		goto Elwynn Forest,34.3,51.1
		.clicknpc The Turkey Chair##34812 |tip They look like wooden chairs around a round white and green table with food on it.
		.' Use the first ability on your hotbar to Pass the food to other players who are sitting at the table |tip You must target the other players and use the Pass the Food ability.  Do this repeatedly until you get an achievement.
		.' Start a Food Fight! |achieve 3579
		.' Use the other abilities on your hotbar to eat the food |tip You will only be able to eat certain foods at each place on the table.  Once you eat the foods available to your spot 5 times, click the red arrow above your action bar to get out of the Turkey Chair.  Then, go sit in another Turkey Chair that has a type of food you haven't eaten yet.
		.' Earn the Pilgrims Paunch in Stormwind |achieve 3556/4
	step
		goto Elwynn Forest,33.9,50.8
		.talk Jasper Moore##34744
		..accept She Says Potato##14055 |daily
	step
		goto 33.7,50.6
		.talk Ellen Moore##34710
		..accept We're Out of Cranberry Chutney Again?##14053 |daily
	step
		goto Elwynn Forest,34.1,51.5
		.talk Wilmina Holbeck##34682
		.buy 20 Ripe Elwynn Pumpkin##46784 |q 14054
		.buy 20 Honey##44853 |q 14054
	step
		goto 42.5,62.8
		.from Wild Turkey##32820+ |tip You can find these all around Elwynn Forest, so you are not limited to staying in this area.  Ride around Elwynn Forest and look for Wild Turkeys, you should be able to find them easily if you ride around.
		.collect 20 Wild Turkey##44834 |q 14048 |future
	step
		#include "rideto_darnassus"
	step
		goto Darnassus,61.9,46.2
		.talk Mary Allerton##34711
		..accept Easy As Pie##14054 |daily
	step
		goto 62.1,46.0
		.create Pumpkin Pie##62044,Cooking,20 total |q 14054/1
	step
		goto Darnassus,62.8,48.2
		.clicknpc The Turkey Chair##34812 |tip They look like wooden chairs around a round white and green table with food on it.
		.' Use the other abilities on your hotbar to eat the food |tip You will only be able to eat certain foods at each place on the table.  Once you eat the foods available to your spot 5 times, click the red arrow above your action bar to get out of the Turkey Chair.  Then, go sit in another Turkey Chair that has a type of food you haven't eaten yet.
		.' Eat each type of food 5 times in a row |tip You can see how many times you've eaten the food by looking at it's buff that it gives you next to your mini map.
		.' Earn the Pilgrims Paunch in Darnassus |achieve 3556/1
	step
		goto 61.7,49.1
		.talk Ikaneba Summerset##34681
		.buy 20 Teldrassil Sweet Potato##44855
		.buy 20 Honey##44853
		.buy 20 Autumnal Herbs##44835
	step
		goto Darnassus,61.9,46.2
		.talk Mary Allerton##34711
		..turnin Easy As Pie##14054
		.' Choose one of the following until you have all three pieces:
		.collect Pilgrim's Hat##46723
		.collect Pilgrim's Attire##46800
		.collect Turkey Shooter##44812 |tip You can collect multiple Turkey Shooters if you have the other 2 pieces.                 
		|confirm
	step
		goto 61.9,46.2
		.create 20 Candied Sweet Potato##62051,Cooking,20 total |q 14055/1
	step
		 goto 44.2,78.7
		.click Portal to Exodar##06955
		.' Teleport to The Exodar |goto The Exodar |noway |c
	step
		goto The Exodar,53.9,32.4 |n
		.' Follow this ramp up and outside The Exodar |goto The Exodar,53.9,32.4,1 |noway |c
	step
		goto The Exodar,75.7,52.3
		.clicknpc The Turkey Chair##34812 |tip They look like wooden chairs around a round white and green table with food on it.
		.' Use the other abilities on your hotbar to eat the food |tip You will only be able to eat certain foods at each place on the table.  Once you eat the foods available to your spot 5 times, click the red arrow above your action bar to get out of the Turkey Chair.  Then, go sit in another Turkey Chair that has a type of food you haven't eaten yet.
		.' Eat each type of food 5 times in a row |tip You can see how many times you've eaten the food by looking at it's buff that it gives you next to your mini map.
		.' Earn the Pilgrims Paunch in The Exodar |achieve 3556/2
	step
		goto The Exodar,74.2,53.8 |n
		.' Follow this ramp down into The Exodar |goto The Exodar,74.2,53.8,1 |noway |c
	step
		goto The Exodar,47.6,62.1 |n
		.click Portal to Darnassus##4393 
		.' Teleport to Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,36.4,50.4 |n
		.' Go through the Pink portal to Teldrassil |goto Teldrassil |noway |c
	step
		#include "rideto_stormwind"
	step
		|fly Ironforge
	step
		goto Dun Morogh,60.1,34.3
		.talk Caitrin Ironkettle##34708
		..accept Don't Forget The Stuffing!##14051 |daily
		..accept Can't Get Enough Turkey##14048 |daily
	step
		goto Dun Morogh,59.9,34.6
		.clicknpc The Turkey Chair##34812 |tip They look like wooden chairs around a round white and green table with food on it.
		.' Use the other abilities on your hotbar to eat the food |tip You will only be able to eat certain foods at each place on the table.  Once you eat the foods available to your spot 5 times, click the red arrow above your action bar to get out of the Turkey Chair.  Then, go sit in another Turkey Chair that has a type of food you haven't eaten yet.
		.' Eat each type of food 5 times in a row |tip You can see how many times you've eaten the food by looking at it's buff that it gives you next to your mini map.
		.' Earn the Pilgrims Paunch in Ironforge |achieve 3556/3
		.' Earn the Pilgrims Paunch Achievement! |achieve 3556
	step
		goto 59.8,34.3
		.talk Elizabeth Barker Winslow##34645
		.buy 20 Tangy Wetland Cranberries##44854
		.buy 20 Mild Spices##2678
		.buy 20 Simple Flour##30817
		.buy 60 Honey##44853
		.buy 40 Autumnal Herbs##44835
		.buy 20 Tangy Wetland Cranberries##44854
	step
		goto 60.0,34.4
		.create 20 Spice Bread##37836,Cooking,20 total |q 14051
	step
		goto 60.0,34.4
		.create 20 Spice Bread Stuffing##62050,Cooking,20 total |q 14051/1
	step
		goto Dun Morogh,60.1,34.3
		.talk Caitrin Ironkettle##34708
		..turnin Don't Forget The Stuffing!##14051
		.' Choose one of the following until you have all three pieces:
		.collect Pilgrim's Hat##46723
		.collect Pilgrim's Attire##46800
		.collect Turkey Shooter##44812 |tip You can collect multiple Turkey Shooters if you have the other 2 pieces.                  
		|confirm
	step
		goto 60.0,34.4
		.create 20 Slow-Roasted Turkey##62045,Cooking,20 total |q 14048/1
	step
		goto Dun Morogh,60.1,34.3
		.talk Caitrin Ironkettle##34708
		..turnin Can't Get Enough Turkey##14048
		.' Choose one of the following until you have all three pieces:
		.collect Pilgrim's Hat##46723
		.collect Pilgrim's Attire##46800
		.collect Turkey Shooter##44812 |tip You can collect multiple Turkey Shooters if you have the other 2 pieces.                    
		|confirm
	step
		goto 60.0,34.4
		.create Cranberry Chutney##62049,Cooking,20 total |q 14053/1
	step
		|fly Stormwind City
	step
		goto Elwynn Forest,33.9,50.8
		.talk Jasper Moore##34744
		..turnin She Says Potato##14055
		.' Choose one of the following until you have all three pieces:
		.collect Pilgrim's Hat##46723
		.collect Pilgrim's Attire##46800
		.collect Turkey Shooter##44812 |tip You can collect multiple Turkey Shooters if you have the other 2 pieces.                    
		|confirm
	step
		goto 33.7,50.6
		.talk Ellen Moore##34710
		..turnin We're Out of Cranberry Chutney Again?##14053 
		.' Choose one of the following until you have all three pieces:
		.collect Pilgrim's Hat##46723
		.collect Pilgrim's Attire##46800
		.collect Turkey Shooter##44812 |tip You can collect multiple Turkey Shooters if you have the other 2 pieces.                    
		|confirm
		.' Earn the Pilgrims Progress Achievement |achieve 3596
	step
		goto 42.5,62.8
		.from Wild Turkey##32820+
		.' Quickly kill _40 Wild Turkeys_ and keep killing them until you earn the achievement: |tip You can see how many turkeys you have killed with the Turkey Tracker buff. |tip You can find more Turkeys all around Elwynn Forest.
		.' The Turkinator! |achieve 3578
	step
		.' You should have three pieces of the Pilgrim's Attire now
		.' Equip your Pilgrim's Attire |equipped Pilgrim's Attire##46800 |use Pilgrim's Attire##46800
	step
		|fly Andorhal
	step
		goto Undercity,68.6,6.7
		.' While wearing your Pilgrim's Attire, sit at any table's chair |modelnpc The Turkey Chair##34812
		.' Equip your Pilgrim's Attire |equipped Pilgrim's Attire##46800 |use Pilgrim's Attire##46800
		.' Pilgrim's Peril of Undercity |achieve 3580/4
	step
		|fly Northpass Tower
	step
		goto Eastern Plaguelands,54.4,8.8 |n
		.' Go through the portal to Ghostlands |goto Ghostlands |noway |c
	step
		goto Eversong Woods,55.2,53.2
		|tip You can run up The Dead Scar most of the way to avoid Horde towns. This is the Grey line running up the map on the left.
		.' While wearing your Pilgrim's Attire, sit at any table's chair |modelnpc The Turkey Chair##34812
		.' Equip your Pilgrim's Attire |equipped Pilgrim's Attire##46800 |use Pilgrim's Attire##46800
		.' Pilgrim's Peril of Silvermoon City |achieve 3580/2
	step
		#include "hearth_hub"
	step
		#include "rideto_ratchet"
	step
		goto Thunder Bluff,28.6,62.8
		.' While wearing your Pilgrim's Attire, sit at any table's chair |modelnpc The Turkey Chair##34812
		.' Equip your Pilgrim's Attire |equipped Pilgrim's Attire##46800 |use Pilgrim's Attire##46800
		.' Pilgrim's Peril of Thunder Bluff |achieve 3580/3
	step
		goto Durotar,46.2,15.1
		.' While wearing your Pilgrim's Attire, sit at any table's chair |modelnpc The Turkey Chair##34812
		.' Equip your Pilgrim's Attire |equipped Pilgrim's Attire##46800 |use Pilgrim's Attire##46800
		.' Pilgrim's Peril of Orgrimmar |achieve 3580/1
		.' Earn the Pilgrim's Peril Achievement! |achieve 3580
	step
		goto Durotar,46.2,15.1
		.' You should have a few _Turkey Shooters_ from your daily quests, if you don't, you will need to do more daily's when possible for more.
		.' while in Durotar, shoot Horde Rogues with your Tukey Shooter. |use Turkey Shooter##44812
		.' Shoot a Blood Elf Rogue |achieve 3559/1
		.' Shoot a Orc Rogue |achieve 3559/6
		.' Shoot a Troll Rogue |achieve 3559/7
		.' Shoot a Undead Rogue |achieve 3559/8
	step
		#include "hearth_hub"
	step
		.' You should have a few _Turkey Shooters_ from your daily quests, if you don't, you will need to do more daily's when possible for more.
		.' while in Durotar, shoot Horde Rogues with your Tukey Shooter. |use Turkey Shooter##44812
		.' Shoot a Dwarf Rogue |achieve 3559/2
		.' Shoot a Gnome Rogue |achieve 3559/3
		.' Shoot a Human Rogue |achieve 3559/4
		.' Shoot a Night Elf Rogue |achieve 3559/5
	step
		#include "darkportal"
	step
		|fly Allerian Stronghold
	step
		goto Terokkar Forest,44.9,65.6 |n
		.' Enter Sethekk Halls here |goto Sethekk Halls |noway |c
	step
		goto Sethekk Halls,49.4,95.3 |n
		 .' Follow this stairway up and around |goto Sethekk Halls,49.4,95.3,0.5 |noway |c
	step
		goto Sethekk Halls,36.4,88.7 |n
		.' Keep following this path around |goto Sethekk Halls,36.4,88.7,1 |noway |c
	step
		goto Sethekk Halls/2 32.5,39.5
		.' Equip your Pilgrim's Attire |equipped Pilgrim's Attire##46800 |use Pilgrim's Attire##46800
		.' Equip your Pilgrim's Hat##46723 |equipped Pilgrim's Hat##46723 |use Pilgrim's Hat##46723
		.from Talon King Ikiss##18473
		.' Earn the Achievment Terokkar Turkey Time |achieve 3582
	step
		.' You have reached the End of this guide, you can only do the Dailys Once per day. 
		Click here to start the Dailys over. |confirm always
		|next "end" |only if achieved(3478)
		|next "start" |only if not achieved(3478)
	step
	label	"end"
		.' Congratualtions, you have earned the Pilgrim Achievement!
		
]])

-- Feast of Winter Veil --

ZygorGuidesViewer:RegisterInclude("Feast of Winter Veil Quests",[[
		goto Ironforge,33.7,67.3
		.talk Wulmort Jinglepocket##13433
		..accept Great-father Winter is Here!##7022
	step
		goto 33.1,65.5
		.talk Greatfather Winter##13444
		..turnin Greatfather Winter is Here!##7022
		..accept Treats for Greatfather Winter##7025
	step
		goto 30.2,59.4
		.talk Goli Krumn##1365
		..accept The Reason for the Season##7062
	step
		goto 60.1,36.4
		.talk Daryl Riknussun##5159
		.' Learn the Apprentice Cooking skill, if you don't have it already
		.' Skip to the next step in the guide
	step
		goto 77.5,11.8
		.talk Historian Karnik##2916
		..turnin The Reason for the Season##7062
		..accept The Feast of Winter Veil##7063
	step
		goto 33.7,67.3
		.talk Wulmort Jinglepocket##13433
		.buy 1 Recipe: Gingerbread Cookie##17200 |n
		.' Click the Recipe: Gingerbread Cookie recipe in your bags |use Recipe: Gingerbread Cookie##17200
		.learn Gingerbread Cookie##21143
		|confirm
	step
		goto 33.7,67.3
		.talk Wulmort Jinglepocket##13433
		.buy 5 Holiday Spices##17194 |q 7025
	step
		'Buy 5 Small Eggs from the Auction House: |tip You can also farm these from mobs, if you'd prefer.
		.collect 5 Small Egg##6889 |q 7025
	step
		goto 32.1,62.8
		.create 5 Gingerbread Cookie##21143,Cooking,5 total |q 7025/1
	step
		goto 18.1,51.4
		.talk Innkeeper Firebrew##5111
		.buy Ice Cold Milk##1179 |q 7025
	step
		goto 18.1,51.4
		.talk Innkeeper Firebrew##5111
		.home Ironforge
	step
		goto 33.1,65.5
		.talk Greatfather Winter##13444
		..turnin Treats for Great-father Winter##7025
	step
		goto 39.2,56.0
		.talk Muradin Bronzebeard##42928
		..turnin The Feast of Winter Veil##7063
	step
		|fly Chillwind Camp
	step
		'Go south to Hillsbrad Foothills |goto Hillsbrad Foothills |noway |c
	step
		goto Hillsbrad Foothills,42.3,41.1
		.talk Strange Snowman##13636
		..accept You're a Mean One...##7043 |daily
	step
		goto Hillsbrad Foothills,43.6,39.0
		.from The Abominable Greench##54499
		.get Stolen Treats |q 7043/2 |tip They are the bags on the ground behind the Abominable Greench.
		.' Free Metzen the Reindeer. |q 7043/1 |tip After you defeat The Abominable Greench Metzen is freed.
	step
		'Hearth to Ironforge |goto Ironforge,18.1,51.5,0.5 |use Hearthstone##6948 |noway |c
	step
		goto Ironforge,33.7,67.3
		.talk Wulmort Jinglepocket##13433
		.turnin You're a Mean One...##7043 |daily
		..accept A Smokywood Pastures' Thank You!##7045
	step
		goto 33.1,65.5
		.talk Greatfather Winter##13444
		..turnin A Smokywood Pastures' Thank You!##7045
]])

ZygorGuidesViewer:RegisterInclude("Feast of Winter Veil Achievements",[[
		goto Ironforge,19.9,53.8
		.' Kiss a Winter Reveler every hour |script DoEmote("KISS") |tip You can only use this once per hour. The items you get are random.
		.collect 10 Handful of Snowflakes##34191 |n
		.collect 8 Mistletoe##21519 |n
		.collect Preserved Holly##21213 |n
		.' Once you've collected these items, click here to proceed. |confirm
	step
		'Use a Handful of Snowflakes on the following race/class combinations |use Handful of Snowflakes##34191 |tip The best place to complete this is in major cities, but it can be done anywhere in the world.
		.' You can get more snowflakes by using /kiss on Winter Revealers at [19.9,53.8]
		.' Orc Death Knight |achieve 1687/1
		.' Human Warrior |achieve 1687/2
		.' Tauren Shaman |achieve 1687/3
		.' Night Elf Druid |achieve 1687/4
		.' Undead Rogue |achieve 1687/5
		.' Troll Hunter |achieve 1687/6
		.' Gnome Mage |achieve 1687/7
		.' Dwarf Paladin |achieve 1687/8
		.' Blood Elf Warlock |achieve 1687/9
		.' Draenei Priest |achieve 1687/10
	step
		goto Ironforge,33.7,67.3
		.talk Wulmort Jinglepocket##13433
		.buy Recipe: Hot Apple Cider##34413
		.buy Recipe: Egg Nog##17201
	step
		.learn Recipe: Hot Apple Cider##45022 |use Recipe: Hot Apple Cider##34413
		.learn Recipe: Egg Nog##21144 |use Recipe: Egg Nog##17201
		.create Egg Nog##21144,Cooking,1 total |achieve 1688/2
		.create Hot Apple Cider##45022,Cooking,1 total |achieve 1688/3 |tip Requires a cooking skill of 325
	step
		'Use the Tailoring profession or pay a tailor to create Red or Green Winter Clothes.
		.' You can buy the pattern from Wulmort Jinglepocket at [33.7,67.3]
		.collect Red Winter Clothes##34085
	step
		'Use the Leatherworking profession or pay a leatherworker to create Winter Boots
		.' You can buy the pattern from Wulmort Jinglepocket at [33.7,67.3]
		.collect Winter Boots##34086
	step
		'Queue for Heroic The Nexus dungeon.
		.' You can also run to the instance and do it.
		.from Grand Magus Telestra##26731
		.collect Red Winter Hat##21524
	step
		'Get the Smokywood Pastures Sampler from your mailbox |tip It should arrive within 24 hours after completing the Feast of Winter Veil quest section of this guide.
		.' Click the Smokywood Pastures Sampler in your bag |use Smokywood Pastures Sampler##17685
		.collect Graccu's Mince Meat Fruitcake##21215
		.' Equip the Red Winter Clothes |use Red Winter Clothes##34085
		.' Equip the Winter Boots |use Winter Boots##34086
		.' Equip the Red Winter Hat |use Red Winter Hat##21524
		.' During the Feast of Winter Veil, wear 3 pieces of winter clothing and eat Graccu's Mince Meat Fruitcake |use Graccu's Mince Meat Fruitcake##21215 |achieve 277
	step
		'Go outside of Ironforge to Dun Morogh |goto Dun Morogh |noway |c
	step
		goto Dun Morogh,60.3,33.9
		.' Use the Winter Wondervolt machine to turn into a Little Helper |Use them every 30 minutes while PvPing to keep the buff on.  If you don't have the buff active while killing players, you won't get credit.
		.' Do any type of PvP of your choice |tip We recommend Alterac Valley. You must be killing players that give you honor.
		.' Earn 50 honorable kills as a Little Helper from the Winter Wondervolt machine |achieve 252
	step
		'Make sure you have the following in your bags:
		.collect 8 Mistletoe##21519
		.collect Preserved Holly##21213
	step
		goto Ironforge,33.7,67.3
		.talk Wulmort Jinglepocket##13433
		.buy Snowball##17202
	step
		goto 39.2,56.0
		.' Use a snowball on Muradin Bronzebeard |use Snowball##17202
		.' Throw a snowball at Muradin Bronzebeard during the Feast of Winter Veil |achieve 1255
	step
		goto 76.9,51.2 |n
		.' Ride the Deep Run Tram to Stormwind City |goto Stormwind City |noway |c
	step
		goto 55.0,54.2
		.' Use your Mistletoe on Brother Kristoff |use Mistletoe##21519
		.' Use Mistletoe on Brother Kristoff in Stormwind City |achieve 1686/4
	step
		 goto 51.6,46.4
		.' Use your Mistletoe on Brother Benjamin |use Mistletoe##21519 |tip He patrols in front of this entryway, so you may need to search for him.
		.' Use Mistletoe on Brother Benjamin in the Stormwind City |achieve 1686/8
	step
		goto 52.4,45.8
		.' Use your Mistletoe on Brother Cassius |use Mistletoe##21519
		.' Use Mistletoe on Brother Cassius in the Stormwind City |achieve 1686/7
	step
		goto 49.5,45.2
		.' Use your Mistletoe on Brother Joshua |use Mistletoe##21519
		.' Use Mistletoe on Brother Joshua in the Stormwind City |achieve 1686/5
	step
		goto 52.6,43.2
		.' Use your Mistletoe on Brother Crowley |use Mistletoe##21519 |tip He is at the lower level of the cathedral, down the ramp.
		.' Use Mistletoe on Brother Crowley in the Stormwind City |achieve 1686/6
	 step
		goto 60.4,75.3
		.talk Innkeeper Allison##6740
		.home Stormwind City
	step
		'Go outside of Stormwind to Elwynn Forest |goto Elwynn Forest |noway |c
	step
		goto Elwynn Forest,41.1,66.0
		.' Use your Mistletoe on Brother Wilhelm |use Mistletoe##21519
		.' Use Mistletoe on Brother Wilhelm in Goldshire |achieve 1686/2
	step
		|fly Rebel Camp
	step
		goto Northern Stranglethorn,47.3,11.1
		.' Use your Mistletoe on Brother Nimetz |use Mistletoe##21519
		.' Use Mistletoe on Brother Nimetz in Northern Stranglethorn |achieve 1686/1
	step
		|fly Booty Bay
	step
		goto The Cape of Stranglethorn,39.3,67.2 |n
		.' Ride the boat to Ratchet |goto Northern Barrens |noway |c
	step
		|fly Theramore Isle
	step
		goto Dustwallow Marsh,67.4,47.4
		.' Use your Mistletoe on Brother Karman |use Mistletoe##21519
		.' Use Mistletoe on Brother Karman in Dustwallow Marsh |achieve 1686/3
	step
		'Hearth to Stormwind City |goto Stormwind City |use Hearthstone##6948 |noway |c
	step
		.' The following achievements require a level 70 or higher character.
		|confirm
	step
		goto Stormwind City,49.0,87.4 |n
		.' Click the portal to the Blasted Lands |goto Blasted Lands |noway |c
	step
		'Go into the huge green portal to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
	step
		|fly Sylvanaar
	step
		goto Blade's Edge Mountains,28.7,57.4
		.talk Chu'a'lor##23233
		..accept The Trouble Below##11057
		..accept The Crystals##11025
	step
		goto 29.2,53.7
		.from Apexis Flayer##22175+
		.get 5 Apexis Shard |q 11025/1
	step
		goto 28.8,57.4
		.talk Chu'a'lor##23233
		..turnin The Crystals##11025
		..accept An Apexis Relic##11058
	step
		goto 28.4,57.6
		.talk Torkus##23316
		..accept Our Boy Wants To Be A Skyguard Ranger##11030
	step
		goto 33.1,52.3
		.from Gan'arg Analyzer##23386+
		.collect Apexis Shard##32569 |n
		.' Click an Apexis Relic |tip It looks like a small multi-colored crystal floating in the air.
		..' Insert an Apexis Shard to begin.
		.' Stand on the white globe and watch as the crystal floating above you casts a beam on the surrounding clusters
		.' Click the clusters in the same color pattern as the crystal. |tip You must do this six times. If you mess up you will be given a few chances to correct yourself before you have to start the process over.
		.' Attain the Apexis Vibrations |q 11058/1
	step
		goto 51.1,15.6
		.from Bash'ir Arcanist##22243+, Bash'ir Spell-Thief##22242+, Bash'ir Raider##22241+
		.collect 10 Apexis Shard##32569 
	step
		goto 32.8,40.5
		.click Fel Crystalforge##7391
		.' Purchase 1 Unstable Flask of the Beast
		.get Unstable Flask of the Beast |q 11030/1
	step
		goto 28.8,57.4
		.talk Chu'a'lor##23233
		..turnin An Apexis Relic##11058
		..accept The Relic's Emanation##11080 |daily
	step
		goto 28.4,57.7
		.talk Torkus##23316
		..turnin Our Boy Wants To Be A Skyguard Ranger##11030
	step
		goto 27.7,68.1
		.from Gan'arg Analyzer##23386+
		.collect Apexis Shard##32569 |n
		.' Click an Apexis Relic |tip It flooks like a small multi-colored crystal floating in the air
		.' Insert an Apexis Shard to begin.
		.' Stand on the white globe and watch as the crystal floating above you casts a beam on the surrounding clusters
		.' Click the clusters in the same color pattern as the crystal.
		.' You must do this six times. If you mess up you will be given a few chances to correct yourself before you have to start the process over.
		.' Attain the Apexis Vibrations |q 11080/1
	step
		goto 28.8,57.4
		.talk Chu'a'lor##23233
		..turnin The Relic's Emanation##11080
		..accept The Skyguard Outpost##11062
	step
		goto 27.4,52.7
		.talk Sky Commander Keller##23334
		..turnin The Skyguard Outpost##11062
	//END UNLOCKING DAILIES
	step
		goto 27.6,52.9
		.talk Sky Sergeant Vanderlip##23120
		..accept Bombing Run##11010
	step
		goto 36.8,39.4
		.' While on your flying mount, use your Skyguard Bombs on Fel Cannonball Stacks |use Skyguard Bombs##32456
		.' Destroy 15 Fel Cannonball Stacks |q 11010/1
	step
		goto 27.6,52.9
		.talk Sky Sergeant Vanderlip##23120
		..turnin Bombing Run##11010
		..accept Bomb Them Again!##11023 |daily
	step
		'Use Preserved Holly while riding your flying mount |use Preserved Holly##21213 |havebuff Interface\Icons\INV_Misc_Plant_03 |q 11023
	step
		goto 36.8,39.4
		.' While on riding the Reindeer Mount, use the Skyguard Bombs on Fel Cannonball Stacks |use Skyguard Bombs##32456
		.' Destroy 15 Fel Cannonball Stacks |q 11023/1
	step
		goto 27.6,52.9
		.talk Sky Sergeant Vanderlip##23120
		..turnin Bomb Them Again!##11023 |daily |tip You have to be on your mount when turning in the quest.
		.' Complete the Bomb Them Again! quest while mounted on a flying reindeer during the Feast of Winter Veil |achieve 1282
	step
		'Hearth to Stormwind |goto Stormwind City |use Hearthstone##6948 |noway |c
	//DALARAN
	step
		goto Stormwind City,18.2,25.5 |n
		.' Ride the boat to Borean Tundra |goto Borean Tundra |noway |c
	 step
		|fly Dalaran
	step
		goto Dalaran,50.3,63.2
		.' Get the Winter Veil Disguise Kit from your mailbox |tip It should arrive within 24 hours after completing the Feast of Winter Veil quest section of this guide.
		.' Equip the Winter Veil Disguise Kit in your bag |use Winter Veil Disguise Kit##17712
		.' Dance with another player wearing their snowman costume |script DoEmote("DANCE")
		.' During the Feast of Winter Veil, use your Winter Veil Disguise kit to become a snowman and then dance with another snowman in Dalaran |achieve 1690
	step
		goto Stormwind City,61.2,73.5
		.' This step can only be completed by logging into the server on December 25th.
		.' Click a present underneath the tree
		.' Open one of the presents underneath the Winter Veil tree once they are available. |achieve 1689
	step
		'Congratulations, you are now a Merry Maker!
]])

-- Lunar Festival --
ZygorGuidesViewer:RegisterInclude("Lunar Festival Main Quest",[[
		goto Ironforge,30.9,61.6
		.talk Lunar Festival Emissary##15892
		..accept The Lunar Festival##8870
	step
		goto 28.8,16.2
		.talk Lunar Festival Harbinger##15895
		..turnin The Lunar Festival##8870
		..accept Lunar Fireworks##8867
	step
		goto 29.9,14.2
		.talk Lunar Festival Vendor##15898
		..buy 8 Small Blue Rocket##21558+
		..buy 2 Blue Rocket Cluster##21571+
	step
		goto 30.6,17.8
		.' Use Small Blue Rockets |use Small Blue Rocket##21558
		.' Use Blue Rocket Clusters |use Blue Rocket Cluster##21571
		.' Fire 8 Lunar Fireworks |q 8867/1
		.' Fire 2 Lunar Fireworks Clusters |q 8867/2
	step
		goto 28.8,16.2
		.talk Lunar Festival Harbinger##15895
		..turnin Lunar Fireworks##8867
		..accept Valadar Starsong##8883
	step
		goto 30.6,17.8
		.' Use the Lunar Festival Invitation while standing in the beam of light |use Lunar Festival Invitation##21711
		.' Go to the Moonglade |goto Moonglade |noway|c
	step
		goto Moonglade,53.6,35.3
		.talk Valadar Starsong##15864
		..turnin Valadar Starsong##8883
]])
ZygorGuidesViewer:RegisterInclude("Lunar Festival Elder Path",[[
// EASTERN KINGDOMS
		goto Silverpine Forest,45.0,41.1
		.talk Elder Obsidian##15561
		..accept Obsidian the Elder##8645 |instant
	step
		goto Tirisfal Glades,61.9,53.9
		.talk Elder Graveborn##15568
		..accept Graveborn the Elder##8652 |instant
	step
		'Go south to Undercity |goto Undercity |noway |c
	step
		goto Undercity,66.6,38.2
		.talk Elder Darkcore##15564
		..accept Darkcore the Elder##8648 |instant |tip If you die trying to leave Undercity, just resurrect at the spirit healer you get sent to.
	step
		'Go outside to Tirisfal Glades |goto Tirisfal Glades |noway |c
	step
		goto Western Plaguelands,69.0,73.0
		.talk Elder Moonstrike##15594
		..accept Moonstrike the Elder##8714 |instant
	step
		goto 63.5,36.1
		.talk Elder Meadowrun##15602
		..accept Meadowrun the Elder##8722 |instant |tip She is inside of the cave.
	step
		goto Eastern Plaguelands,35.6,68.8
		.talk Elder Windrun##15592
		..accept Windrun the Elder##8688 |instant
	step
		goto 75.7,54.6
		.talk Elder Snowcrown##15566
		..accept Snowcrown the Elder##8650 |instant
	step
		goto 27.7,11.7|n
		.' Enter the swirling portal to Stratholme. |goto Stratholme |noway|c
	step
		map Stratholme
		path follow loose;loop off;ants straight
		path	66.2,76.8	67.3,58.1	60.1,48.7
		path	59.9,31.9	68.3,22.9	78.7,22.1
		.' Follow the path to _Elder Farwhisper_.
		.talk Elder Farwhisper##15607
		..accept Farwhisper the Elder##8727
	step
		goto Stratholme,68.8,88.6 |n
		.' Leave Stratholme. |goto Eastern Plaguelands|noway|c
	step
		goto The Hinterlands,50.0,48.0
		.talk Elder Highpeak##15559
		.accept Highpeak the Elder##8643 |instant
	step
		goto Twilight Highlands,50.9,70.5
		.talk Elder Firebeard##55219
		.accept Firebeard the Elder##29737 |instant
	step
		goto 51.9,33.1
		.talk Elder Darkfeather##55218
		.accept Darkfeather the Elder##29736 |instant
	step
		goto Loch Modan,33.3,46.5
		.talk Elder Silvervein##15558
		..accept Silvervein the Elder##8642 |instant
	step
		goto Ironforge,28.1,17.0
		.talk Elder Bronzebeard##15871
		..accept Bronzebeard the Elder##8866 |instant
	step
		goto Dun Morogh,53.9,49.9
		.talk Elder Goldwell##15569
		..accept Goldwell the Elder##8653 |instant
	step
		goto Searing Gorge,21.3,79.1
		.talk Elder Ironband##15567
		..accept Ironband the Elder##8651 |instant
	step
		.' Enter Blackrock Mountain. |goto Searing Gorge,34.8,85.1 |noway|c
	step
		map Burning Steppes
		path follow loose;loop off;ants straight
		path	19.1,22.6	19.4,23.9	20.4,24.1
		path	21.6,24.4	22.8,23.0	23.5,24.9
		path	23.7,26.2
		.' Follow the path into Blackrock Spire. |goto Blackrock Spire |noway|c
	step
		map Blackrock Spire/4
		path follow loose;loop off;ants straight
		path	30.0,37.9	37.3,40.9	38.9,48.5
		path	44.0,44.5
		.' Follow the path into Hordemar City. |goto Blackrock Spire/3 |noway|c
	step
		map Blackrock Spire/3
		path follow loose;loop off;ants straight
		path	50.3,39.2	55.2,38.3	58.9,42.9
		path	65.3,41.9	61.8,40.0
		.' Follow the path to _Elder Stonefort_.
		 .talk Elder Stonefort##15560
		..accept Stonefort the Elder##8644
	step
		map Blackrock Spire/3
		path follow loose;loop off;ants straight
		path	62.6,42.7	57.5,42.0	54.6,37.5
		path	50.4,39.7
		.' Follow the ramp up to the Hall of Blackhand. |goto Blackrock Spire/4|noway|c
	step
		map Blackrock Spire/4
		path follow loose;loop off;ants straight
		path	40.9,45.4	37.5,48.0
		.' Jump off the ledge here. |goto Burning Steppes |noway|c
	step
		goto Burning Steppes,18.5,25.2
		.' Fly down to this point, or use the chains to traverse to here.
		|confirm
	step
		goto Searing Gorge 26.9,72.6 |n
		.' Enter Blackrock Depths here |goto Blackrock Depths |noway |c
	step
		map Blackrock Depths
		path follow loose;loop off;ants straight
		path	37.9,76.3	42.9,74.4	47.8,72.4
		path	51.5,69.8	50.5,62.9
		.' Follow the path to _Elder Morndeep_.
		.talk Elder Morndeep##15549
		..accept Morndeep the Elder##8619
	step
		goto Blackrock Depths,34.5,77.8 |n
		.' Leave Blackrock Depths. |goto Searing Gorge|noway|c
	step
		goto Burning Steppes,53.6,24.5
		.talk Elder Dawnstrider##15585
		..accept Dawnstrider the Elder##8683 |instant
	step
		goto 70.1,45.4
		.talk Elder Rumblerock##15557
		..accept Rumblerock the Elder##8636 |instant
	step
		goto Elwynn Forest,39.8,63.7
		.talk Elder Stormbrow##15565
		..accept Stormbrow the Elder##8649 |instant
	step
		goto 34.5,50.3
		.talk Elder Hammershout##15562
		..accept Hammershout the Elder##8646 |instant
	step
		goto Stormwind City,60.4,75.3
		.talk Innkeeper Allison##6740
		.home
	step
		goto 73.3,16.9 |n
		.' Click the Portal to Vash'jir |goto Shimmering Expanse |noway|c
	step
		goto Shimmering Expanse,57.3,86.2
		.talk Elder Moonlance##55228
		.accept Moonlance the Elder##29738 |instant
	step
		#include "hearth_hub"
	step
		goto Westfall,56.6,47.1
		.talk Elder Skychaser##15577
		..accept Skychaser the Elder##8675 |instant |tip She is at the top of the tower.
	step
		goto Blasted Lands,54.3,49.5
		.talk Elder Bellowrage##15563
		..accept Bellowrage the Elder##8647 |instant
	step
		|fly Marshtide Watch
	step
		goto Swamp of Sorrows,69.7,54.1
		.' Follow the steps down and go to the swirling portal at [76.1,45.2]
		.' Enter the Swirling Portal to The Temple of Atal'Hakkar|goto The Temple of Atal'Hakkar|noway|c
	step
		goto The Temple of Atal'Hakkar,62.9,34.4
		.talk Elder Starsong##15593
		..accept Starsong the Elder##8713
	step
		goto 50.0,14.5
		.' Leave the instance. |goto Swamp of Sorrows|noway|c
	step
		goto Northern Stranglethorn,71.0,34.3
		.talk Elder Starglade##15596
		..accept Starglade the Elder##8716 |instant
	step
		goto The Cape of Stranglethorn,40.0,72.5
		.talk Elder Winterhoof##15576
		..accept Winterhoof the Elder##8674 |instant
	step
		goto 39.3,67.2 |n
		.' Ride the boat to Ratchet |goto Northern Barrens |noway |c
// KALIMDOR
	step
		goto Northern Barrens,68.4,70.0
		.talk Elder Windtotem##15582
		..accept Windtotem the Elder##8680 |instant
	step
		goto 48.5,59.3
		.talk Elder Moonwarden##15597
		..accept Moonwarden the Elder##8717 |instant
	step
		goto Southern Barrens,41.5,47.5
		.talk Elder High Mountain##15588
		..accept High Mountain the Elder##8686 |instant
	step
		goto Mulgore,48.5,53.2
		.talk Elder Bloodhoof##15575
		..accept Bloodhoof the Elder##8673 |instant
	step
		goto Thunder Bluff,73.0,23.3
		.talk Elder Ezra Wheathoof##15580
		..accept Wheathoof the Elder##8678 |instant |tip If you die trying to leave Thunder Bluff, just resurrect at the spirit healer you get sent to.
	step
		goto Desolace,29.1,62.5 |n
		.' Enter the doorway to Maraudon. |goto Desolace,29.1,62.5 |noway|c
	step
		map Desolace
		path follow strict;loop off;ants straight
		path	28.3,63.0	27.9,64.3	27.6,62.9
		path	29.0,62.6	30.1,62.6	29.9,60.3
		.' Follow this path |goto Maraudon/2 |noway |c
	step
		map Maraudon/2
		path follow strict;loop off;ants straight
		path	29.4,46.0	32.0,60.3	35.5,57.5
		path	41.0,60.5	45.6,58.5	44.8,54.1
		path	43.0,57.6	41.5,63.9	45.6,67.2
		path	44.8,76.2	44.6,83.9	45.2,89.5
		path	51.5,93.8
		.talk Elder Splitrock##15556
		..accept Splitrock the Elder##8635
	step
		.' Leave Maruadon. |goto Desolace|noway|c
	step
		goto Feralas,76.7,37.9
		.talk Elder Grimtotem##15581
		..accept Grimtotem the Elder##8679 |instant
	step
		goto 62.6,31.1
		.talk Elder Mistwalker##15587
		..accept Mistwalker the Elder##8685 |instant
	step
		goto Silithus,53.0,35.5
		.talk Elder Bladesing##15599
		..accept Bladesing the Elder##8719 |instant
	step
		goto 30.8,13.3
		.talk Elder Primestone##15570
		..accept Primestone the Elder##8654 |instant
	step
		goto Uldum,31.6,63.0
		.talk Elder Sekhemi##55210
		..accept Sekhemi the Elder##29741 |instant
	step
		goto 65.5,18.7
		.talk Elder Menkhaf##55211
		..accept Menkhaf the Elder##29742 |instant
	step
		goto Un'Goro Crater,50.4,76.2
		.talk Elder Thunderhorn##15583
		..accept Thunderhorn the Elder##8681 |instant
	step
		goto Tanaris,37.2,79.1
		.talk Elder Ragetotem##15573
		..accept Ragetotem the Elder##8671 |instant
	step
		goto 51.4,28.8
		.talk Elder Dreamseer##15586
		..accept Dreamseer the Elder##8684 |instant
	step
		goto 39.2,21.3 |n
		.' Enter Zul'Farrak. |goto Zul'Farrak |noway|c
	step
		goto Zul'Farrak,34.5,39.4
		.talk Elder Wildmane##15578
		..accept Wildmane the Elder##8676
	step
		goto 56.6,91.2 |n
		.' Leave Zul'Farrak. |goto Tanaris |noway|c
	step
		goto Thousand Needles,77.1,75.6
		.talk Elder Morningdew##15604
		..accept Morningdew the Elder##8724 |instant
	step
		goto 46.3,51.0
		.talk Elder Skyseer##15584
		..accept Skyseer the Elder##8682 |instant
	step
		goto Durotar,53.2,43.6
		.talk Elder Runetotem##15572
		..accept Runetotem the Elder##8670 |instant
	step
		goto Orgrimmar,52.3,60.0
		.talk Elder Darkhorn##15579
		..accept Darkhorn the Elder##8677 |instant |tip If you die trying to leave Thunder Bluff, just resurrect at the spirit healer you get sent to.
	step
		goto Azshara,64.7,79.3
		.talk Elder Skygleam##15600
		..accept Skygleam the Elder##8720 |instant
	step
		goto Winterspring,60.0,49.9
		.talk Elder Stonespire##15574
		..accept Stonespire the Elder##8672 |instant
	step
		goto 53.2,56.6
		.talk Elder Brightspear##15606
		..accept Brightspear the Elder##8726 |instant
	step
		goto Mount Hyjal 62.5,22.8
		.talk Elder Evershade##55227
		..accept Evershade the Elder##29740
	step
		goto Mount Hyjal 26.7,62.0
		.talk Elder Windsong##55224
		..accept Windsong the Elder##29739
	step
		goto Ashenvale,35.4,48.9
		.talk Elder Riversong##15605
		..accept Riversong the Elder##8725 |instant
	step
		goto Felwood,38.4,52.9
		.talk Elder Nightwind##15603
		..accept Nightwind the Elder##8723 |instant
	step
		goto Darkshore,49.5,18.9
		.talk Elder Starweave##15601
		..accept Starweave the Elder##8721 |instant
	step
		goto Teldrassil,56.9,53.1
		.talk Elder Bladeleaf##15595
		..accept Bladeleaf the Elder##8715 |instant
	step
		goto Darnassus,38.8,32.3
		.talk Elder Bladeswift##15598
		..accept Bladeswift the Elder##8718 |instant
	step
		#include "hearth_hub"
	step
		 goto Stormwind City 73.2,19.7 |n
		.' Click the portal to Deepholm. |goto Deepholm |noway|c
	step
		goto Deepholm,49.7,54.9
		.talk Elder Stonebrand##55217
		..accept Stonebrand the Elder##29735
	step
		goto Deepholm 27.7,69.2
		.talk Elder Deepforge##55216
		..accept Deepforge the Elder##29734
	step
		goto Deepholm,48.5,53.9 |n
		.' Click the portal to Stormwind City. |goto Stormwind City |noway|c
// NORTHREND
	step
		goto Stormwind City,18.1,25.5 |n
		.' Ride the boat to Borean Tundra |goto Borean Tundra |noway |c
	step
		goto Borean Tundra,59.1,65.6
		.talk Elder Sardis##30348
		..accept Sardis the Elder##13012 |instant
	step
		goto 57.4,43.7
		.talk Elder Arp##30364
		..accept Arp the Elder##13033 |instant
	step
		goto 42.9,49.6
		.talk Elder Pamuya##30371
		..accept Pamuya the Elder##13029 |instant
	step
		|fly Transitus Shield
	step
		goto 33.8,34.4
		.talk Elder Northal##30360
		..accept Northal the Elder##13016 |instant
	step
		goto 27.5,26.0 |n
		.' Enter The Nexus here |goto The Nexus |noway |c
	step
		map The Nexus
		path loop off
		path	34.4,78.5	29.0,70.6	24.0,67.6
		path	22.0,59.0	18.9,51.5	21.9,44.0
		path	21.5,36.7	25.9,33.5	26.9,25.2
		path	35.4,22.0	43.5,22.1	46.1,28.4
		path	54.0,35.9	55.7,50.5	62.7,52.5
		path	60.3,64.3	55.3,64.7
		.talk Elder Igasho##30536
		..accept Igasho the Elder##13021
	step
		|fly River's Heart
	step
		goto Sholazar Basin,49.8,63.6
		.talk Elder Sandrene##30362
		..accept Sandrene the Elder##13018 |instant
	step
		goto 63.8,49.0
		.talk Elder Wanikaya##30365
		..accept Wanikaya the Elder##13024 |instant
	step
		'Go southeast to Wintergrasp |goto Wintergrasp |noway |c
	step
		goto Wintergrasp,49.0,13.9
		.' Click the Defender's Portal
		.' Go to the upper level of the Wintergrasp Fortress |goto Wintergrasp,50.4,15.9,0.1 |noway |c
	step
		goto 49.0,13.9
		.talk Elder Bluewolf##30368
		..accept Bluewolf the Elder##13026 |instant
	step
		goto 49.1,15.3 |n
		.' Click the portal to Violet Citadel |goto Dalaran |noway|c
	step
		|fly Stars' Rest
	step
		goto Dragonblight 26.0,50.9 |n
		.' Enter Azjol-Nerub here |goto Azjol-Nerub/3 |noway |c
	step
		map Azjol-Nerub/3
		path loop off
		path	19.7,66.9	26.8,36.9	55.8,44.7
		path	88.3,44.8	72.6,30.9
		.' Follow this path down |goto Azjol-Nerub/2 |noway |c
	step
		map Azjol-Nerub/2
		path loop off
		path	39.7,30.7	43.8,20.5	61.2,19.9
		path	60.0,43.6	51.1,61.8
		.' Jump down this hole into the water below |goto Azjol-Nerub |noway |c
	step
		goto 21.8,43.6
		.talk Elder Nurgen##30533
		..accept Nurgen the Elder##13022 |instant
	step
		.' Leave Azjol-Nerub |goto Dragonblight |noway |c
	step
		goto Dragonblight,29.7,55.9
		.talk Elder Morthie##30358
		..accept Morthie the Elder##13014 |instant
	step
		goto 35.1,48.3
		.talk Elder Skywarden##30373
		..accept Skywarden the Elder##13031 |instant
	step
		goto 48.8,78.2
		.talk Elder Thoim##30363
		..accept Thoim the Elder##13019 |instant
	step
		|fly K3
	step
		goto The Storm Peaks,41.2,84.7
		.talk Elder Graymane##30370
		..accept Graymane the Elder##13028 |instant
	step
		goto 28.9,73.7
		.talk Elder Fargal##30359
		..accept Fargal the Elder##13015 |instant
	step
		goto 31.3,37.6
		.talk Elder Stonebeard##30375
		..accept Stonebeard the Elder##13020 |instant
	step
		goto The Storm Peaks 39.6,26.9 |n
		.' Enter the portal to the Halls of Stone. |goto Halls of Stone |noway|c
	step
		goto Halls of Stone,29.4,62.1
		.talk Elder Yurauk##30535
		..accept Yurauk the Elder##13066 |instant
	step
		.' Leave the Halls of Stone. |goto The Storm Peaks |noway|c
	step
		goto The Storm Peaks,64.6,51.3
		.talk Elder Muraco##30374
		..accept Muraco the Elder##13032 |instant
	step
		.' Go Southwest to Zul'Drak. |goto Zul'Drak |noway|c
	step
		goto Zul'Drak,76.1,20.9 |n
		.' Enter the swirling portal to Gundrak. |goto Gundrak |noway|c
	step
		map Gundrak
		path loop off
		path	59.1,49.2	58.2,68.5	50.9,73.6
		path	45.6,61.5
		.talk Elder Ohanzee##30537
		..accept Ohanzee the Elder##13065
	step
		map Gundrak
		path loop off
		path	45.6,61.5	50.9,73.6	58.2,68.5
		path	59.1,49.2
		.' Follow the path, going up the ramps and out of the instance. |goto Zul'Drak |noway|c
	step
		goto Zul'Drak,58.9,56.0
		.talk Elder Tauros##30369
		..accept Tauros the Elder##13027 |instant
	step
		goto Zul'Drak,28.5,86.9 |n
		.' Enter the swirling portal to Drak'Tharon Keep. |goto Drak'Tharon Keep |noway|c
	step
		map Drak'Tharon Keep
		path loop off
		path	31.9,80.0	39.2,86.0	46.2,84.3
		path	47.5,63.7	47.7,51.0	50.5,40.7
		path	57.0,23.0	66.6,23.8	66.7,39.0
		path	67.5,56.0	55.8,58.5	55.5,77.6
		path	65.4,76.3	68.9,79.1
		.' Follow the path to Elder Kilias.
		.talk Elder Kilias##30534
		..accept Kilias the Elder##13023 |instant
	step
		map Drak'Tharon Keep
		path loop off
		path	62.5,77.3	55.5,77.7	58.8,57.0
		path	68.0,55.8	66.8,37.6	66.9,25.5
		path	64.9,18.9	57.1,19.3	50.3,40.9
		path	47.6,50.7	47.6,68.3	47.3,83.3
		path	34.7,80.2	28.5,81.0
		.' Leave the Drak'Tharon. |goto Zul'Drak |noway|c
	step
		goto Grizzly Hills,60.6,27.7
		.talk Elder Beldak##30357
		..accept Beldak the Elder##13013 |instant
	step
		goto 80.5,37.1
		.talk Elder Lunaro##30367
		..accept Lunaro the Elder##13025 |instant
	step
		goto Grizzly Hills,64.2,47.0
		.talk Elder Whurain##30372
		..accept Whurain the Elder##13030 |instant
	step
		goto Howling Fjord,58.0,50.0 |n
		.' Enter the Utgard Keep building here |goto Howling Fjord,58.0,50.0,0.5 |noway |c
	step
		goto 57.3,46.8 |n
		.' Enter Utgarde Keep here |goto Utgarde Keep |noway |c
	step
		map Utgarde Keep
		path loop off
		path	66.8,61.8	62.9,43.6	65.7,29.5
		path	56.4,25.1	44.8,28.0	26.3,37.3
		path	26.1,50.9	22.9,72.7	34.3,88.9
		path	49.3,77.1
		.' Follow this path to the Elder |goto 49.3,77.1,0.5 |noway |c
	step
		goto 47.5,69.6
		.talk Elder Jarten##30531
		..accept Jarten the Elder##13017 |instant
	step
		.' Leave Utgarde Keep |goto Howling Fjord |noway |c
	step
		goto Howling Fjord,57.3,46.7 |n
		.' Enter the swirling portal to Utgarde Pinnacle. |goto Utgarde Pinnacle/2 |noway|c
	step
		map Utgarde Pinnacle/2
		path loop off
		path	44.5,17.0	44.2,29.8	38.5,35.9
		path	33.7,49.0	33.5,64.4	35.5,69.1
		path	39.1,75.8
		.' Take the stairs down. |goto Utgarde Pinnacle |noway|c
	step
		map Utgarde Pinnacle
		path loop off
		path	35.9,77.9	36.2,86.9	41.7,86.2
		path	46.1,81.9
		.' Go up the stairs. |goto Utgarde Pinnacle/2 |noway|c
	step
		map Utgarde Pinnacle/2
		path loop off
		path	54.0,77.0	51.8,76.2	51.8,81.4
		path	56.8,84.4	60.6,84.3	63.7,69.7
		path	68.3,68.4	68.8,56.4	68.9,36.1
		.' Follow the path, clicking here to continue. |confirm
	step
		goto Utgarde Pinnacle,48.7,23.1 
		.talk Elder Chogan'gada##30538
		..accept Chogan'gada the Elder##13067 |instant
]])
ZygorGuidesViewer:RegisterInclude("Lunar Festival Achievement",[[
		goto Ironforge 29.9,14.2
		.talk Lunar Festival Vendor##15898
		.buy 10 Festival Firecracker##21747
		.buy 10 Red Rocket Cluster##21576
	step
		goto 30.7,18.8
		.' Use the _Festival Firecrackers_ as fast as you can.
		.' You will need to use 10 in 30 seconds.
		.' You can drag the Festival Firecrackers onto your action bar.  You will need to click the ground where you want to throw them.
		.use Festival Firecracker##21747
		.' Earn the _Frienzied Firecracker_ Achievement. |achieve 1552
	step
		goto 30.6,18.9
		.' Drag the _Red Rocket Clusters_ to you action bar.
		.' You will need to spam whatever button the Red Rocket Cluster is assigned to.
		.use Red Rocket Cluster##21576
		.' Earn _The Rockets Red Glare_ Achievement. |achieve 1281
	step
		goto 30.6,17.8
		.' Use the Lunar Festival Invitation while standing in the beam of light |use Lunar Festival Invitation##21711
		.' Go to the Moonglade |goto Moonglade |noway|c
	step
		goto Moonglade,53.6,35.3
		.talk Valadar Starsong##15864
		.buy Festive Green Dress##21157 |or
		.buy Festive Pink Dress##21538 |or
		.buy Festive Purple Dress##21539 |or
		.buy Festive Black Pant Suit##21541 |or
		.buy Festive Blue Pant Suit##21544 |or
		.buy Festive Teal Pant Suit##21543 |or
		.' Earn the _Lunar Festival Finery_ Achievement. |achieve 626
	step
		goto 53.6,35.3
		.talk Valadar Starsong##15864
		..accept Elune's Blessing##8868
	step
		goto 64.7,60.5
		.' Use your rock clusters here to summon _Omen_.
		.kill Omen |q 8868/1
	step
		goto 53.6,35.3
		.talk Valadar Starsong##15864
		..turnin Elune's Blessing##8868
		.' Earn the _Elune's Blessing_ Achievement. |achieve 937
]])

-- Love is in the Air --
ZygorGuidesViewer:RegisterInclude("Love is in the Air Main Quest",[[
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..accept Something Stinks##24655
	step
		goto 62.4,76.9
		.' Find Stormwind Guards that have the Heavily Perfumed buff on them|tip They are all over Stormwind and will have a glowing pink aura around them
		.' Use Snagglebolt's Air Analyzer on Stormwind Guards|use Snagglebolt's Air Analyzer##50131
		.' Analyze 6 Perfumed Guards|q 24655/1
	step
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin Something Stinks##24655
		..accept Pilfering Perfume##24656
	step
		' While disguised as a package-runner, RUN to the Crown Chemical Company's stockpile outside the gates of Stormwind|goto Elwynn Forest,34.0,47.4,0.3
		.' Get the Crown Chemical Co. Package |havebuff INV_Crate_03 |q 24656
	step
		' Quickly return the package they toss you to Inspector Snip Snagglebolt in Stormwind.|goto Stormwind City,61.6,75.3,0.3
		' Deliver the package in time |condition ZGV.questsbyid[24656] and ZGV.questsbyid[24656].complete |q 24656
		.' If you lose your disguise, ask the Inspector for another one and repeat the run.
	step
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin Pilfering Perfume##24656
		..accept Fireworks At The Gilded Rose##24848
	step
		goto Stormwind City,60.6,76.4
		.talk Marion Sutton##38325
		..turnin Fireworks At The Gilded Rose##24848
		..accept Hot On The Trail##24849
	step
		goto Stormwind City,63.2,79.1
		.' Search the Stormwind Counting House|q 24849/1
	step
		goto Stormwind City,61.2,70.9
		.' Search the Stormwind Auction House|q 24849/2
	step
		goto Stormwind City,61.3,65.0
		.' Search the Stormwind Barber Shop|q 24849/3
	step
		goto Stormwind City,60.6,76.4
		.talk Marion Sutton##38325
		..turnin Hot On The Trail##24849
		..accept A Friendly Chat...##24657
	step
		goto Stormwind City,27.43,34.8
		.talk Snivel Rustrocket##37715
		.' Talk to him until he gives you Snivel's Ledger
		..collect Snivel's Ledger##49915|q 24657/1
	step
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin A Friendly Chat...##24657
]])
ZygorGuidesViewer:RegisterInclude("Love is in the Air Daillies",[[
		goto Ironforge,33.5,65.6
		.talk Kwee Q. Peddlefeet##16075
		..accept A Gift for the Lord of Ironforge##24609 |daily
	step
		|fly Stormwind City
	step
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..' You have to be at least level 5 to accept a quest from him
		..accept Crushing the Crown##24658 |daily |only if level >= 5 and level < 14
		..accept Crushing the Crown##24659 |daily |only if level >= 14 and level < 23
		..accept Crushing the Crown##24660 |daily |only if level >= 23 and level < 32
		..accept Crushing the Crown##24662 |daily |only if level >= 32 and level < 41
		..accept Crushing the Crown##24663 |daily |only if level >= 41 and level < 51
		..accept Crushing the Crown##24664 |daily |only if level >= 51 and level < 61
		..accept Crushing the Crown##24665 |daily |only if level >= 61 and level < 71
		..accept Crushing the Crown##24666 |daily |only if level >= 71 and level < 81
		..accept Crushing the Crown##28934 |daily |only if level >= 81
	step
		goto 62.4,75.4
		.talk Public Relations Agent##37675
		..accept A Perfect Puff of Perfume##24629 |daily |or
		..accept A Cloudlet of Classy Cologne##24635 |daily |or
		..accept Bonbon Blitz##24636 |daily |or
	step
		goto Stormwind City,62.5,75.0
		.talk Kwee Q. Peddlefeet##16075
		..accept A Gift for the King of Stormwind##24597 |daily
	step
		'Run around Stormwind and:
		.' Use your Crown Cologne Sprayer on NPCs and other players without a red heart over their head |use Crown Cologne Sprayer##49669
		.' Give 10 Cologne Samples |q 24635/1
	step
		'Run around Stormwind and:
		.' Use your Crown Perfume Sprayer on NPCs and other players without a red heart over their head |use Crown Perfume Sprayer##49668
		.' Give 10 Perfume Samples |q 24629/1
	step
		'Run around Stormwind and:
		.' Use your Crown Chocolate Sampler on NPCs and other players without a red heart over their head |use Crown Chocolate Sampler##49670
		.' Give 10 Chocolate Samples |q 24636/1
	step
		'Go outside Stormwind to Elwynn Forest |goto Elwynn Forest |noway |c
		only if level >= 5 and level < 14
	step
		goto Elwynn Forest,29.3,65.4
		.kill 5 Crown Lackey |q 24658/2
		.' Use Snagglebolt's Khorium Bomb next to the big shaking Chemical Wagon |use Snagglebolt's Khorium Bomb##50130
		.' Destroy the Chemical Wagon |q 24658/1
		only if level >= 5 and level < 14
	step
		'This step depends on your character's level and what you want to do.  
		.' If you don't have alot of money, or don't want to spend any more, do this: |tip Go to a place where the mobs are at least green to you, they cannot be grey to you, or they won't drop the items you need.  Now, just kill the mobs until you collect 40 Lovely Charms.  You won't get a Lovely Charm from every mob you kill, so be prepared to grind for a while.
		..collect 40 Lovely Charm##49655 |n
		.' If you have a lot of money, or don't care about spending money and just want to do the quests very quickly, do this: |tip Go to the Auction House and buy 4 Lovely Charm Bracelets.
		.' If you chose to kill mobs, use your Lovely Charms to create 4 Lovely Charm Bracelets |use Lovely Charm##49655
		.collect 4 Lovely Charm Bracelet##49916
	step
		'Go to Stormwind City |goto Stormwind City |noway |c
		only if level >= 5 and level < 14
	step
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin Crushing the Crown##24658 |daily 
		only if level >= 5 and level < 14
	step
		goto 62.4,75.4
		.talk Public Relations Agent##37675
		..turnin A Perfect Puff of Perfume##24629
		..turnin A Cloudlet of Classy Cologne##24635
		..turnin Bonbon Blitz##24636
	step
		goto 85.8,31.7
		.talk King Varian Wrynn##29611
		..turnin A Gift for the King of Stormwind##24597
	step
		goto Stormwind City,22.6,56.0 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
	step
		|fly Grove of the Ancients
		only if level >= 14 and level < 23
 	step
		|fly Darnassus
		only if level >= 14 and level < 23
	step
		goto Darnassus,45.4,57.8
		.talk Kwee Q. Peddlefeet##16075
		..accept A Gift for the High Priestess of Elune##24610 |daily
	step
		goto Darnassus 43.0,78.0
		.talk Tyrande Whisperwind##7999
		..turnin A Gift for the High Priestess of Elune##24610
	step
		goto 37.0,50.5 |n
		.' Go into the pink portal to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto Teldrassil,52.3,89.5 |n
		.' Ride the boat to Azuremyst Isle |goto Azuremyst Isle |noway |c
	step
		goto The Exodar,73.6,57.0
		.talk Kwee Q. Peddlefeet##16075
		..accept A Gift for the Prophet##24611 |daily
	step
		goto 32.8,54.5
		.talk Prophet Velen##17468
		..turnin A Gift for the Prophet##24611
	step
		 |fly Rut'theran Village
	step
		goto Teldrassil,55.0,93.7 |n
		.' Ride the boat to Stormwind City |goto Stormwind City |noway |c
	step
		|fly Ironforge
	step
		goto Ironforge,40.0,55.1
		.talk King Magni Bronzebeard##2784
		..turnin A Gift for the Lord of Ironforge##24609
	step
		|fly Stormwind City
	step
		goto Stormwind City,80,38.4
		.talk King Varian Wrynn##29611
		..turnin A Gift for the King of Stormwind##24597
	step
		goto 61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin Crushing the Crown##24659 |daily
		only if level >= 14 and level < 23
	step
		|fly Aerie Peak
		only if level >= 23 and level < 32
	step
		'Go southwest to Hillsbrad Foothills |goto Hillsbrad Foothills |noway |c
		only if level >= 23 and level < 32
	step
		goto Hillsbrad Foothills,34.5,58.4
		.kill 5 Crown Duster |q 24660/2
		.' Use Snagglebolt's Khorium Bomb next to the big shaking Chemical Wagon |use Snagglebolt's Khorium Bomb##50130
		.' Destroy the Chemical Wagon |q 24660/1
		only if level >= 23 and level < 32
	step
		'Go northeast to The Hinterlands |goto The Hinterlands |noway |c
		only if level >= 23 and level < 32
	step
		goto The Hinterlands,11.1,46.2
		.talk Guthrum Thunderfist##8018
		.' Fly to Stormwind, Elwynn |goto Stormwind City,71.0,73.0,0.5 |noway |c
		only if level >= 23 and level < 32
	step
		goto Ironforge,55.5,47.8
		.talk Gryth Thurden##1573
		.' Fly to Menethil Harbor |goto Wetlands,9.4,59.5,0.5 |noway |c
		only if level >= 32 and level < 41
	step
		goto Wetlands,6.4,62.3 |n
		.' Ride the boat to Theramore |goto Dustwallow Marsh |noway |c
		only if level >= 32 and level < 41
	step
		goto Dustwallow Marsh,60.8,38.2
		.kill 5 Crown Hoodlum |q 24662/2
		.' Use Snagglebolt's Khorium Bomb next to the big shaking Chemical Wagon |use Snagglebolt's Khorium Bomb##50130
		.' Destroy the Chemical Wagon |q 24662/1
		only if level >= 32 and level < 41
	step
		goto 71.5,56.3|n
		.' Ride the boat to Menethil Harbor |goto Wetlands |noway |c
		only if level >= 32 and level < 41
	step
		goto Wetlands,9.4,59.6
		.talk Shellei Brondir##1571
		.' Fly to Stormwind, Elwynn |goto Stormwind City,71.0,73.0,0.5 |noway |c
		only if level >= 32 and level < 41
	step
		goto Stormwind City,70.9,72.5
		.talk Dungar Longdrink##352
		.' Fly to Aerie Peak, The Hinterlands |goto The Hinterlands,11.1,46.1,0.5 |noway |c
		only if level >= 41 and level < 51
	step
		goto The Hinterlands,23.6,53.7
		.kill 5 Crown Agent |q 24663/2
		.' Use Snagglebolt's Khorium Bomb next to the big shaking Chemical Wagon |use Snagglebolt's Khorium Bomb##50130
		.' Destroy the Chemical Wagon |q 24663/1
		only if level >= 41 and level < 51
	step
		goto The Hinterlands,11.1,46.2
		.talk Guthrum Thunderfist##8018
		.' Fly to Stormwind, Elwynn |goto Stormwind City,71.0,73.0,0.5 |noway |c
		only if level >= 41 and level < 51
	step
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin Crushing the Crown##24660 |only if level >= 23 and level < 32
		..turnin Crushing the Crown##24662 |only if level >= 32 and level < 41
		..turnin Crushing the Crown##24663 |only if level >= 41 and level < 51
		only if level >= 23 and level < 51
	step
		goto Stormwind City,22.6,56.0 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
		only if level >= 51 and level < 61	
	step
		goto Teldrassil,55.4,88.4
		.talk Vesprystus##3838
		.' Fly to Everlook |goto Winterspring,61.0,48.7,0.5 |noway |c
		only if level >= 51 and level < 61
	step
		goto Winterspring,63.6,49.4
		.kill 5 Crown Sprinkler |q 24664/2
		.' Use Snagglebolt's Khorium Bomb next to the big shaking Chemical Wagon |use Snagglebolt's Khorium Bomb##50130
		.' Destroy the Chemical Wagon |q 24664/1
		only if level >= 51 and level < 61
	step
		goto 61.0,48.6
		.talk Maethrya##11138
		.' Fly to Rut'theran Village, Teldrassil |goto Teldrassil,55.4,88.5,0.5 |noway |c
		only if level >= 51 and level < 61
	step
		goto Teldrassil,55.0,93.7 |n
		.' Ride the boat to Stormwind City |goto Stormwind City |noway |c
		only if level >= 51 and level < 61
	step
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin Crushing the Crown##24664
		only if level >= 51 and level < 61
	step
		goto Stormwind City,49.0,87.4 |n
		.' Click the Portal to Blasted Lands |tip It's a blue portal at the top of the mage tower.
		.' Teleport to the Blasted Lands |goto Blasted Lands |noway |c
		only if level >= 61 and level < 71
	step
		goto Blasted Lands,58.7,59.7 |n
		.' Go into the big green portal to Outland |goto Hellfire Peninsula |noway |c
		only if level >= 61 and level < 71
	step
		goto Hellfire Peninsula,87.4,52.4
		.talk Amish Wildhammer##18931
		.' Fly to Shattrath City |goto Shattrath City,63.8,41.7,0.5 |noway |c
		only if level >= 61 and level < 71
	step
		'Go outside of Shattrath City to Terokkar Forest |goto Terokkar Forest |noway |c
		only if level >= 61 and level < 71
	step
		goto Terokkar Forest,41.4,22.5
		.kill 5 Crown Underling |q 24665/2
		.' Use Snagglebolt's Khorium Bomb next to the big shaking Chemical Wagon |use Snagglebolt's Khorium Bomb##50130
		.' Destroy the Chemical Wagon |q 24665/1
		only if level >= 61 and level < 71
	step
		'Go inside Shattrath City |goto Shattrath City |noway |c
		only if level >= 61 and level < 71
	step
		goto Shattrath City,64.1,41.1
		.talk Nutral##18940
		.' Fly to Hellfire Peninsula, The Dark Portal, Alliance |goto Hellfire Peninsula,87.5,52.5,0.5 |noway |c
		only if level >= 61 and level < 71
	step
		'Go through the big green portal to Blasted Lands |goto Blasted Lands |noway |c
		only if level >= 61 and level < 71
	step
		|fly Stormwind City
		only if level >= 61 and level < 71
	step
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin Crushing the Crown##24665
		only if level >= 61 and level < 71
	step
		goto 18.2,25.5 |n
		.'Ride the boat to Borean Tundra |goto Borean Tundra |noway |c
		only if level >= 71 and level <=81
	step
		'Fly to Dalaran|goto Dalaran|noway|c
		only if level >= 74 and level <=81
	step
		.' Follow the road northeast to Dragonblight|goto Dragonblight|noway|c
		only if level >= 71 and level < 74
	step
		.' We recommend the following route to get through Dragonblight
		.' Follow the road north east to this point: [50.1,55.6]
		.' Head towards Wyrmrest temple to this point: [57.9,51.2]
		.' Travel north up the Path of the Titans starting at: [60.0,42.3]
		.' Continue up through the Crystal Vice starting here [64.6,23.9] |tip Avoid the elite giants the best you can
		.' Go north to Crystalsong Forest|goto Crystalsong Forest|noway|c
		only if level >= 71 and level < 74
	step
		goto Crystalsong Forest,49.0,47.8
		.kill 5 Crown Sprayer |q 24666/2
		.' Use Snagglebolt's Khorium Bomb next to the big shaking Chemical Wagon |use Snagglebolt's Khorium Bomb##50130
		.' Destroy the Chemical Wagon |q 24666/1
		only if level >= 71 and level <=81
	step
		'Go south to Dragonblight|goto Dragonblight|noway|c
		only if level >= 71 and level < 74
	step
		'Go to Dalaran|goto Dalaran,72.4,45.5,1|noway|c
		only if level >= 74 and level <=81
	step
		goto Dragonblight,64.6,23.9
		.' We recommend the following route to get through Dragonblight
		.' Follow The Crystal Vice to this point 64.6,23.9|tip Avoid the elite giants the best you can
		.' Travel south down the Path of the Titans to this point: 60.0,42.3
		.' Head towards Wyrmrest temple to this point: 57.9,51.2
		.' Follow the road west to this point: 50.1,55.6
		.' Go west to Borean Tundra|goto Borean Tundra|noway|c
		only if level >= 71 and level < 74
	step
		|fly Valiance Keep
		only if level >= 74 and level <=81
	step
		'Ride the boat to Stormwind City|goto Stormwind City|noway|c
		only if level >= 71 and level <=81
	step
		goto Stormwind City,61.6,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin Crushing the Crown##24666
		only if level >= 71 and level <=81
	step
		#include "uldum_port"
		only if level >=81
	step
		goto Uldum 67.9,19.8
		.kill 5 Crown Technician##51613+ |q 28934/2
		.' Use Snagglebolt's Khorium Bomb near the Chemical Wagon. |use Snagglebolt's Khorium Bomb##50130
		.' Chemical Wagon Destroyed |q 28934/1
		only if level >=81
	step
		#include "hearth_hub"
	step
		goto Stormwind City 61.5,75.3
		.talk Inspector Snip Snagglebolt##38066
		..turnin Crushing the Crown##28934 |daily 
		only if level >= 81
]])
ZygorGuidesViewer:RegisterInclude("Love is in the Air Achievement",[[
		'You will need Love Tokens in order to purchase items from vendors in this guide section. |tip You can get Love Tokens by completing the dailies in the Love is in the Air Dailies section. 
		|confirm always
	step
		goto Stormwind City,62.5,75.3
		.talk Lovely Merchant##37674
		.buy Bag of Heart Candies##21813 |n
		.' Get the 8 different types of Heart Candy:
		.' Be Mine! |collect 1 Heart Candy##21816
		.' I'll follow you all around Azeroth. |collect 1 Heart Candy##21818
		.' All yours. |collect 1 Heart Candy##21819
		.' I'm all yours! |collect 1 Heart Candy##21821
		.' Hot Lips. |collect 1 Heart Candy##21823
		.' You're Mine! |collect 1 Heart Candy##21822
		.' You're the best! |collect 1 Heart Candy##21820
		.' I LOVE YOU |collect 1 Heart Candy##21817
	step
		'Eat the 8 different type of Heart Candy:
		.' Be Mine! |achieve 1701/1 |use 1 Heart Candy##21816 
		.' I'll follow you all around Azeroth. |achieve 1701/2 |use 1 Heart Candy##21818 
		.' All yours. |achieve 1701/3 |use 1 Heart Candy##21819 
		.' I'm all yours! |achieve 1701/4 |use 1 Heart Candy##21821 
		.' Hot Lips. |achieve 1701/5 |use 1 Heart Candy##21823 
		.' You're Mine! |achieve 1701/6 |use 1 Heart Candy##21822 
		.' You're the best! |achieve 1701/7 |use 1 Heart Candy##21820 
		.' I LOVE YOU |achieve 1701/8 |use 1 Heart Candy##21817
	step
		goto 62.5,75.2
		.talk Lovely Merchant##37674
		.buy 10 Silver Shafted Arrow##22200 |n
		.' Use your Silver Shafted Arrows on 10 players inside Ironforge |use Silver Shafted Arrow##22200
		.' Shoot 10 Players with the Silver Shafted Arrow |achieve 1188
	step
		goto 62.5,75.2
		.talk Lovely Merchant##37674
		.buy 1 Box of Chocolates##49909 |n
		.' Use your Box of Chocolates and get all the chocolate contained inside of it |use Box of Chocolates##49909
		.' Eat each type of chocolate:
		.' Sweet Surprise |achieve 1702/3 |use Sweet Surprise##22239 
		.' Very Berry Cream |achieve 1702/4 |use Very Berry Cream##22238 
		.' Buttermilk Delight |achieve 1702/1 |use Buttermilk Delight##22236  |tip Save the remaining Buttermilk Delights for a later achievement.
		.' Dark Desire |achieve 1702/2 |use Dark Desire##22237 
	step
		goto 62.5,75.2
		.talk Lovely Merchant##37674
		.buy 10 Love Rocket##34258 |n
		.' Spam use your Love Rockets |use Love Rocket##34258
		.' Shoot off 10 Love Rockets in 20 seconds or less |achieve 1696
	step
		goto 62.5,75.2
		.talk Lovely Merchant##37674
		.buy 15 Handful of Rose Petals##22218 |achieve 1699
		.buy 1 Romantic Picnic Basket##34480 |achieve 1291
		.buy 1 "VICTORY" Perfume##49856 |achieve 1279
		.buy 5 Love Fool##22261 |achieve 1704
	step
		goto 75.4,53.5
		.talk Elly Langston##1328
		.buy 6 Flagon of Mead##2594 |achieve 1279
	step
		'Go to Dalaran |goto Dalaran |noway |c
	step
		'All around Dalaran:
		.' Use your Handful of Rose Petals on the follow race/class combinations: |use Handful of Rose Petals##22218 |tip Save any extra Handfuls of Rose Petals you have, you'll need one later.
		.' Gnome Warlock |achieve 1699/1
		.' Orc Death Knight |achieve 1699/2
		.' Human Death Knight |achieve 1699/3
		.' Night Elf Priest |achieve 1699/4
		.' Orc Shaman |achieve 1699/5
		.' Tauren Druid |achieve 1699/6
		.' Undead Warrior |achieve 1699/7
		.' Troll Rogue |achieve 1699/8
		.' Blood Elf Mage |achieve 1699/9
		.' Draenei Paladin |achieve 1699/10
		.' Dwarf Hunter |achieve 1699/11
	step
		'In Dalaran:
		.' Find a player to have a picnic with you
		.' Use your Romantic Picnic Basket |use Romantic Picnic Basket##34480
		.' While having a picnic, use your Buttermilk Delight |use Buttermilk Delight##22236
		.' Enjoy a Buttermilk Delight with someone in Dalaran at a Romantic Picnic |achieve 1291
	step
		'Go to Wintergrasp in Northrend:
		.' Use your Love Fool anywhere inside Wintergrasp |use Love Fool##22261
		.' Target the Love Fool and Pity it |script DoEmote("PITY") |achieve 1704/1
	step
		'Go to Ironforge |goto Ironforge |noway |c
	step
		goto 42.4,35.7
		.' Find Sraaz |tip He's a gnome that walks around the circle around The Great Forge.
		.' Do the following exactly in order from top to bottom in the step:
		.' Use all 6 of your Flagons of Mead to get Completely Smashed |use Flagon of Mead##2594
		.' Use your "VICTORY" Perfume |use "VICTORY" Perfume##49856
		.' Use your Handful of Rose Petals on Sraaz |use Handful of Rose Petals##22218 |achieve 1279/1
		.' Kiss Sraaz |script DoEmote("KISS") |achieve 1279/2
	step
		'Go to the Gurubashi Arena in The Cape of Stranglethorn: |tip The Cape of Stranglethorn is the southern-most zone on the Eastern Kingdoms continent.
		.' Use your Love Fool anywhere inside the Gurubashi Arena |use Love Fool##22261
		.' Target the Love Fool and Pity it |script DoEmote("PITY") |achieve 1704/2
	step
		'Enter the Arathi Basin PvP Battleground:
		.' Use your Love Fool inside the Blacksmith subzone inside Arathi Basin |use Love Fool##22261
		.' Target the Love Fool and Pity it |script DoEmote("PITY") |achieve 1704/3
	step
		'Enter the Culling of Stratholme dungeon:
		.' Use your Love Fool anywhere inside the Culling of Stratholme dungeon |use Love Fool##22261
		.' Target the Love Fool and Pity it |script DoEmote("PITY") |achieve 1704/4
	step
		'Enter the Naxxramas raid:
		.' Use your Love Fool anywhere inside the Naxxramas raid |use Love Fool##22261
		.' Target the Love Fool and Pity it |script DoEmote("PITY") |achieve 1704/5
	step
		'Go to a place where the mobs are at least green to you, they cannot be grey to you, or they won't drop the items you need.
		.' Kill the mobs until you collect 120 Lovely Charms.  |tip You won't get a Lovely Charm from every mob you kill, so be prepared to grind for a while.
		.collect 120 Lovely Charm##49655 |n
		.' Use your Lovely Charms to create 12 Lovely Charm Bracelets |use Lovely Charm##49655
		.' Create 12 Lovely Charm Bracelets |achieve 260
	step
		'Kill these certain bosses in any of the following dungeons: |tip You can enter either Normal or Heroic difficulty, it doesn't matter.
		.' Drahga Shadowburner in Grim Batol
		.' Corla, Herald of Twilight in Blackrock Caverns
		.' High Priestess Azil in The Stonecore
		.' Admiral Ripsnarl in Deadmines
		.' Lord Godfrey in Shadowfang Keep
		.' Get either of these 2 items as a random drop from these bosses:
		.collect 1 Bouquet of Red Roses##22206 |n
		.collect 1 Bouquet of Ebon Roses##44731 |n
		.' Obtain a Bouquet of Red or Ebon Roses during the Love is in the Air celebration |achieve 1703 
	step
		'Congratulations, you are a Fool For Love!
]])

-- Noblegarden --
ZygorGuidesViewer:RegisterInclude("Noblegarden Quests",[[
		goto Darnassus,44.7,52.9
		.talk Night Elf Commoner##19173
		..accept Spring Collectors##13484
	step
		'Leave out of the east exit of Darnassus to go outside to Teldrassil |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.6,51.4
		.talk Spring Collector##32799
		..turnin Spring Collectors##13484
		..accept The Great Egg Hunt##13480 |daily
	step
		goto 55.7,51.3
		.talk Noblegarden Vendor##32836
		..accept A Tisket, a Tasket, a Noblegarden Basket##13502
	step
		'Search around Dolanaar for Brightly Colored Eggs and click them:
		.' Click Brightly Colored Eggs |tip They look like small Easter eggs on the ground. There is at least one available at all times. You don't have to wait for respawns. If Dolanaar is too crowded with other players looking for eggs, you can also find them at Azure Watch, Goldshire, and Kharanos.
		.collect Brightly Colored Egg##45072+ |n
		.' Click Brightly Colored Eggs in your bags |use Brightly Colored Egg##45072
		.get 20 Brightly Colored Shell Fragment |q 13480/1
		.get 10 Noblegarden Chocolate |q 13502/1
	step
		goto 55.7,51.3
		.talk Noblegarden Vendor##32836
		..turnin A Tisket, a Tasket, a Noblegarden Basket##13502
	step
		goto 55.6,51.4
		.talk Spring Collector##32799
		..turnin The Great Egg Hunt##13480
]])
ZygorGuidesViewer:RegisterInclude("Noblegarden Achievements",[[
		'You may be unable to complete some of the achievements if you are lower level.  So, if you find you cannot do something in this guide, simply skip it and do what you can.
	step
		goto Teldrassil,55.5,51.0
		.' Click Brightly Colored Eggs |tip They look like small Easter eggs on the ground. There is at least one available at all times. You don't have to wait for respawns. If Dolanaar is too crowded with other players looking for eggs, you can also find them at Azure Watch, Goldshire, and Kharanos.
		.collect Brightly Colored Egg##45072+ |n
		.' Click Brightly Colored Eggs in your bags |use Brightly Colored Egg##45072
		.collect 100 Noblegarden Chocolate##44791+ |n
		.' Eat 100 Noblegarden Chocolates |achieve 2418 |use Noblegarden Chocolate##44791
		.' Discover a White Tuxedo Shirt by opening Brightly Colored Eggs |achieve 248/1
		.' Discover Black Tuxedo Pants by opening Brightly Colored Eggs |achieve 248/2
		.' Discover an Elegant Dress by opening Brightly Colored Eggs |achieve 249
	step
		'If you don't already have these items, collect Noblegarden Chocolates and purchase them from the Noblegarden Vendor at [55.7,51.3]:
		.collect Noblegarden Egg##44818 |achieve 2421 |tip It costs 5 Noblegarden Chocolates.
		.collect Blossoming Branch##44792 |achieve 2416 |tip It costs 10 Noblegarden Chocolates.
		.collect Spring Flowers##45073 |achieve 2422 |tip It costs 50 Noblegarden Chocolates.
		.collect Spring Robes##44800 |achieve 2436 |tip It costs 50 Noblegarden Chocolates.
		.collect Spring Rabbit's Foot##44794 |achieve 2419 |tip It costs 100 Noblegarden Chocolates.
	step
		goto Teldrassil,55.5,51.0
		.' Use your Spring Rabbit's Foot in your bags to get a Spring Rabbit companion |use Spring Rabbit's Foot##44794
		.' Bring out your Spring Rabbit companion |tip Hold SHIFT and press P to bring up your Pets screen, then click the Spring Rabbit icon.
		.' Find a player with a Spring Rabbit next to them around Dolanaar |tip Spring Rabbits look like small brown and white rabbits.  
		.' Find your Spring Rabbit another one to love in Dolanaar |achieve 2419/2
	step
		'Go west to Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,36.9,50.5 |n
		.' Go inside the pink portal to Teldrassil |goto Teldrassil |noway |c
	step
		goto Teldrassil,52.3,89.5 |n
		.' Ride the boat to Azuremyst Isle |goto Azuremyst Isle |noway |c
	step
		goto Azuremyst Isle,49.1,52.0
		.' Bring out your Spring Rabbit companion |tip Hold SHIFT and press P to bring up your Pets screen, then click the Spring Rabbit icon.
		.' Find a player with a Spring Rabbit next to them around Azure Watch |tip Spring Rabbits look like small brown and white rabbits.  
		.' Find your Spring Rabbit another one to love in Azure Watch |achieve 2419/1
	step
		goto 21.4,54.0 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.4,88.4
		.talk Vesprystus##3838
		.' Fly to Thunk's Abode, Desolace |goto Desolace,70.7,32.9,0.5 |noway |c
	step
		'Equip your Spring Robes in your bags
		.' Use your Spring Robes' ability to plant a flower |tip Press C to open your character's equipment screen, then right-click your equipped Spring Robes to use its ability.
		.' Plant a flower in Desolace |achieve 2436/2
	step
		goto Desolace,70.7,32.9
		.talk Thunk's Wyvern##35556
		.' Fly to Fizzle and Pozzik's Speedbarge, Thousand Needles |goto Thousand Needles,79.1,71.9,0.5 |noway |c
	step
		goto Thousand Needles,90.3,72.8
		.' Equip your Spring Robes in your bags
		.' Use your Spring Robes' ability to plant a flower |tip Press C to open your character's equipment screen, then right-click your equipped Spring Robes to use its ability.
		.' Plant a flower in Thousand Needles |achieve 2436/5
	step
		goto 79.2,72.0
		.talk Tilly Topspin##40768
		.' Fly to Cenarion Hold, Silithus |goto Silithus,54.5,32.9,0.5 |noway |c
	step
		'Equip your Spring Robes in your bags
		.' Use your Spring Robes' ability to plant a flower |tip Press C to open your character's equipment screen, then right-click your equipped Spring Robes to use its ability.
		.' Plant a flower in Silithus |achieve 2436/3
	step
		goto Silithus,54.4,32.7
		.talk Cloud Skydancer##15177
		.' Fly to Mossy Pile, Un'Goro Crater |goto Un'Goro Crater,44.0,40.2,0.5 |noway |c
	step
		goto Un'Goro Crater,35.8,50.7
		.' Change into a bunny |tip You will need a friend to do this, or at least another player.  There should be plenty of players trying to do this achievement at the same time, so it should be easy to find help.  Have your friend, or other player, use their Blossoming Branch on you to turn you into a rabbit.
		.' Stand in this spot until you lay an egg
		.' Lay a Noblegarden Egg in the Golakka Hot Springs |achieve 2416
	step
		goto 44.1,40.3
		.talk Flizzy Coilspanner##39175
		.' Fly to Gadgetzan, Tanaris |goto Tanaris,51.4,29.4,0.5 |noway |c
	step
		'Equip your Spring Robes in your bags
		.' Use your Spring Robes' ability to plant a flower |tip Press C to open your character's equipment screen, then right-click your equipped Spring Robes to use its ability.
		.' Plant a flower in Tanaris |achieve 2436/4
	step
		goto Tanaris,51.4,29.5
		.talk Bera Stonehammer##7823
		.' Fly to Theramore, Dustwallow Marsh |goto Dustwallow Marsh,67.5,51.2,0.5 |noway |c
	step
		goto Dustwallow Marsh,71.5,56.3 |n
		.' Ride the boat to Menethil Harbor |goto Wetlands |noway |c
	step
		goto Wetlands,9.4,59.6
		.talk Shellei Brondir##1571
		.' Fly to Dustwind Dig, Badlands |goto Badlands,48.8,36.2,0.5 |noway |c
	step
		'Equip your Spring Robes in your bags
		.' Use your Spring Robes' ability to plant a flower |tip Press C to open your character's equipment screen, then right-click your equipped Spring Robes to use its ability.
		.' Plant a flower in The Badlands |achieve 2436/1
	step
		goto Badlands,49.0,36.2
		.talk Nancy Skybrew##44409
		.' Fly to Kharanos, Dun Morogh |goto Dun Morogh,53.7,52.7,0.5 |noway |c
	step
		goto Dun Morogh,53.5,51.2
		.' Bring out your Spring Rabbit companion |tip Hold SHIFT and press P to bring up your Pets screen, then click the Spring Rabbit icon.
		.' Find a player with a Spring Rabbit next to them around Kharanos |tip Spring Rabbits look like small brown and white rabbits.  
		.' Find your Spring Rabbit another one to love in Kharanos |achieve 2419/4
	step
		goto 53.8,52.8
		.talk Brolan Galebeard##43701
		.' Fly to Stormwind, Elwynn |goto Stormwind City,71.0,73.0,0.5 |noway |c
	step
		'Use your Noblegarden Egg anywhere in Stormwind City |use Noblegarden Egg##44818
		.' Hide a Brightly Colored Egg in Stormwind City |achieve 2421
	step
		goto Stormwind City,70.9,72.5
		.talk Dungar Longdrink##352
		.' Fly to Goldshire, Elwynn |goto Elwynn Forest,41.8,64.6,0.5 |noway |c
	step
		goto Elwynn Forest,43.1,67.6
		.' Bring out your Spring Rabbit companion |tip Hold SHIFT and press P to bring up your Pets screen, then click the Spring Rabbit icon.
		.' Find a player with a Spring Rabbit next to them around Goldshire |tip Spring Rabbits look like small brown and white rabbits.  
		.' Find your Spring Rabbit another one to love in Goldshire |achieve 2419/3
	step
		'Equip your Black Tuxedo Pants and White Tuxedo Shirt
		.' Find another player who is wearing the Elegant Dress and perform the Kiss emote on them |script DoEmote("KISS") |tip The Elegant Dress looks like a long pink dress when worn.
		.' Kiss someone wearing an Elegant Dress while wearing a White Tuxedo Shirt and Black Tuxedo Pants |achieve 2576
	step
		'Find a female character of every race that are at least level 18 and do the following: |tip The best place, by far, to find them is in Dalaran.  You could also try Shattrath.
		.' Use your Spring Flowers on them |use Spring Flowers##45073
		.' Place bunny ears on a Blood Elf |achieve 2422/1
		.' Place bunny ears on a Human |achieve 2422/5
		.' Place bunny ears on a Troll |achieve 2422/9
		.' Place bunny ears on a Draenei |achieve 2422/2
		.' Place bunny ears on a Night Elf |achieve 2422/6
		.' Place bunny ears on a Undead |achieve 2422/10
		.' Place bunny ears on a Dwarf |achieve 2422/3
		.' Place bunny ears on a Orc |achieve 2422/7
		.' Place bunny ears on a Gnome |achieve 2422/4
		.' Place bunny ears on a Tauren |achieve 2422/8
	step
		'Congratulations, you are now a Noble Gardener!
]])

-- Children's Week --
ZygorGuidesViewer:RegisterInclude("Children's Week Stormwind",[[
		goto Stormwind City,56.3,54.0
		.talk Orphan Matron Nightingale##14450
		..accept Children's Week##1468
	step
		'Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.talk Human Orphan##14305
		..turnin Children's Week##1468
		..accept Cruisin' the Chasm##29093
		..accept The Biggest Diamond Ever!##29106
		..accept Malfurion Has Returned!##29107		
	step
		goto Stormwind City,71.0,72.5
		.talk Dungar Longdrink##352
		.' Fly to Sentinel Hill, Westfall |goto Westfall,56.6,49.4,0.5 |noway |c
	step
		goto Westfall,57.8,53.0
		.' Click a Rental Chopper |tip They look like motorcycles with luggage on the back of them.
		.' Give Your Orphan a Chopper Tour of the Raging Chasm |q 29093/1
	step
		'Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.talk Human Orphan##14305
		..turnin Cruisin' the Chasm##29093
	step
		goto 56.6,49.4
		.talk Thor##523
		.' Fly to Ironforge, Dun Morogh |goto Ironforge,55.6,47.7,0.5 |noway |c
	step
		goto Ironforge,44.2,51.8 |n
		.' Follow the path down |goto Ironforge,44.2,51.8,0.5 |noway |c
	step
		goto 33.2,47.8
		.' Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.' Take Your Orphan to Visit King Magni in Old Ironforge |q 29106/1
	step
		'Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.talk Human Orphan##14305
		..turnin The Biggest Diamond Ever!##29106
	step
		goto 42.2,46.7 |n
		.' Follow the path up |goto 42.2,46.7,0.5 |noway |c
	step
		goto 55.5,47.7
		.talk Gryth Thurden##1573
		.' Fly to Stormwind, Elwynn |goto Stormwind City,71.0,73.0,0.5 |noway |c
	step
		goto Stormwind City,22.6,55.8 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.1,88.5 |n
		.' Enter the pink portal to Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,43.1,78.1
		.' Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.' Take Your Orphan to Visit Malfurion Stormrage |q 29107/1
	step
		'Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.talk Human Orphan##14305
		..turnin Malfurion Has Returned!##29107
		..accept Let's Go Fly a Kite##29117
		..accept You Scream, I Scream...##29119
	step
		goto 37.0,50.5 |n
		.' Enter the pink portal to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.0,93.6 |n
		.' Ride the boat to Stormwind City |goto Stormwind City |noway |c
	step
		goto Stormwind City,58.8,64.1
		.talk Craggle Wobbletop##52358
		.buy Dragon Kite 2-Pack##68890 |q 29117
	step
		'Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.' When your orphan is next to you:
		.' Use your Dragon Kite 2-Pack |use Dragon Kite 2-Pack##68890
		.' Fly Dragon Kites with Your Orphan |q 29117/1
	step
		'Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.talk Human Orphan##14305
		..turnin Let's Go Fly a Kite##29117
	step
		goto 49.0,89.7
		.talk Hans Coldhearth##52421
		.buy Cone of Cold##69027 |q 29119
	step
		'Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.' When your orphan is next to you:
		.' Use your Cone of Cold |use Cone of Cold##69027
		.' Take Your Orphan Out for Ice Cream |q 29119/1
	step
		'Use your Human Orphan Whistle to summon your Human Orphan |use Human Orphan Whistle##18598
		.talk Human Orphan##14305
		..turnin You Scream, I Scream...##29119
		..accept A Warden of the Alliance##171
	step
		goto 58.8,64.1
		.talk Craggle Wobbletop##52358
		.get Foam Sword Rack |q 171/1 |tip Buy this from Craggle Wobbletop.
	step
		goto 56.3,54.0
		.talk Orphan Matron Nightingale##51988
		..turnin A Warden of the Alliance##171 |tip You will be able to choose from 4 pet companions or a 5 gold reward.  If you already have all 4 pets, choose the gold.  You will be able to do this quest each year, so you will be able to collect all 4 pets, eventually.
]])
ZygorGuidesViewer:RegisterInclude("Children's Week Shattrath",[[
		goto Shattrath City,74.9,47.9
		.talk Orphan Matron Mercy##22819
		..accept Children's Week##10943
	step
		'Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.talk Draenei Orphan##22818
		..turnin Children's Week##10943
		..accept Auchindoun and the Ring of Observance##10950
		..accept A Trip to the Dark Portal##10952
		..accept Jheel is at Aeris Landing!##10954
	step
		goto Nagrand,31.5,57.6
		.' Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.' Take Dornaa taken to Aeris Landing |q 10954/1
	step
		goto Nagrand,31.5,57.6
		.talk Jheel##22836
		..turnin Jheel is at Aeris Landing!##10954
	step
		goto Terokkar Forest,39.8,64.7
		.' Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.' Take Dornaa to the Ring of Observance |q 10950/1
	step
		'Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.talk Draenei Orphan##22818
		..turnin Auchindoun and the Ring of Observance##10950
	step
		goto Hellfire Peninsula,89.6,50.2
		.' Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.' Take Dornaa to the Dark Portal |q 10952/1
	step
		'Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.talk Draenei Orphan##22818
		..turnin A Trip to the Dark Portal##10952
		..accept The Seat of the Naaru##10956
		..accept Time to Visit the Caverns##10962
	step
		'Go through the Dark Portal to the Blasted Lands |goto Blasted Lands |noway |c
	step
		goto Blasted Lands,61.3,21.6
		.talk Alexandra Constantine##8609
		..' Fly to Booty Bay, Stranglethorn |goto The Cape of Stranglethorn,27.5,77.7,0.5 |noway |c
	step
		goto The Cape of Stranglethorn,39.1,67.0 |n
		.' Ride the boat to Ratchet |goto Northern Barrens |noway |c
	step
		goto Northern Barrens,69.1,70.7
		.talk Bragok##16227
		..' Fly to Gadgetzan, Tanaris |goto Tanaris,51.4,29.4,0.5 |noway |c
	step
		goto Tanaris,61.5,50.6 |n
		.' The path to Zaladormu starts here |goto Tanaris,61.5,50.6,1 |noway |c
	step
		goto Tanaris,64.9,50.0 |n
		.' Enter the Caverns of Time here |goto Tanaris,64.9,50.0,0.5 |noway |c
	step
		'Follow the path down to 59.9,57.2 |goto Tanaris,59.9,57.2 |tip You will end up underground, in the Caverns of Time, next to a big dragon named Zaladormu, who is laying on a big platform.
		.' Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.' Take Dornaa to the Caverns of Time |q 10962/1
	step
		goto 63.0,57.3
		.talk Alurmi##21643
		.get Toy Dragon##31951 |q 10962/2
	step
		'Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.talk Draenei Orphan##22818
		..turnin Time to Visit the Caverns##10962
	step
		'Go outside to 51.4,29.5 |goto 51.4,29.5
		.talk Bera Stonehammer##7823
		..' Fly to Rut'theran Village, Teldrassil |goto Teldrassil,55.4,88.4,0.5 |noway |c
	step
		goto Teldrassil,55.2,88.4 |n
		.' Go through the pink portal to Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,44.2,78.7 |n
		.' Click the Portal to Exodar |goto The Exodar |noway |c
	step
		goto The Exodar,58.0,41.4
		.' Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.' Take Dornaa to the Seat of the Naaru |q 10956/1
	step
		goto The Exodar,58.0,41.4
		.talk O'ros##17538
		..turnin The Seat of the Naaru##10956
		..accept Call on the Farseer##10968
	step
		goto The Exodar,30.4,33.1
		.' Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.' Take Dornaa to to Farseer Nobundo |q 10968/1
	step
		goto The Exodar,30.4,33.1
		.talk Farseer Nobundo##17204
		..turnin Call on the Farseer##10968
	step
		'Use your Draenei Orphan Whistle to summon your Draenei Orphan |use Draenei Orphan Whistle##31881
		.talk Draenei Orphan##22818
		..accept Back to the Orphanage##10966
	step
		goto The Exodar,48.1,63.0 |n
		.' Click the Portal to Blasted Lands |goto Blasted Lands |noway |c
	step
		'Go south through the Dark Portal to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
	step
		goto Hellfire Peninsula,87.4,52.4
		.talk Amish Wildhammer##18931
		..' Fly to Shattrath, Terokkar Forest |goto Shattrath City |noway |c
	step
		goto Shattrath City,74.9,47.9
		.talk Orphan Matron Mercy##22819
		..turnin Back to the Orphanage##10966 |tip You will be able to choose from 3 pet companions.  You will be able to do this quest each year, so you will be able to collect all 3 pets, eventually.
		
]])
ZygorGuidesViewer:RegisterInclude("Children's Week Dalaran Oracles Quests",[[
		goto Dalaran,49.4,63.2
		.talk Orphan Matron Aria##34365
		..accept Little Orphan Roo Of The Oracles##13926
		..' Ask about the orphans
		..' Speak to Orphan Matron Aria and accept to care for the Oracle Orphan |q 13926/1
	step
		'Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.talk Oracle Orphan##33533
		..turnin Little Orphan Roo Of The Oracles##13926
		..accept The Biggest Tree Ever!##13929
		..accept The Bronze Dragonshrine##13933
		..accept Playmates!##13950 
	step
		goto Grizzly Hills,50.8,42.8
		.' Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.' Take Roo to visit Grizzlemaw |q 13929/1
	step
		'Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.talk Oracle Orphan##33533
		..turnin The Biggest Tree Ever!##13929
	step
		goto Dragonblight,72.5,36.9
		.' Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.' Take Roo to visit the Bronze Dragonshrine |q 13933/1
	step
		'Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.talk Oracle Orphan##33533
		..turnin The Bronze Dragonshrine##13933
	step
		goto Borean Tundra,43.5,13.7
		.' Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.' Take Roo to visit Winterfin Retreat |q 13950/1
	step
		'Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.talk Oracle Orphan##33533
		..turnin Playmates!##13950
		..accept The Dragon Queen##13954
		..accept Meeting a Great One##13956
	step
		goto Sholazar Basin,40.3,83.0 |n
		.' Walk into the light to teleport to Un'Goro Crater |goto Un'Goro Crater |noway |c
	step
		goto Un'Goro Crater,47.5,9.2
		.' Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.' Take Roo to visit The Etymidian |q 13956/1
	step
		'Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.talk Oracle Orphan##33533
		..turnin Meeting a Great One##13956
	step
		goto Un'Goro Crater,50.5,7.8 |n
		.' Walk into the light to teleport to Sholazar Basin |goto Sholazar Basin |noway |c
	step
		goto Dragonblight,59.8,54.7
		.' Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.' Take Roo to visit Alexstrasza the Life-Binder |q 13954/1 |tip Alexstrasza the Life-Binder is at the top of Wyrmrest Temple.
	step
		'Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.talk Oracle Orphan##33533
		..turnin The Dragon Queen##13954
		..accept A Trip To The Wonderworks##13937
	step
		goto Dragonblight,60.3,51.6
		.talk Nethestrasz##26851
		..' Fly to Dalaran |goto Dalaran |noway |c
	step
		goto Dalaran,44.9,45.6
		.talk Jepetto Joybuzz##29478
		..collect 1 Small Paper Zeppelin##46693
	step
		'Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.' Use your Small Paper Zeppelin on your Oracle Orphan |use Small Paper Zeppelin##46693
		.' Throw the Small Paper Zeppelin to Roo |q 13937/1
	step
		'Use your Oracle Orphan Whistle to summon your Oracle Orphan |use Oracle Orphan Whistle##46397
		.talk Oracle Orphan##33533
		..turnin A Trip To The Wonderworks##13937
		..accept Back To The Orphanage##13959
	step
		goto Dalaran,49.4,63.2
		.talk Orphan Matron Aria##34365
		..turnin Back To The Orphanage##13959 |tip You will receive a Curious Oracle Hatchling pet companion in the mail.
]])
ZygorGuidesViewer:RegisterInclude("Children's Week Dalaran Wolvar Quests",[[
		goto Dalaran,49.4,63.2
		.talk Orphan Matron Aria##34365
		..accept Little Orphan Kekek Of The Wolvar##13927
		..' Ask about the orphans
		..' Speak to Orphan Matron Aria and accept to care for the Wolvar Orphan |q 13927/1
	step
		'Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.talk Wolvar Orphan##33532
		..turnin Little Orphan Kekek Of The Wolvar##13927
		..accept Home Of The Bear-Men##13930
		..accept The Bronze Dragonshrine##13934
		..accept Playmates!##13951 
	step
		goto Grizzly Hills,50.8,42.8
		.' Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.' Take Kekek to visit Grizzlemaw |q 13930/1
	step
		'Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.talk Wolvar Orphan##33532
		..turnin Home Of The Bear-Men##13930
	step
		goto Dragonblight,72.5,36.9
		.' Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.' Take Kekek to visit the Bronze Dragonshrine |q 13934/1
	step
		'Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.talk Wolvar Orphan##33532
		..turnin The Bronze Dragonshrine##13934
	step
		goto Dragonblight,45.3,63.3
		.' Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.' Take Kekek to visit Snowfall Glade |q 13951/1
	step
		'Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.talk Wolvar Orphan##33532
		..turnin Playmates!##13951
		..accept The Dragon Queen##13955
		..accept The Mighty Hemet Nesingwary##13957
	step
		goto Dragonblight,59.8,54.7
		.' Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.' Take Kekek to visit Alexstrasza the Life-Binder |q 13955/1 |tip Alexstrasza the Life-Binder is at the top of Wyrmrest Temple.
	step
		'Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.talk Wolvar Orphan##33532
		..turnin The Dragon Queen##13955
	step
		goto Sholazar Basin,27.1,58.7
		.' Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.' Take Kekek to visit Hemet Nesingwary |q 13957/1
	step
		'Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.talk Wolvar Orphan##33532
		..turnin The Mighty Hemet Nesingwary##13957	
		..accept A Trip To The Wonderworks##13938
	step
		goto Sholazar Basin,25.3,58.5
		.talk The Spirit of Gnomeregan##28037
		..' Fly to Dalaran |goto Dalaran |noway |c
	step
		goto Dalaran,44.9,45.6
		.talk Jepetto Joybuzz##29478
		..collect 1 Small Paper Zeppelin##46693
	step
		'Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.' Use your Small Paper Zeppelin on your Wolvar Orphan |use Small Paper Zeppelin##46693
		.' Throw the Small Paper Zeppelin to Kekek |q 13938/1
	step
		'Use your Wolvar Orphan Whistle to summon your Wolvar Orphan |use Wolvar Orphan Whistle##46396
		.talk Wolvar Orphan##33532
		..turnin A Trip To The Wonderworks##13938
		..accept Back To The Orphanage##28880
	step
		goto Dalaran,49.4,63.2
		.talk Orphan Matron Aria##34365
		..turnin Back To The Orphanage##28880 |tip You will receive a Curious Wolvar Pup pet companion in the mail.
]])
ZygorGuidesViewer:RegisterInclude("Children's Week Achievements",[[
		goto Stormwind City,56.3,54.0
		.talk Orphan Matron Nightingale##14450
		..' Ask her for another Orphan Whistle
		.collect 1 Human Orphan Whistle##18598
	step
		'Complete any 5 daily quests of your choice: |tip Make sure your orphan is standing next to you when turning in the daily quests, or you won't get credit for this achievement.
		.' Get the Daily Chores Achievement |achieve 1789
	step
		goto Stormwind City,61.3,75.0
		.talk Emmithue Smails##14481
		..buy Tigule and Foror's Strawberry Ice Cream##7228 |achieve 1788
	step
		'Purchase the follow items from the Auction House, or use your Cooking ability to create them, if you'd like:
		.collect 1 Tasty Cupcake##43490 |achieve 1788
		.collect 1 Delicious Chocolate Cake##33924 |achieve 1788
	step
		goto Dalaran,51.2,29.1
		.talk Aimee##29548
		..buy 1 Red Velvet Cupcake##42429 |achieve 1788
		..buy 1 Lovely Cake##42438 |achieve 1788
		..buy 1 Dalaran Doughnut##42430 |achieve 1788
		..buy 1 Dalaran Brownie##42431 |achieve 1788
	step
		'Use your Lovely Cake in your bags to place a cake on the ground |use Lovely Cake##42438
		.' Click the Lovely Cake
		.collect 1 Lovely Cake Slice##42434 |achieve 1788
	step
		'Use whichever Orphan Whistle you currently have to summon your Orphan, so that the Orphan is standing next to you:
		.' Eat Tigule and Foror's Strawberry Ice Cream |achieve 1788/1 |use Tigule and Foror's Strawberry Ice Cream##7228
		.' Eat Tasty Cupcake |achieve 1788/2 |use Tasty Cupcake##43490
		.' Eat Red Velvet Cupcake |achieve 1788/3 |use Red Velvet Cupcake##42429
		.' Eat Delicious Chocolate Cake |achieve 1788/4 |use Delicious Chocolate Cake##33924
		.' Eat Lovely Cake Slice |achieve 1788/5 |use Lovely Cake Slice##42434
		.' Eat Dalaran Brownie |achieve 1788/6 |use Dalaran Brownie##42431
		.' Eat Dalaran Doughnut |achieve 1788/7 |use Dalaran Doughnut##42430
	step
		'Use your Hearthstone while your Orphan is standing next to you |use Hearthstone##6948
		.' Get the Home Alone Achievement |achieve 1791
	step
		'The following achievements are a little more dynamic, so we cannot walk you step-by-step through getting them.  Skip to the next guide step.
	step
		'Find a group, run the Utgarde Pinnacle dungeon, and defeat King Ymiron |tip Make sure your Orphan is standing next to you when you defeat King Ymiron, or else you won't get credit for the achievement.
		.' Get the Hail To The King, Baby Achievement |achieve 1790
	step
		'Enter the Eye of the Storm battleground and capture the flag |tip Make sure your Orphan is standing next to you when you capture the flag, or else you won't get credit for the achievement.
		.' Capture the flag in Eye of the Storm |achieve 1786/1
	step
		'Enter the Alterac Valley battleground and assault a tower |tip Make sure your Orphan is standing next to you when you assault the tower, or else you won't get credit for the achievement.
		.' Assault a tower in Alterac Valley |achieve 1786/2
	step
		'Enter the Arathi Basin battleground and assault a flag |tip Make sure your Orphan is standing next to you when you assault the flag, or else you won't get credit for the achievement.
		.' Assault a flag in Arathi Basin |achieve 1786/3
	step
		'Enter the Warsong Gulch battleground and return a fallen flag |tip Make sure your Orphan is standing next to you when you return the fallen flag, or else you won't get credit for the achievement.
		.' Return a fallen flag in Warsong Gulch |achieve 1786/4
	step
		'Congratulations, you do it For The Children!
]])

-- Midsummer Fire Festival --
ZygorGuidesViewer:RegisterInclude("Midsummer Fire Festival Quests",[[
		goto Stormwind City,60.4,75.3
		.talk Innkeeper Allison##6740
		.home Trade District
	step
		goto Stormwind City,61.7,74.2
		.talk Human Commoner##189276
		..accept The Master of Summer Lore##11970
	step
		goto 49.5,72.3
		.talk Festival Loremaster##16817
		..accept Incense for the Summer Scorchlings##11964
	step
		goto 49.3,72.3
		.talk Earthen Ring Elder##26221
		..accept Unusual Activity##11886
	step
		goto Stormwind City,50.0,72.3
		.talk Master Fire Eater##25975
		..accept Torch Tossing##11731
	step
		'Use your Practice Torches in your bags and throw them at the Torch Target Braziers nearby |use Practice Torches##34862 |tip You must throw the torches at the correct braziers.  Throw the torches at the Torch Target Braziers when they have a floating red arrow point down above them. You will have 40 seconds to complete this before the quest fails.
		.' Hit 8 braziers |q 11731/1
	step
		goto Stormwind City,50.0,72.3
		.talk Master Fire Eater##25975
		..turnin Torch Tossing##11731
		..accept Torch Catching##11657
	step
		goto 49.8,72.4
		.' Use your Unlit Torches in your bags next to the bonfire |use Unlit Torches##34833
		.' As soon as you light torch, it will fly in the air.  There will be a small round shadow on the ground indicating where the torch is flying.  Follow that shadow and catch the torch.  When you catch the torch, it will be thrown in the air again.  Follow the shadow again and catch the torch.  Do this until you've caught the torch 4 times in a row without it hitting the ground.
		.' Catch 4 torches in a row. |q 11657/1
	step
		goto 50.1,72.3
		.talk Master Fire Eater##25975
		..turnin Torch Catching##11657
	step
		goto Elwynn Forest,43.5,62.5
		.talk Summer Scorchling##26401
		..turnin Incense for the Summer Scorchlings##11964
	step
		goto 43.5,62.6
		.talk Elwynn Forest Flame Warden##25898
		..accept Honor the Flame##11816 |instant
	step
		goto Elwynn Forest,43.7,62.2
		.talk Fire Eater##25962
		..accept Playing with Fire##11882
	step
		goto Stormwind City,50.0,72.3
		.talk Master Fire Eater##25975
		..turnin Playing with Fire##11882
	step
		goto 22.5,55.8 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
	step
		'Go through the pink portal into Darnassus |goto Darnassus |noway |c
	step
		'Take the east exit out of Darnassus to Teldrassil |goto Teldrassil |noway |c
	step
		goto 54.9,52.8
		.talk Teldrassil Flame Warden##25906
		..accept Honor the Flame##11824 |instant
	step
		'Go to Darnassus |goto Darnassus |noway |c
	step
		.' Go through the pink portal to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto 52.3,89.5 |n
		.' Ride the boat to Azuremyst Isle |goto Azuremyst Isle |noway |c
	step
		goto Azuremyst Isle,44.5,52.5
		.talk Azuremyst Isle Flame Warden##25888
		..accept Honor the Flame##11806 |instant
	step
		'Go north to Bloodmyst Isle |goto Bloodmyst Isle |noway |c
	step
		goto Bloodmyst Isle,55.8,67.9
		.talk Bloodmyst Isle Flame Warden##25891
		..accept Honor the Flame##11809 |instant
	step
		goto 57.7,53.9
		.talk Laando##17554
		.' Fly to The Exodar |goto The Exodar,54.4,36.6,0.5 |noway |c
	step
		goto Azuremyst Isle,20.4,54.2 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.4,88.4
		.talk Vesprystus##3838
		.' Fly to Lor'danel, Darkshore |goto Darkshore,51.7,17.7 |noway |c
	step
		goto 48.7,22.6
		.talk Darkshore Flame Warden##25893
		..accept Honor the Flame##11811 |instant
	step
		goto Darkshore,51.7,17.6
		.talk Teldira Moonfeather##3841
		.' Fly to Everlook, Winterspring |goto Winterspring,61.0,48.7,0.5 |noway |c
	step
		goto Winterspring,61.2,47.3
		.talk Winterspring Flame Warden##25917
		..accept Honor the Flame##11834 |instant
	step
		goto 58.1,47.3
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Descrate this Fire!##11803 |instant
	step
		goto Winterspring,61.0,48.6
		.talk Maethrya##11138
		.' Fly to Forest Song, Ashenvale |goto Ashenvale,85.0,43.5,0.5 |noway |c
	step
		'Go east to Azshara |goto Azshara |noway |c
	step
		goto Azshara,60.4,53.3
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##28919 |instant
	step
		goto Ashenvale,85.0,43.5
		.talk Maethrya##11138
		.' Fly to Astranaar, Ashenvale |goto Ashenvale,34.5,48.0,0.5 |noway |c
	step
		goto Ashenvale,15.1,18.4
		.from Twilight Firesworn##25863+
		.get Twilight Correspondence |q 11886/1
	step
		goto 15.2,21.2
		.' Use the Totemic Beacon in your bags |use Totemic Beacon##35828
		.talk Earthen Ring Guide##25324
		..turnin Unusual Activity##11886
		..accept An Innocent Disguise##11891
	step
		goto Ashenvale,15.3,20.1
		.from Twilight Firesworn##25863+, Twilight Flameguard##25866+
		.get Twilight Correspondence |q 11886/1
	step
		goto Ashenvale,15.7,20.3
		.' Use your Totemic Beacon next to the blue bonfire |use Totemic Beacon##35828
		.talk Earthen Ring Guide##25324
		..turnin Unusual Activity##11886
		..accept An Innocent Disguise##11891
	step
		goto Ashenvale,9.6,13.2
		.' Use your Orb of the Crawler in this spot |use Orb of the Crawler##35237
		.' Get the Crab Disguise |havebuff Interface\Icons\Ability_Hunter_Pet_Crab
	step
		'While in the crab disguise, go to 9.2,12.6 |goto Ashenvale,9.2,12.6
		.' Listen to the plan of the Twilight Cultists |q 11891/1
	step
		goto Ashenvale,9.7,13.3
		.' Use your Totemic Beacon next to the blue bonfire |use Totemic Beacon##35828
		.talk Earthen Ring Guide##25324
		..turnin An Innocent Disguise##11891
		..accept Inform the Elder##29092
	step
		goto Ashenvale,34.4,48.0
		.talk Daelyshia##4267
		.' Fly to Rut'theran Village, Teldrassil |goto Teldrassil,55.4,88.5,0.5 |noway |c
	step
		'Go through the pink portal into Darnassus |goto Darnassus |noway |c
	step
		goto Darnassus,62.1,49.1
		.talk Earthen Ring Elder##26221
		..turnin Inform the Elder##29092
	step
		.' Go through the pink portal to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto Teldrassil,55.4,88.4
		.talk Vesprystus##3838
		.' Fly to Astranaar, Ashenvale |goto Ashenvale,34.5,48.0,0.5 |noway |c
	step
		goto 51.6,66.6
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11765 |instant
	step
		goto Ashenvale,86.9,41.9
		.talk Ashenvale Flame Warden##25883
		..accept Honor the Flame##11805 |instant
	step
		goto 85.0,43.6
		.talk Suralais Farwind##22935
		.' Fly to Fort Triumpth, Southern Barrens |goto Southern Barrens,49.1,67.9,0.5 |noway |c
	step
		goto Southern Barrens,48.3,72.2
		.talk Southern Barrens Flame Warden##51586
		..accept Honor the Flame##28926
	step
		goto Southern Barrens,40.7,67.3
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##28914 |instant
	step
		goto Southern Barrens,49.2,67.8
		.talk Steve Stevenson##39211
		.' Fly to Ratchet, The Barrens |goto Northern Barrens,69.2,70.6,0.5 |noway |c
	step
		'Go northeast to Durotar |goto Durotar |noway |c
	step
		goto 52.1,47.1
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11770 |instant
	step
		'Go north to Orgrimmar |goto Orgrimmar |noway |c
	step
		goto Orgrimmar,46.5,37.0
		.' Click the Flame of Orgrimmar |tip It's a huge blue bonfire.
		.collect Flame of Orgrimmar##23179 |n
		.' Click the Flame of Orgrimmar in your bags |use Flame of Orgrimmar##23179
		..accept Stealing Orgrimmar's Flame##9324 |tip It is recommended that you be level 80 when attempting to complete this guide step.
	step
		'Go outside Orgrimmar to Durotar |goto Durotar |noway |c
	step
		'Go southwest to Northern Barrens|goto Northern Barrens |noway |c
	step
		goto Northern Barrens,49.9,54.4
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11783 |instant
	step
		goto Northern Barrens,69.1,70.7
		 .talk Bragok##16227
		.' Fly to Mirkfallon Post, Stonetalon Mountains |goto Stonetalon Mountains,48.6,51.5,0.5 |noway |c
	step
		goto 49.3,51.3
		.talk Stonetalon Mountains Flame Warden##51588
		..accept Honor the Flame##28928 |instant
	step
		goto Stonetalon Mountains,53.0,62.3
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11780 |instant
	step
		'Go southwest to Desolace |goto Desolace |noway |c
	step
		goto 66.1,17.1
		.talk Desolace Flame Warden##25894
		..accept Honor the Flame##11812 |instant
	step
		goto 26.1,77.2
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11769 |instant
	step
		'Go southeast to Feralas |goto Feralas |noway |c
	step
		goto Feralas,43.4,42.8 |n
		.' Ride the boat to Feathermoon |goto Feralas,31.0,39.9,4 |noway |c
	step
		goto Feralas,46.8,43.7
		.talk Feralas Flame Warden##25899
		..accept Honor the Flame##11817 |instant
	step
		goto Feralas,30.2,43.3
		.talk Fyldren Moonfeather##8019
		.' Fly to Thalanaar, Feralas |goto Feralas,89.5,45.9,0.5 |noway |c
	step
		goto 72.5,47.7
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11773 |instant
	step
		goto 77.3,56.8
		.talk Seyala Nightwisp##40367
		.' Fly to Cenarion Hold, Silithus |goto Silithus,50.7,34.6,0.5 |noway |c
	step
		goto Silithus,60.3,33.5
		.talk Silithus Flame Warden##25914
		..accept Honor the Flame##11831 |instant
	step
		goto 50.9,41.7
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11800 |instant
	step
		goto 54.4,32.7
		.talk Cloud Skydancer##15177
		.' Fly to Gadgetzan, Tanaris |goto Tanaris,51.4,29.4,0.5 |noway |c
	step
		goto Tanaris,49.8,28.1
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11802 |instant
	step
		goto Tanaris,52.6,30.3
		.talk Tanaris Flame Warden##25916
		..accept Honor the Flame##11833 |instant
	step
		goto 51.4,29.5
		.talk Bera Stonehammer##7823
		.' Fly to Theramore, Dustwallow Marsh |goto Dustwallow Marsh,67.5,51.2,0.5 |noway |c
	step
		goto Dustwallow Marsh,61.8,40.5
		.talk Dustwallow Marsh Flame Warden##25897
		..accept Honor the Flame##11815 |instant
	step
		goto 33.3,30.7
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11771 |instant
	step
		'Go southwest to Southern Barrens |goto Southern Barrens |noway |c
	step
		'Go northwest to Mulgore |goto Mulgore |noway |c
	step
		goto Mulgore,52.0,59.4
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11777 |instant
	step
		'Go north to Thunder Bluff |goto Thunder Bluff |noway |c
	step
		goto Thunder Bluff,21.7,27.5
		.' Click the Flame of Thunder Bluff |tip It's a huge blue bonfire.
		.collect Flame of Thunder Bluff##23180 |n
		.' Click the Flame of Thunder Bluff in your bags |use Flame of Thunder Bluff##23180
		..accept Stealing Thunder Bluff's Flame##9325 |tip It is recommended that you be level 80 when attempting to complete this guide step.
	step
		'Go outside to Mulgore |goto Mulgore |noway |c
	step
		'Go to Northern Barrens |goto Northern Barrens |noway |c
	step
		goto Northern Barrens,70.2,73.1 |n
		.' Ride the boat to Booty Bay |goto The Cape of Stranglethorn |noway |c
	step
		goto The Cape of Stranglethorn,52.0,67.6
		.talk Stranglethorn Vale Flame Warden##25915
		..accept Honor the Flame##11832 |instant
	step
		goto 50.5,70.7
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11801 |instant
	step
		goto 41.7,74.5
		.talk Gyll##2859
		.' Fly to Fort Livingston, Northern Stranglethorn |goto 52.6,66.3,0.5 |noway |c
	step
		goto Northern Stranglethorn,52.0,63.5
		.talk Northern Stranglethorn Flame Warden##51574
		..accept Honor the Flame##28922
	step
		goto 40.7,51.9
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##28911 |instant
	step
		goto 47.9,11.9
		.talk James Stillair##43045
		.' Fly to Nethergarde Keep, Blasted Lands |goto Blasted Lands,61.2,21.7,0.5 |noway |c
	step
		goto Blasted Lands,55.5,14.9
		.talk Blasted Lands Flame Warden##25890
		..accept Honor the Flame##11808 |instant
	step
		'Go northwest to Swamp of Sorrows |goto Swamp of Sorrows |noway |c
	step
		goto 70.3,15.7
		.talk Swamp of Sorrows Flame Warden##51602
		..accept Honor the Flame##28929
	step
		goto Swamp of Sorrows,76.7,14.0
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11781 |instant
	step
		'Go west to Duskwood |goto Duskwood |noway |c
	step
		goto 73.7,54.6
		.talk Duskwood Flame Warden##25896
		..accept Honor the Flame##11814 |instant
	step
		goto Duskwood,77.5,44.3
		.talk Felicia Maline##2409
		.' Fly to Moonbrook, Westfall |goto Westfall |noway |c
	step
		goto Westfall,44.8,62.1
		.talk Westfall Flame Warden##25910
		..accept Honor the Flame##11583
	step
		goto 42.1,63.3
		.talk Tina Skyden##42426
		.' Fly to Lakeshire, Redridge |goto Redridge Mountains,29.3,53.4,0.5 |noway |c
	step
		goto Redridge Mountains,24.9,53.4
		.talk Redridge Flame Warden##25904
		..accept Honor the Flame##11822 |instant
	step
		goto 29.4,53.8
		.talk Ariena Stormfeather##931
		.' Fly to Morgan's Vigil, Burning Steppes |goto Burning Steppes,72.1,65.7,0.5 |noway |c
	step
		goto Burning Steppes,68.3,60.6
		.talk Burning Steppes Flame Warden##25892
		..accept Honor the Flame##11810 |instant
	step
		goto 51.5,29.2
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11768 |instant
	step
		'Go northeast to the Badlands |goto Badlands |noway |c
	step
		goto Badlands,19.0,56.2
		.talk Badlands Flame Warden##51585
		..accept Honor the Flame##28925
	step
		goto 24.1,37.2
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11766 |instant
	step
		'Go northeast to Loch Modan |goto Loch Modan |noway |c
	step
		goto Loch Modan,32.6,41.0
		.talk Loch Modan Flame Warden##25902
		..accept Honor the Flame##11820 |instant
	step
		goto Loch Modan,33.9,51.0
		.talk Thorgrum Borrelson##1572
		.' Fly to Ironforge, Dun Morogh |goto Ironforge,55.9,47.9,0.5 |noway |c
	step
		goto Ironforge,63.8,25.3
		.talk Festival Loremaster##16817
		..turnin Stealing Orgrimmar's Flame##9324
		..turnin Stealing Thunder Bluff's Flame##9325
	step
		'Go outside to Dun Morogh |goto Dun Morogh |noway |c
	step
		goto Dun Morogh,53.8,45.2
		.talk Dun Morogh Flame Warden##25895
		..accept Honor the Flame##11813 |instant
	step
		'Go northeast to Ironforge |goto Ironforge |noway |c
	step
		goto Ironforge,55.5,47.7
		.talk Gryth Thurden##1573
		.' Fly to Menethil Harbor, Wetlands |goto Wetlands,9.5,59.7,0.5 |noway |c
	step
		goto 13.5,47.1
		.talk Wetlands Flame Warden##25911
		..accept Honor the Flame##11828 |instant
	step
		goto Wetlands,9.4,59.6
		.talk Shellei Brondir##1571
		.' Fly to Refuge Pointe, Arathi |goto Arathi Highlands,39.9,47.4,0.5 |noway |c
	step
		goto Arathi Highlands,44.3,46.0
		.talk Arathi Flame Warden##25887
		..accept Honor the Flame##11804 |instant
	step
		goto 69.2,43.0
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11764 |instant
	step
		'Go west to Hillsbrad Foothills |goto Hillsbrad Foothills |noway |c
	step
		goto Hillsbrad Foothills,54.6,49.8
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11776 |instant
	step
		'Go northeast to Western Plaguelands |goto Western Plaguelands |noway |c
	step
		goto Western Plaguelands,43,82
		.talk Western Plaguelands Flame Warden##25909
		..accept Honor the Flame##11827 |instant
	step
		goto Western Plaguelands,42.9,85.1
		.talk Bibilfaz Featherwhistle##12596
		.' Fly to Aerie Peak, The Hinterlands |goto The Hinterlands,11.1,46.1,0.5 |noway |c
	step
		goto The Hinterlands,14.3,50.1
		.talk The Hinterlands Flame Warden##25908
		..accept Honor the Flame##11826 |instant
	step
		goto 76.6,74.6
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11784 |instant
	step
		'Go west to Hillsbrad Foothills |goto Hillsbrad Foothills |noway |c
	step
		'Go west to Silverpine Forest |goto Silverpine Forest |noway |c
	step
		goto Silverpine Forest,49.6,38.7
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11580 |instant
	step
		'Go northeast to Tirisfal Glades |goto Tirisfal Glades |noway |c
	step
		goto Tirisfal Glades,57.0,51.8
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11786 |instant
	step
		'Go south to Undercity |goto Undercity |noway |c
	step
		goto Undercity,67.9,8.3
		.' Click the Flame of Undercity |tip It's a huge blue bonfire.
		.collect Flame of Undercity##23181 |n
		.' Click the Flame of Undercity in your bags |use Flame of Undercity##23181
		..accept Stealing Undercity's Flame##9326 |tip It is recommended that you be level 80 when attempting to complete this guide step.
	step
		'Go outside to Tirisfal Glades |goto Tirisfal Glades |noway |c
	step
		'Go east to Western Plaguelands |goto Western Plaguelands |noway |c
	step
		'Fly east to Eastern Plaguelands |goto Eastern Plaguelands |noway |c
	step
		goto Eastern Plaguelands,54.8,8.5 |n
		.' Go inside the huge swirling portal to the Ghostlands |goto Ghostlands |noway |c
	step
		goto Ghostlands,47,26
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11774 |instant
	step
		'Go north to Eversong Woods |goto Eversong Woods |noway |c
	step
		goto Eversong Woods,46,50
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11772 |instant
	step
		'Go east to Silvermoon City |goto Silvermoon City |noway |c
	step
		goto Silvermoon City,69.0,43.4
		.' Click the Flame of Silvermoon |tip It's a huge blue bonfire.
		.collect Flame of Silvermoon##35568 |n
		.' Click the Flame of Silvermoon in your bags |use Flame of Silvermoon##35568
		..accept Stealing Silvermoon's Flame##11935 |tip It is recommended that you be level 80 when attempting to complete this guide step.
	step
		'Go outside to Eversong Woods |goto Eversong Woods |noway |c
	step
		'Go south to the Ghostlands |goto Ghostlands |noway |c
	step
		goto Ghostlands,52.0,97.8 |n
		.' Go inside the huge swirling portal to Eastern Plaguelands |goto Eastern Plaguelands |noway |c
	step
		goto Eastern Plaguelands,75.8,53.4
		.talk Khaelyn Steelwing##12617
		.' Fly to Ironforge, Dun Morogh |goto Ironforge,55.9,47.9,0.5 |noway |c
	step
		goto Ironforge,63.8,25.3
		.talk Festival Loremaster##16817
		..turnin Stealing the Undercity's Flame##9326
		..turnin Stealing Silvermoon's Flame##11935
		..accept A Thief's Reward##9365 |instant
	step
		goto Ironforge,27.3,7.0 |n
		.' Click the Portal to Blasted Lands |goto Blasted Lands |noway |c
	step
		'Go inside the big green portal to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
	step
		goto Hellfire Peninsula,62.2,58.3
		.talk Hellfire Peninsula Flame Warden##25900
		..accept Honor the Flame##11818 |instant
	step
		goto Hellfire Peninsula,57.2,41.8
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11775 |instant
	step
		goto Netherstorm,32.3,68.2
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11799 |instant
	step
		goto Netherstorm,31.2,62.7
		.talk Netherstorm Flame Warden##25913
		..accept Honor the Flame##11830 |instant
	step
		goto Blade's Edge Mountains,50.0,59.0
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11767 |instant
	step
		goto Blade's Edge Mountains,41.6,65.9
		.talk Blade's Edge Flame Warden##25889
		..accept Honor the Flame##11807 |instant
	step
		goto Zangarmarsh,35.6,51.8
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11787 |instant
	step
		goto Zangarmarsh,68.8,52.0
		.talk Zangarmarsh Flame Warden##25912
		..accept Honor the Flame##11829 |instant
	step
		goto Nagrand,51.1,34.0
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11778 |instant
	step
		goto Nagrand,49.6,69.5
		.talk Nagrand Flame Warden##25903
		..accept Honor the Flame##11821 |instant
	step
		goto Terokkar Forest,51.9,43.2
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11782 |instant
	step
		goto Terokkar Forest,54.1,55.5
		.talk Terokkar Forest Flame Warden##25907
		..accept Honor the Flame##11825 |instant
	step
		goto Shadowmoon Valley,33.5,30.3
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##11779 |instant
	step
		goto Shadowmoon Valley,39.6,54.6
		.talk Shadowmoon Valley Flame Warden##25905
		..accept Honor the Flame##11823 |instant
	step
		goto Shattrath City,55.8,36.6 |n
		.' Click the Shattrath Portal to Stormwind |goto Stormwind City |noway |c
	step
		goto Stormwind City,18.2,25.5 |n
		.' Ride the boat to Borean Tundra |goto Borean Tundra |noway |c
	step
		goto Borean Tundra,55.1,20.0
		.talk Borean Tundra Flame Warden##32801
		..accept Honor the Flame##13485 |instant
	step
		goto Borean Tundra,51.1,11.8
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##13441 |instant
	step
		goto Sholazar Basin,48.1,66.4
		.talk Sholazar Basin Flame Warden##32802
		..accept Honor the Flame##13486 |instant
	step
		goto Sholazar Basin,47.3,61.5
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##13450 |instant
	step
		goto Dragonblight,38.5,48.3
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##13451 |instant
	step
		goto Dragonblight,75.3,43.8
		.talk Dragonblight Flame Warden##32803
		..accept Honor the Flame##13487 |instant
	step
		goto Crystalsong Forest,78.2,75.0
		.talk Crystalsong Forest Flame Warden##32807
		..accept Honor the Flame##13491 |instant
	step
		goto Crystalsong Forest,80.4,52.7
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##13457 |instant
	step
		goto The Storm Peaks,40.4,85.6
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##13455 |instant
	step
		goto The Storm Peaks,41.4,86.7
		.talk Storm Peaks Flame Warden##32806
		..accept Honor the Flame##13490 |instant
	step
		goto Zul'Drak,40.4,61.3
		.talk Zul'Drak Flame Warden##32808
		..accept Honor the Flame##13492 |instant
	step
		goto Zul'Drak,43.3,71.3
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##13458 |instant
	step
		goto Grizzly Hills,19.1,61.5
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##13454 |instant
	step
		goto Grizzly Hills,33.9,60.5
		.talk Grizzly Hills Flame Warden##32805
		..accept Honor the Flame##13489 |instant
	step
		goto Howling Fjord,48.4,13.4
		.' Click the Horde Bonfire |tip It's a huge bonfire.
		..accept Desecrate this Fire!##13453 |instant
	step
		goto Howling Fjord,57.8,16.1
		.talk Howling Fjord Flame Warden##32804
		..accept Honor the Flame##13488 |instant
]])
ZygorGuidesViewer:RegisterInclude("Midsummer Fire Festival Achievements",[[
		'Complete the Midsummer Fire Festival Quests guide section before doing this guide section.
		.' Skip to the next step in the guide
	step
		goto Stormwind City,49.3,72.3
		.talk Earthen Ring Elder##26221
		..' Queue for The Frost Lord Ahune battle.
		..' Click Find Group
		..from Lord Ahune##25740
		.' Complete the Ice the Frost Lord Achievement |achieve 263
	step
		goto 49.0,72.0
		.talk Midsummer Supplier##26123
		.buy 15 Juggling Torch##34599
		.buy 1 Mantle of the Fire Festival##23324
		.buy 1 Vestment of Summer##34685
		.buy 1 Sandals of Summer##34683
	step
		goto 50.5,73.1
		.' Equip your Mantle of the Fire Festival |use Mantle of the Fire Festival##23324
		'
		'
		.' Equip your Vestment of Summer |use Vestment of Summer##34685
		'
		'
		.' Equip your Sandals of Summer |use Sandals of Summer##34683
		.' Click the Ribbon Pole |tip It looks like a tall metal pole with a small fire on top of it.
		.' Let your character spin around for 1 minute
		.' Complete the Burning Hot Pole Dance Achievement |achieve 271
	step
		'Don't forget to put your regular gear back on
		.' Skip to the next step in the guide
	step
		goto Stormwind City,18.2,25.5 |n
		.' Ride the boat to Borean Tundra |goto Borean Tundra |noway |c
	step
		goto Borean Tundra,59.0,68.3
		.talk Tomas Riverwell##26879
		.' Fly to Dalaran |goto Dalaran,72.7,45.7,0.5 |noway |c
	step
		goto Dalaran,36.8,44.1
		.' Use your 40 Juggling Torches as fast as you can |tip You must juggle them all in under 15 seconds.  The best way to do this is to place your Juggling Torches on your hotbar.  Press the hotbar key and click the ground at the same time.  Keep spamming the hotbar key and clicking the ground at the same time as fast as possible and don't stop until you get the achievement.
		.' Complete the Torch Juggler Achievement |achieve 272
	step
		'Congratulations, you are now The Flame Warden!
]])

-- Harvest Festival --
ZygorGuidesViewer:RegisterInclude("Harvest Festival Quests",[[
		goto Dun Morogh,59.7,34.3
		.talk Wagner Hammerstrike##15011
		..accept Honoring a Hero##8149
	step
		|fly Chillwind Camp
	step
		goto Western Plaguelands,52.0,83.4
		.' Use Uther's Tribute in front of Uther's statue |use Uther's Tribute##19850
		.' Place a Tribute at Uther's Tomb |q 8149/1
	step
		|fly Ironforge
	step
		'Go outside to Dun Morogh |goto Dun Morogh |noway |c
	step
		goto Dun Morogh,59.7,34.3
		.talk Wagner Hammerstrike##15011
		..turnin Honoring a Hero##8149
	step
		goto Dun Morogh,59.9,34.8
		.' You can click special food items on the table.
		.' In 2 days You will also get an item called Bounty of the Harvest in the mail.
		|confirm
	step
		'Congratulations, you've completed the Harvest Festival!
]])

-- Brewfest --
ZygorGuidesViewer:RegisterInclude("Brewfest Quests",[[
		goto Ironforge,30.8,62.9
		.talk Dwarf Commoner##19148
		..accept Brewfest!##11441
	step
		'Go outside to Dun Morogh |goto Dun Morogh |noway |c
	step
		goto Dun Morogh,55.1,38.1
		.talk Ipfelkofer Ironkeg##24710
		..turnin Brewfest!##11441
	step
		goto 55.1,37.7
		.' NOTE: If you are on an EU server, you will be unable to accept these 2 quests. |tip So, just skip them, and also skip the guide steps where you complete the quest goals for these quests.
		.talk Goldark Snipehunter##23486
		..accept Brewfest!##11441
		..accept Brewfest!##11441
	step
		goto 55.1,37.7
		.talk Goldark Snipehunter##23486
		..' Ask him if there's another way you can help out if you don't like drinking, then ask for a pair of Synthebrew Goggles
		.collect Synthebrew Goggles##46735 |q 11117
	step
		 goto 54.7,38.1
		.talk Boxey Boltspinner##27215
		..accept Chug and Chuck!##12022
	step
		goto 54.8,37.9
		.' Click the Complimentary Brewfest Samplers |tip They looks like mugs of beer on the small tables on either side of you.
		.' Use your Complimentary Brewfest Samplers |use Complimentary Brewfest Sampler##33096
		.' Hit S.T.O.U.T. 5 Times |q 12022/1
	step
		goto 54.7,38.1
		.talk Boxey Boltspinner##27215
		..turnin Chug and Chuck!##12022
	step
		goto 53.7,38.6
		.talk Neill Ramstein##23558
		..accept Now This is Ram Racing... Almost.##11318
	step
		'As you run around on the ram:
		.' Use your Ram Racing Reins |use Ram Racing Reins##33306 |tip The ram runs slow by default.  You have to use the Ram Racing Reins to make it run at certain speeds for 8 seconds.  The make the ram Trot for 8 seconds, use the Ram Racing Reins every 2 seconds or so to keep the ram running at the speed just above the slow default speed.  To make the Ram Canter for 8 seconds, use the Ram Racing Reins a little more often than when you made the Ram Trot.  To make the Ram Gallop, just spam use the Ram Racing Reins.
		.' Maintain a Trot for 8 seconds |q 11318/1
		.' Maintain a Canter for 8 seconds |q 11318/2
		.' Maintain a Gallop for 8 seconds |q 11318/3
	step
		goto 53.7,38.6
		.talk Neill Ramstein##23558
		..turnin Now This is Ram Racing... Almost.##11318
		..accept There and Back Again##11122
	step
		map Dun Morogh
		path follow strict;loop;ants straight
		path	54.6,43.3	54.5,47.4	53.1,51.3	
		path	53.7,51.8	54.5,47.7	54.6,43.4
		path	53.6,38.5
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Stop at every bucket of apples you see on the side of the road to refresh your Ram's fatigue level, allowing the Ram to run faster for longer.
		.' _FOLLOW THE WAYPOINT PATH_ Flynn Firebrew will throw you a keg when you get close
		.' Once you have a keg, run back and turn it in to Pol Amberstill at |tip Just get near him and you will throw the keg to him.
		.' Deliver 3 Kegs in Under 4 Minutes|q 11122/1
	step
		goto 53.7,38.6
		.talk Neill Ramstein##23558
		..turnin There and Back Again##11122
	step
		goto 53.5,38.6
		.talk Pol Amberstill##24468
		.' You will be able to accept one of these quests
		..accept Another Year, Another Souvenir.##13932 |or
		.' or
		..accept A New Supplier of Souvenirs##29397 |or
	step
		'Use your Synthebrew Goggles |use Synthebrew Goggles##46735
		.' Equip the Synthebrew Goggles |havebuff Interface\Icons\Spell_Holy_SpiritualGuidence |q 11117
	step
		goto 54.5,38.5
		.' Use your Wolpertinger Net on Wild Wolpertingers |use Wolpertinger Net##32907 |tip They look like rabbits with antlers and wings running around on the ground around this area.
		.get 5 Stunned Wolpertinger |q 11117/1
	step
		goto 55.1,37.7
		.talk Goldark Snipehunter##23486
		..turnin Catch the Wild Wolpertinger!##11117
		.collect Wolpertinger's Tankard |n
		.' Does Your Wopertinger Linger? |achieve 1936 |tip If you are on the EU server you will be able to achieve this in the Achievments Guide.
	step
		goto 56.4,37.8
		.talk Belbi Quikswitch##23710
		..turnin Another Year, Another Souvenir.##13932 |or
		.' or
		..turnin A New Supplier of Souvenirs##29397 |or
	step
		'Go inside Ironforge |goto Ironforge |noway |c
	step
		|fly Stormwind City
	step
		'Go outside to Elwynn Forest |goto Elwynn Forest |noway |c
	step
		goto Elwynn Forest,33.5,50.7
		'Use your Synthebrew Goggles |use Synthebrew Goggles##46735
		.' Equip the Synthebrew Goggles |havebuff Interface\Icons\Spell_Holy_SpiritualGuidence |q 11118
		.' Use your Elekk Dispersion Ray on Elwynn Pink Elekks |use Elekk Dispersion Ray##32960
		.kill 3 Elwynn Pink Elekk |q 11118/2
	step
		'Go inside Stormwind City |goto Stormwind City |noway |c
	step
		goto Stormwind City,22.5,55.8 |n
		.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
	step
		goto 55.1,88.3 |n
		.' Go through the Pink Portal |goto Darnassus |noway |c
	step
		goto 67.3,46.1
		'Use your Synthebrew Goggles |use Synthebrew Goggles##46735
		.' Equip the Synthebrew Goggles |havebuff Interface\Icons\Spell_Holy_SpiritualGuidence |q 11118
		.' Use your Elekk Dispersion Ray on Azuremyst Pink Elekks |use Elekk Dispersion Ray##32960
		.kill 3 Azuremyst Pink Elekk |q 11118/3
	step
		goto Darnassus,44.2,78.7
		.' Click on the Portal to Exodar |tip It looks like a swirling blue portal
		.' Teleport to The Exodar |goto The Exodar |noway |c
	step
		goto The Exodar,78.4,57.4
		'Use your Synthebrew Goggles |use Synthebrew Goggles##46735
		.' Equip the Synthebrew Goggles |havebuff Interface\Icons\Spell_Holy_SpiritualGuidence |q 11118
		.' Use your Elekk Dispersion Ray on Teldrassil Pink Elekks |use Elekk Dispersion Ray##32960
		.kill 3 Teldrassil Pink Elekk |q 11118/1
	step
		goto 47.6,62.1
		.' Click the Portal to Darnassus |tip It looks like a blue swirling portal
		.' Teleport to Darnassus |goto Darnassus |noway |c
	step
		goto 36.3,50.3 |n
		.' Go through the Pink Portal |goto Teldrassil |noway |c
	step
		goto 55.0,93.7 |n
		.' Ride the boat to Stormwind |goto Stormwind City |noway |c
	step
		|fly Ironforge
	step
		'Go outside to Dun Morogh |goto Dun Morogh |noway |c
	step
		goto 55.1,37.7
		.talk Goldark Snipehunter##23486
		..turnin Pink Elekks On Parade##11118
	step
		'Use the Dungeon Finder (press I) to queue for Coren Direbrew |tip You must be level 80 do complete this quest.
		.' You will fight Coren Direbrew
		.from Coren Direbrew##23872
		.collect Direbrew's Dire Brew##38280 |n
		.' Click Direbrew's Dire Brew in your bags |use Direbrew's Dire Brew##38280
		..accept Direbrew's Dire Brew##12491
	step
		'Click the green eye on the edge of your minimap
		.' Teleport Out of the Dungeon and go to Dun Morogh |goto Dun Morogh |noway |c
	step
		goto 55.1,38.1
		.talk Ipfelkofer Ironkeg##24710
		..turnin Direbrew's Dire Brew##12491
]])
ZygorGuidesViewer:RegisterInclude("Brewfest Dailies",[[
		'You will only be able to do 1 of the first 2 dailies in this guide, per day. |tip Quests "Bark for the Barleybrews!" or "Bark for the Thunderbrews!".
		.' Skip to the next step in the guide
	step
		goto Dun Morogh,56.1,38.0
		goto Dun Morogh,56.1,38.0
		.talk Becan Barleybrew##23627
		..accept Bark for the Barleybrews!##11293 |daily
	step
		goto Dun Morogh,56.5,36.9
		..accept Bark for the Barleybrews!##11293 |daily |or 
		.' Or
		 goto 56.6,36.9
		.talk Daran Thunderbrew##23628
		..accept Bark for the Thunderbrews!##11294 |daily |or
	step
		'Ride your ram into Ironforge |goto Ironforge |noway |c |q 11293
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		|only if havequest (11293)
	step
		'Ride your ram into Ironforge |goto Ironforge |noway |c |q 11294
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		|only if havequest (11294)
	step
		goto Ironforge,31.7,66.7
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		.' Go to this spot
		.' Bark Outside the Bank |q 11293/1
		|only if havequest (11293)
	step
		goto 61.2,80.0
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		.' Go to this spot
		.' Bark in the Military Ward |q 11293/2
		|only if havequest (11293)
	step
		goto 65.3,24.4
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		.' Go to this spot
		.' Bark in the Hall of Explorers |q 11293/3
		|only if havequest (11293)
	step
		goto 29.5,14.2
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		.' Go to this spot
		.' Bark in the Mystic Ward |q 11293/4
		|only if havequest (11293)
	step
		goto Ironforge,31.7,66.7
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		.' Go to this spot
		.' Bark Outside the Bank |q 11294/1
		|only if havequest (11294)
	step
		goto 61.2,80.0
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		.' Go to this spot
		.' Bark in the Military Ward |q 11294/2
		|only if havequest (11294)
	step
		goto 65.3,24.4
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		.' Go to this spot
		.' Bark in the Hall of Explorers |q 11294/3
		|only if havequest (11294)
	step
		goto 29.5,14.2
		.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
		.' Go to this spot
		.' Bark in the Mystic Ward |q 11294/4
		|only if havequest (11294)
	step
		'Go outside to Dun Morogh |goto Dun Morogh |noway |c
	step
		goto Dun Morogh,56.1,38.0
		goto 56.1,38.0
		.talk Becan Barleybrew##23627
		..turnin Bark for the Barleybrews!##11293
		|only if havequest (11293)
	step
		goto Dun Morogh,56.5,36.9
		goto 56.5,36.9
		.talk Daran Thunderbrew##23628
		..turnin Bark for the Thunderbrews!##11294
		|only if havequest (11294)
	step
		goto 56.0,37.2
		.' Click the Dark Iron Mole Machine Wreckage |tip It looks like a big metal gear laying on ground in the middle of the festival.  It appears after the Dark Iron dwarves attack the Brewfest festival, so you may have to wait for it to appear.
		goto 56.0,37.1
		.' Click the Dark Iron Mole Machine Wreckage |tip You have to defend the three kegs at these locations in order for it to show up.
		.' Click the Complimentary Brewfest Sampler here [55.3,37.3]
		.' Click the Complimentary Brewfest Sampler here [55.7,38.1]	
		.' Thow the Sampler's at the Dark Iron Dwarves and the Mole Machines. |use Complimentary Brewfest Sampler##33096
		..accept This One Time, When I Was Drunk...##12020 |daily
	step
		goto Dun Morogh,54.7,38.1
		.talk Boxey Boltspinner##27215
		..turnin This One Time, When I Was Drunk...##12020
		.' Down With The Dark Iron Achievement |achieve 1186
	step
		goto 53.7,38.6
		.talk Neill Ramstein##23558
		..accept Brew For Brewfest##29394 |instant |daily
		.' On your Ram, run to Flynn Firebrew at|tip Flynn Firebrew will throw you a keg when you get close.
		.' Deliver as many kegs as you can within 4 minutes |tip You get 2 Brewfest Prize Tokens for each keg you deliver, so this is a good way to get some Brewfest Prize Tokens to join the Brew of the Month Club.
	step
		map Dun Morogh
		path follow strict;loop;ants straight
		path	54.6,43.3	54.5,47.4	53.1,51.3	
		path	53.7,51.8	54.5,47.7	54.6,43.4
		path	53.6,38.5
		.' Follow this path to pick up Kegs from Flynn Firebrew and run them back to Neill Ramstein
		.' Use your Ram Racing Reins |use Ram Racing Reins##33306
]])
ZygorGuidesViewer:RegisterInclude("Brewfest Achievements",[[
		 goto Dun Morogh,55.6,38.2
		.talk Arlen Lochlan##23522
		.buy The Essential Brewfest Pretzel##33043 |achieve 1185
	step
		'Click The Essential Brewfest Pretzels in your bags |use The Essential Brewfest Pretzel##33043
		.' Eat The Essential Brewfest Pretzels |achieve 1185/7
	step
		goto 56.5,37.7
		.talk Anne Summers##23521
		.buy Spiced Onion Cheese##34065 |achieve 1185
	step
		'Click the Spiced Onion Cheese in your bags |use Spiced Onion Cheese##34065
		.' Eat the Spiced Onion Cheese |achieve 1185/4
	step
		goto 56.0,36.4
		.talk Keiran Donoghue##23481
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
		.' Click the Golden Link in your bags |use The Golden Link##33026
		.' Eat The Golden Link |achieve 1185/8
		.' Achieve The Brewfest Diet! |achieve 1185
	step
		goto 56.4,37.8
		.talk Belbi Quikswitch##23710
		.buy Fresh Brewfest Hops##37750 |achieve 303 |tip You must be at least level 20 to buy these.
	step
		'Use your Fresh Brewfest Hops |use Fresh Brewfest Hops##37750
		.' Make your Mount Festive for Brewfest! |achieve 303
	step
		'Complete the Brewfest daily quests each day until you have 200 Brewfest Prize Tokens
		.collect 200 Brewfest Prize Token##37829 |achieve 2796
	step
		goto 56.4,37.9
		.talk Belbi Quikswitch##23710
		.buy "Brew of the Month" Club Membership Form##37736 |n
		.' Click the "Brew of the Month" Club Membership Form in your bags |use "Brew of the Month" Club Membership Form##37736
		..accept Brew of the Month Club##12420
	step
		'Go inside Ironforge |goto Ironforge |noway |c
	step
		goto Ironforge,18.8,53.1
		.talk Larkin Thunderbrew##27478
		..turnin Brew of the Month Club##12420
		.' Achieve Brew of the Month! |achieve 2796
		.' Achieve Brewmaster! |achieve 1684
	step
		goto Dun Morogh,56.4,37.8
		.' If you are on the EU servers go here to buy your Wolpertinger Pet
		.buy Wolpertinger's Tankard##32233 |n
		.' Does Your Wopertinger Linger? |achieve 1936
	step
		'Congratulations, you are a Brewmaster!
]])
--------------------------------------------------------------------------------------------------------------------------------------
-- Professions
--------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------
-- Cooking
--------------------------------------------------------------------------------------------------------------------------------------
ZygorGuidesViewer:RegisterInclude("A_Kickin'_It_Up_a_Notch",[[
	step
		goto Stormwind City,49.0,87.4
		.' Click on the Portal to Blasted Lands |tip It looks like a purple swirling portal.
		.' Take Portal to Blasted Lands |goto Blasted Lands |noway |c
	step
		goto Blasted Lands,55.0,54.1
		.' Go through The Dark Portal |tip It looks like a huge green swirling portal.
		.' Go to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
	step
		|fly Shattrath
	step
	label "warning"
		.' The following quests are random and you can only do one per day. Click to proceed. |confirm always
	step
	label "hub"
		goto Shattrath City,61.8,15.6
		.talk The Rokk##24393
		.' You will only be able to accept one of these daily quests per day
		..accept Soup for the Soul##11381 |daily |or
		..accept Super Hot Stew##11379 |daily |or
		..accept Manalicious##11380 |daily |or
		..accept Revenge is Tasty##11377 |daily |or
	step
		|fly Telaar |q 11381
	step
		goto Nagrand,56.2,73.3
		.talk Uriku##20096
		.buy Recipe: Roasted Clefthoof##27691 |n
		.' Click the Recipe: Roasted Clefthoof in your bags |use Recipe: Roasted Clefthoof##27691
		.learn Roasted Clefthoof##33287 |q 11381
	step
		goto Nagrand,58.5,46.8
		.from Clefthoof##18205+, Clefthoof Calf##19183+
		.collect 4 Clefthoof Meat##27678 |q 11381
		.' You can find more Clefthooves at  45.5,72.7
	step
		.' Build a Basic Campfire |cast Basic Campfire##818
		.create Roasted Clefthoof##33287,Cooking,4 total |q 11381
	step
		goto 25.9,59.4
		.' Use your Cooking Pot to Cook up some Spiritual Soup |use Cooking Pot##33851
		.' Cook a Spiritual Soup |q 11381/1
	step
		|fly Evergrove |q 11379
	step
		goto Blade's Edge Mountains,62.5,40.3
		.talk Xerintha Ravenoak##20916
		.buy Recipe: Mok'Nathal Shortribs##31675 |n
		.' Click the Recipe: Mok'Nathal Shortribs in your bags |use Recipe: Mok'Nathal Shortribs##31675
		.learn Mok'Nathal Shortribs##31672 |q 11379
		.buy Recipe: Crunchy Serpent##31674 |n
		.' Click the Recipe: Crunchy Serpent in your bags |use Recipe: Mok'Nathal Shortribs##31674
		.learn Crunchy Serpent##31673 |q 11379
	step
		goto Blade's Edge Mountains,49.6,46.2
		.from Daggermaw Blackhide##22052+, Bladespire Raptor##20728+
		.collect 4 Raptor Ribs##31670+ |q 11379
	step
		goto 68.2,63.2
		.from Scalewing Serpent##20749+, Felsworn Scalewing##21123+
		.collect 1 Serpent Flesh##31671 |q 11379
	step
		.' Build a Basic Campfire |cast Basic Campfire##818
		.create 2 Mok'Nathal Shortribs##38867,Cooking,2 total |q 11379
	step
		.' Build a Basic Campfire |cast Basic Campfire##818
		.create 1 Crunchy Serpent##38868,Cooking,1 total |q 11379
	step
		goto 29.0,84.5
		.from Abyssal Flamebringer##19973+
		.' Use your Cooking Pot next to the Abyssal Flamebringer corpse to Cook up some Demon Broiled Surprise |use Cooking Pot##33852
		.get Demon Broiled Surprise |q 11379/1
	step
		|fly Area 52 |q 11380
	step
		goto Netherstorm,45.6,54.2
		.click Mana Berry Bush##186729+
		.get 15 Mana Berry##33849+ |q 11380/1
	step
		'Go outside to Terokkar Forest |goto Terokkar Forest |q 11377
	step
		goto Terokkar Forest,55.8,53.0
		.talk Supply Officer Mills##19038
		.buy Recipe: Warp Burger##27692 |n
		.' Click the Recipe: Warp Burger in your bags |use Recipe: Warp Burger##27692
		.learn Warp Burger##33288 |q 11377
	step
		goto 64.0,83.5
		.from Blackwind Warp Chaser##23219+
		.collect 3 Warped Flesh##27681 |q 11377
	step
		goto 67.6,74.7
		.from Monstrous Kaliri##23051+ |tip They fly around in the sky close to the tree outposts and bridges.
		.collect Giant Kaliri Wing##33838 |q 11377
	step
		goto 25.9,59.5
		.' Build a Basic Campfire |cast Basic Campfire##818
		.create Warp Burger##33288,Cooking,3 total |q 11377
		.' Use your Cooking Pot to Cook up some Kaliri Stew |use Cooking Pot##33837
		.create Kaliri Stew##43718,Cooking,1 total |q 11377/1
	step
		|fly Shattrath
	step
		goto Shattrath City,61.8,15.6
		.talk The Rokk##24393
		..turnin Soup for the Soul##11381
		..turnin Super Hot Stew##11379
		..turnin Manalicious##11380 
		..turnin Revenge is Tasty##11377

	step
		'You've completed all the dailies you can do today. Click to go back to the dailies hub. |confirm |next "-warning" |only if not step:Find("+check"):IsComplete()
		'Checking achievements |next |only if default
	step
	label "check"
		.' Daily Completed "Revenge is Tasty" |achieve 906/1
		.' Daily Completed "Super Hot Stew" |achieve 906/2
		.' Daily Completed "Manalicious" |achieve 906/3
		.' Daily Completed "Soup for the Soul" |achieve 906/4
		.' Earn the Kickin' It Up a Notch Achievement |achieve 906
	step
		'Congratulations!  You've earned "Kickin' It Up a Notch" Achievement.
]])

ZygorGuidesViewer:RegisterInclude("A_The_Outland_Gourmet",[[
	step
	title +The Burning Crusade Recipes
		#include trainCooking
		.learn Stewed Trout##42296 		
		.learn Fisherman's Feast##42302 
		.learn Hot Buttered Trout##42305 
	//300 Buzzard Bites TBC
	step
		goto Hellfire Peninsula,49.2,74.8
		.talk Lagassi##19344
		..accept Ravager Egg Roundup##9349
	step
		goto 39.0,88.4
		.from Razorfang Hatchling##16932+,Razorfang Ravager##16933+
		.get 12 Ravager Egg##23217 |q 9349/1
	step
		goto Hellfire Peninsula,49.2,74.8
		.talk Lagassi##19344
		..turnin Ravager Egg Roundup##9349
	step
		goto Hellfire Peninsula,49.2,74.8
		.talk Lagassi##19344
		..accept Helboar, the Other White Meat##9361
	step
		goto 51.2,69.8
		.from Deranged Helboar##16863
		.collect 8 Tainted Helboar Meat##23270
	step
		'Use the Purification Mixture on the Tainted Meat |use Purification Mixture##23268
		.get 8 Purified Helboar Meat##23248 |q 9361/1
	step
		goto Hellfire Peninsula,49.2,74.8
		.talk Lagassi##19344
		..turnin Helboar, the Other White Meat##9361
	step
		goto Hellfire Peninsula,49.2,74.8
		.talk Lagassi##19344
		..accept Smooth as Butter##9356
	step
		goto 61.0,66.6
		.from Bonestripper Buzzard##16972
		.get 12 Plump Buzzard Wing |q 9356/1
	step
		goto Hellfire Peninsula,49.2,74.8
		.talk Lagassi##19344
		..accept Smooth as Butter##9356
		.collect 1 Recipe: Buzzard Bites##27684
	step
		.learn Buzzard Bites##33279 |use Recipe: Buzzard Bites##27684
		//300 Ravager Dog TBC
	step
		//alliance: 
		goto Hellfire Peninsula,54.2,63.6
		.talk Sid Limbardi##16826
		.buy 1 Recipe: Ravager Dog##27688 
	step
		.learn Ravager Dog##33284 |use Recipe: Ravager Dog##27688 
	//300 Clam Bar TBC
	step
		goto Zangarmarsh,17.8,51.2
		.talk Mycah##18382
		.buy 1 Recipe: Clam Bar##30156
	step
		.learn Clam Bar##36210 |use Recipe: Clam Bar##30156
	//300 Feltail Delight TBC blackened trout
	step
		//alliance:
		goto Zangarmarsh,42.2,27.8
		.talk Doba##20028
		.buy 1 Recipe Feltail Delight##27695
		.buy 1 Recipe: Blackened Trout##27694
	step
		.learn Feltail Delight##33291 |use Recipe Feltail Delight##27695
		.learn Blackened Trout##33290 |use Recipe: Blackened Trout##27694
	//310 Blackened Sporefish TBC
	step
		//both
		goto Zangarmarsh,78.0,66.0
		.talk Juno Dufrain##18911
		.buy 1 Recipe: Blackened Sporefish##27696
	step
		.learn Blackened Sporefish##33292 |use Recipe: Blackened Sporefish##27696
	//310 Sporeling Snack TBC --help
	//320 Grilled Mudfish TBC, poached bluefish, talbuk steak. roasted clefthoof
	step
		//alliance
		goto Nagrand,56.2,73.2
		.talk Uriku##20096
		//horde
		.buy 1 Recipe: Grilled Mudfish##27697
		.buy 1 Recipe: Talbuk Steak##27693
		.buy 1 Recipe: Poached Bluefish##27698
		.buy 1 Recipe: Roasted Clefthoof##27691
	step
		.learn Talbuk Steak##33289 |use Recipe: Talbuk Steak##27693
		.learn Grilled Mudfish##33293 |use Recipe: Grilled Mudfish##27697
		.learn Poached Bluefish##33294 |use Recipe: Poached Bluefish##27698
		.learn Roasted Clefthoof##33287 |use Recipe: Roasted Clefthoof##27691
	//325 Golden Fish Sticks TBC + Spicy Crawdad TBC
	step
		//alliance
		goto Terokkar Forest,56.6,53.2
		.talk Biribi##19296
		.buy 1 Recipe: Golden Fish Sticks##27699
		.buy 1 Recipe: Spicy Crawdad##27700
	step
		.learn Golden Fish Sticks##33295
		.learn Spicy Crawdad##33296
	//315 Blackened Basilisk TBC + warp burger
	step
		//allaince
		goto Terokkar Forest,55.8,53.0
		.talk Supply Officer Mills##19038
		//horde
		.buy 1 Recipe Blackened Basilisk##27690
		.buy 1 Recipe: Warp Burger##27692
	step
		.learn Blackened Basilisk##33286 |use Recipe Blackened Basilisk##27690
		.learn Warp Burger##33288 |use Recipe: Warp Burger##27692
	//325 Warp Burger TBC
	//335 Crunchy Serpent TBC + Mok'Nathal Shortribs TBC
	step
		goto Blade's Edge Mountains,62.4,40.2
		.talk Xerintha Ravenoak##20916
		.buy 1 Recipe: Mok'Nathal Shortribs##31675
		.buy 1 Recipe: Crunchy Serpent##31674
	step
		.learn Mok'Nathal Shortribs##38867
		.learn Crunchy Serpent##38868	
	step
		'Use the Shattrath Cooking Dailies section of this guide to get these recipes: |tip It's not always guarenteed to come from these daily prizes so be patient
		'Make sure to choose the Crate of Meat
		.collect 1 Recipe: Spicy Hot Talbuk##33873
	step
		.learn Spicy Hot Talbuk##43765 |use Recipe: Spicy Hot Talbuk##33873
	//300 Broiled Bloodfin TBC + Skullfish Soup TBC
	step
		//Barrel of fish 
		'Use the Shattrath Cooking Dailies section of this guide to get these recipes: |tip It's not always guarenteed to come from these daily prizes so be patient
		'Make sure to choose the Barrel of Fish
		.collect 1 Recipe: Broiled Bloodfin##33869
		.collect 1 Recipe: Skullfish Soup##33870
	step
		.learn Broiled Bloodfin##43761 |use Recipe: Broiled Bloodfin##33869
		.learn Skullfish Soup##43707 |use Recipe: Skullfish Soup##33870
	//300 Kibler's Bits TBC
	step
		'Use the Shattrath Cooking Dailies section of this guide to get this recipe: |tip It's not always guarenteed to come from these daily prizes so be patient
		'You can choose either the Crate of Meat of Barrel of Fish 
		.collect 1 Recipe: Kibler's Bits##33875
	step
		.learn Kibler's Bits##43772 |use Recipe: Kibler's Bits##33875
	//300 Stormchops TBC
	step
		'Use the Shattrath Cooking Dailies or Dalaran Cooking Dailies section of this guide to get these recipes: |tip It's not always guarenteed to come from these daily prizes so be patient
		'You can choose either Crate of Meat, Barrel of Fish, or Small Spice Bag
		.collect 1 Recipe: Stormchops##33871
		.collect 1 Recipe: Delicious Chocolate Cake##33925
	step
		.learn Stormchops##43758 |use Recipe: Stormchops##33871
		.learn Delicious Chocolate Cake##43779 |use Recipe: Delicious Chocolate Cake##33925
	step
		'You can either purchase these items from the Acution House or farm them
		.collect 8 Small Eggs##6889
		.collect 2 Buzzard Meat##27671
		.collect 2 Clefthoof Meat##27678
		.collect 2 Jaggal Clam Meat##24477
		.collect 2 Talbuk Venison##27682
		.collect 1 Chunk o' Basilisk##27677
		.collect 1 Raptor Ribs##31670
		.collect 1 Ravager Flesh##27674
		.collect 1 Serpent Flesh##31671
		.collect 1 Strange Spores##27676
		.collect 1 Warped Flesh##27681
		.collect 3 Mageroyal##785
	step
		'You can either purchase these items from the Auction House or fish for them
		.collect 2 Barbed Gill Trout##27422
		.collect 1 Bloodfin Catfish##33823
		.collect 1 Crescent-Tail Skullfish##33824
		.collect 1 Enormous Barbed Gill Trout##27516
		.collect 1 Figluster's Mudfish##27435
		.collect 1 Golden Darter##27438
		.collect 1 Huge Spotted Feltail##27515
		.collect 1 Icefin Bluefish##27437
		.collect 1 Lightning Eel##13757
		.collect 1 Spotted Feltail##27425
		.collect 1 Zangarian Sporefish##27429
	step
		goto Stormwind City,60.8,74.8
		.talk Inkeeper Allison##6740
		.buy 5 Goldenbark Apple##4539
		.buy 4 Ice Cold Milk##1179
	step
		goto 77.6,53.1
		.talk Erika Tate##5483
		.buy 8 Simple Flour##30817
		.buy 4 Mild Spices##2678 
	step
		goto Stormwind City,76.3,53.0
		.talk Reese Langston##1327
		.buy 1 Flask of Port##2593
	step
		'Build a Basic Campfire |cast Basic Campfire##818
		.create Delicious Chocolate Cake##43779,Cooking,1 total
		.' Cook Delicious Chocolate Cake |achieve 1800/1
	step
		.create Blackened Trout##33290,Cooking,1 total
		.' Cook Blackened Trout |achieve 1800/2
	step
		.create Buzzard Bites##33279,Cooking,1 total
		.' Cook Buzzard Bites |achieve 1800/3
	step
		.create Clam Bar##36210,Cooking,1 total
		.' Cook Clam Bar |achieve 1800/4
	step
		.create Feltail Delight##33291,Cooking,1 total
		.' Cook Feltail Delight |achieve 1800/5
	step
		.create Ravager Dog##33284,Cooking,1 total
		.' Cook Ravager Dog |achieve 1800/6
	step
		.create Stormchops##43758,Cooking,1 total
		.' Cook Stormchops |achieve 1800/7
	step
		.create Blackened Sporefish##33292,Cooking,1 total
		.' Cook Blackened Sporefish |achieve 1800/8
	step
		.create Blackened Basilisk##33286,Cooking,1 total
		.' Cook Blackened Basilisk |achieve 1800/9
	step
		.create Grilled Mudfish##33293,Cooking,1 total
		.' Cook Grilled Mudfish |achieve 1800/10
	step
		.create Poached Bluefish##33294,Cooking,1 total
		.' Cook Poached Bluefish |achieve 1800/11
	step
		.create Broiled Bloodfin##43761,Cooking,1 total
		.' Cook Broiled Bloodfin |achieve 1800/12
	step
		.create Golden Fish Sticks##33295,Cooking,1 total
		.' Cook Golden Fish Sticks |achieve 1800/13
	step
		.create Kibler's Bits##43772,Cooking,1 total
		.' Cook Kibler's Bits |achieve 1800/14
	step
		.create Roasted Clefthoof##33287,Cooking,1 total
		.' Cook Roasted Clefthoof |achieve 1800/15
	step
		.create Talbuk Steak##33289,Cooking,1 total
		.' Cook Talbuk Steak |achieve 1800/16
	step
		.create Warp Burger##33288,Cooking,1 total
		.' Cook Warp Burger |achieve 1800/17
	step
		.create Crunchy Serpent##38868,Cooking,1 total
		.' Cook Crunchy Serpent |achieve 1800/18
	step
		.create Mok'Nathal Shortribs##38867,Cooking,1 total
		.' Cook Mok'Nathal |achieve 1800/19
	step
		.create Fisherman's Feast##42302,Cooking,1 total
		.' Cook Fisherman's Feast |achieve 1800/20
	step
		.create Hot Buttered Trout##42305,Cooking,1 total
		.' Cook Hot Buttered Trout |achieve 1800/21
	step
		.create Skullfish Soup##43707,Cooking,1 total
		.' Cook Skullfish Soup |achieve 1800/22
	step
		.create Spicy Crawdad##33296,Cooking,1 total
		.' Cook Spicy Crawdad |achieve 1800/23
	step
		.create Spicy Hot Talbuk##43765,Cooking,1 total
		.' Cook Spicy Hot Talbuk |achieve 1800/24
	step
		.create Stewed Trout##42296,Cooking,1 total
		.' Cook Stewed Trout |achieve 1800/25
	step
		.' Cook each of the Outland cooking recipes |achieve 1800
	step
		Congratulations! You're earned The Outland Gourmet achievement!
]])

ZygorGuidesViewer:RegisterInclude("A_The_Northrend_Gourmet",[[
	//Northern Stew
	step
	title +Wrath of the Lich King Recipes
		#include trainCooking
		.learn Dalaran Clam Chowder##58065 
		.learn Grilled Sculpin##45563 
		.learn Mammoth Meal##45549 
		.learn Pickled Fangtooth##45566 
		.learn Poached Nettlefish##45565 
		.learn Rhino Dogs##45553 
		.learn Roasted Worg##45552 
	step
		#include trainCooking
		.learn Shoveltusk Steak##45550 
		.learn Smoked Salmon##45564 
		.learn Worm Delight##45551 
		.learn Fisherman's Feast##42302 
		.learn Hot Buttered Trout##42305 
		.learn Great Feast##45554 
		.learn Black Jelly##64358 
		.learn Darkbrew Lager##88015 
		.learn Blackened Surprise##88006
	step
		#include rideto_borean
	step
		alliance
		goto 57.8,71.4
		.talk Rollick MacKreel##26989
		..accept Northern Cooking##13088
	step
		goto 45,47.4
		.from Wooly Rhino Matriarch##25487+,Wooly Rhino Calf##25488+
		.get 4 Chilled Meat##43013 |q 13088
	step
		//alliance
		goto 57.8,71.4
		.talk Rollick MacKreel##26989
		..turnin Northern Cooking##13088
		.learn Northern Stew##57421
	//Emotions food
	step
		goto 54.6,70.0
		.from Crypt Crawler##25227
		.collect 1 Recipe: Bad Clams##43509
		.collect 1 Recipe: Last Week's Mammoth##43508
		.collect 1 Recipe: Haunted Herring##43510
		.collect 1 Recipe: Tasty Cupcake##43507
	step
		.learn Bad Clams##58523 |use Recipe: Bad Clams##43509
		.learn Haunted Herring##58525 |use Recipe: Haunted Herring##43510
		.learn Last Week's Mammoth##58521 |use Recipe: Last Week's Mammoth##43508
		.learn Tasty Cupcake##58512 |use Recipe: Tasty Cupcake##43507
	step
		fly Nesingwary Base Camp
	step
		goto 26.8,60.1
		.talk Grimbooze Thunderbrew##29157
		..accept Some Make Lemonade, Some Make Liquor##12634
	step
		goto 37.6,61.8
		.' Click the Sturdy Vines|tip They look like brown vines that hang from trees around this area. Sometimes a Dwarf will fall out and give you fruit you need.
		.' Click the fruit that falls to the ground or talk to the dwarf that falls
		.get Orange |q 12634/1
		.get 2 Banana Bunch|q 12634/2
		.get Papaya |q 12634/3
	step
		goto 26.8,60.1
		.talk Grimbooze Thunderbrew##29157
		..turnin Some Make Lemonade, Some Make Liquor##12634
		..accept Still At It##12644
	step
		goto 26.7,60
		.talk "Tipsy" McManus##28566
		..'Tell him you are ready to start the distillation process
		.' Click the items on the ground or on the machine that he yells at you during the process, it's random
		.' Click the barrel on the ground when the process is done
		.get Thunderbrew's Jungle Punch|q 12644/1
	step
		goto 26.8,60.1
		.talk Grimbooze Thunderbrew##29157
		..turnin Still At It##12644
		..accept The Taste Test##12645
	step
		goto 27.4,59.4
		.' Use your Jungle Punch Sample on Hadrius Harlowe|use Jungle Punch Sample##38697|tip Standing next to a tiki torch.
		.' Complete Hadrius' taste test|goal Hadrius' taste test|q 12645/2
	step
		goto 27.1,58.6
		.' Use your Jungle Punch Sample on Hemet Nesingwary|use Jungle Punch Sample##38697|tip Standing in front of a tent.
		.' Complete Hemet's taste test|goal Hemet's taste test|q 12645/1
	step
		goto 26.8,60.1
		.talk Grimbooze Thunderbrew##29157
		..turnin The Taste Test##12645
	step
		goto Sholazar Basin,25.3,58.5
		.talk The Spirit of Gnomeregan##28037
		.' Fly to Dalaran |goto Dalaran |noway |c
	step
		goto Dalaran,43.2,24.4
		.talk Washed-Up Mage##32516
		..accept Fletcher's Lost and Found##13571 |instant
	step
		'Use the Professions section of this guide to get to 450 cooking |only if skill("Cooking")<450
		'Use the Dalaran Cooking Dailies section of this guide to earn Dalaran Cooking Awards to buy the following recipes: |tip You will need a total of 74 Dalaran Cooking Awards to get all of the recipes
		goto Dalaran,70.1,38.2 
		#include "vendor_Cooking_Dalaran"
		.buy 1 Recipe: Mega Mammoth Meal##43018 
		.buy 1 Recipe: Tender Shoveltusk Steak##43019 
		.buy 1 Recipe: Spiced Worm Burger##43020 
		.buy 1 Recipe: Very Burnt Worg##43021 
		.buy 1 Recipe: Worg Tartare##44954 
		.buy 1 Recipe: Mighty Rhino Dogs##43022 
		.buy 1 Recipe: Poached Northern Sculpin##43023 //50
		.buy 1 Recipe: Firecracker Salmon##43024 
		.buy 1 Recipe: Spicy Blue Nettlefish##43025 
		.buy 1 Recipe: Imperial Manta Steak##43026 
		.buy 1 Recipe: Spicy Fried Herring##43027 
		.buy 1 Recipe: Rhinolicious Wormsteak##43028
	step
		'Use the Professions section of this guide to get to 450 cooking |only if skill("Cooking")<450
		.learn Mega Mammoth Meal##45555 |use Recipe: Mega Mammoth Meal##43018 
		.learn Tender Shoveltusk Steak##45556 |use Recipe: Tender Shoveltusk Steak##43019
		.learn Spiced Worm Burger##45557 |use Recipe: Spiced Worm Burger##43020
		.learn Very Burnt Worg##45558 |use Recipe: Very Burnt Worg##43021
		.learn Worg Tartare##62350 |use Recipe: Worg Tartare##44954
		.learn Mighty Rhino Dogs##45559 |use Recipe: Mighty Rhino Dogs##43022
		.learn Poached Northern Sculpin##45567 |use Recipe: Poached Northern Sculpin##43023
		.learn Firecracker Salmon##45568 |use Recipe: Firecracker Salmon##43024
		.learn Spicy Blue Nettlefish##45571 |use Recipe: Spicy Blue Nettlefish##43025
		.learn Imperial Manta Steak##45570 |use Recipe: Imperial Manta Steak##43026
		.learn Spicy Fried Herring##57433 |use Recipe: Spicy Fried Herring##43027
		.learn Rhinolicious Wormsteak##57434 |use  Recipe: Rhinolicious Wormsteak##43028
	step
		'Use the Professions section of this guide to get to 450 cooking |only if skill("Cooking")<450
		'Use the Dalaran Cooking Dailies section of this guide to earn Dalaran Cooking Awards to buy the following recipes: |tip You will need a total of 74 Dalaran Cooking Awards to get all of the recipes
		goto Dalaran,70.1,38.2 
		#include "vendor_Cooking_Dalaran"
		.buy 1 Recipe: Critter Bites##43029 
		.buy 1 Recipe: Hearty Rhino##43030 
		.buy 1 Recipe: Snapper Extreme##43031 
		.buy 1 Recipe: Blackened Worg Steak##43032 
		.buy 1 Recipe: Cuttlesteak##43033 
		.buy 1 Recipe: Spiced Mammoth Treats##43034 
		.buy 1 Recipe: Blackened Dragonfin##43035 
		.buy 1 Recipe: Dragonfin Fillet##43036 
		.buy 1 Recipe: Tracker Snacks##43037 
		.buy 1 Recipe: Gigantic Feast##43505 
		.buy 1 Recipe: Small Feast##43506 
		.buy 1 Recipe: Fish Feast##43017 
	step
		'Use the Professions section of this guide to get to 450 cooking |only if skill("Cooking")<450
		.learn Critter Bites##57435 |use Recipe: Critter Bites##43029
		.learn Hearty Rhino##57436 |use Recipe: Hearty Rhino##43030
		.learn Snapper Extreme##57437 |use Recipe: Snapper Extreme##43031
		.learn Blackened Worg Steak##57438 |use Recipe: Blackened Worg Steak##43032
		.learn Cuttlesteak##57439 |use Recipe: Cuttlesteak##43033
		.learn Spiced Mammoth Treats##57440 |use Recipe: Spiced Mammoth Treats##43034
		.learn Blackened Dragonfin##57441 |use Recipe: Blackened Dragonfin##43035
		.learn Dragonfin Fillet##57442 |use Recipe: Dragonfin Fillet##43036
		.learn Tracker Snacks##57443 |use Recipe: Tracker Snacks##43037
		.learn Gigantic Feast##58527 |use Recipe: Gigantic Feast##43505
		.learn Small Feast##58528 |use Recipe: Small Feast##43506 
		.learn Fish Feast##57423 |use Recipe: Fish Feast##43017
	step
		'You can either buy these from the Auction House or farm them
		.collect 1 Barrelhead Goby##41812
		.collect 4 Bonescale Snapper##41808
		.collect 5 Chilled Meat##43013
		.collect 8 Chunk o' Mammoth##34736
		.collect 2 Deep Sea Monsterbelly##41800
		.collect 2 Dragonfin Angelfish##41807
		.collect 1 Essence of Undeath##12808
		.collect 3 Fangtooth Herring##41810
		.collect 6 Glacial Salmon##41809
		.collect 2 Imperial Manta Ray##41809
		.collect 1 Moonglow Cuttlefish##41801
		.collect 1 Mote of Shadow##22577
		.collect 4 Musselback Sculpin##41806
		.collect 6 Nettlefish##51813
		.collect 1 Northern Egg##43501
		.collect 24 Northern Spices##43007
		.collect 7 Rhino Meat##43012
		.collect 3 Rockfin Grouper##41803
		.collect 1 Savory Snowplum##35948
		.collect 5 Shoveltusk Flank##43009
		.collect 3 Succulent Clam Meat##36782
		.collect 2 Tundra Berries##35949
		.collect 5 Worg Haunch##43011
	step
		goto 77.6,53.1
		.talk Erika Tate##5483
		.buy 2 Simple Flour##30817
	step
		goto Stormwind City,60.8,74.8
		.talk Inkeeper Allison##6740
		.collect 2 Tundra Berries##35949
	step
		'Build a Basic Campfire |cast Basic Campfire##818
		.create Bad Clams##58523,Cooking,1 total
		.' Cook Bad Clams |achieve 1777/1
	step
		'create Baked Manta Ray##45569,Cooking,1 total
		.' Cook Baked Manta Ray |achieve 1777/2
	step
		.create Blackened Dragonfin##57441,Cooking,1 total
		.' Cook Blackened Dragonfin |achieve 1777/3
	step
		.create Blackened Worg Steak##57438,Cooking,1 total
		.' Cook Blackened Worg Steak |achieve 1777/4
	step
		.create Critter Bites##57435,Cooking,1 total
		.' Cook Critter Bites |achieve 1777/5
	step
		.create Cuttlesteak##57439,Cooking,1 total
		.' Cook Cuttlesteak |achieve 1777/6
	step
		.create Dalaran Clam Chowder##58065,Cooking,1 total
		.' Cook Dalaran Clam Chowder |achieve 1777/7
	step
		.create Dragonfin Filet##57442,Cooking,1 total
		.' Cook Dragonfin Filet |achieve 1777/8
	step
		.create Firecracker Salmon##45568,Cooking,1 total
		.' Cook Firecracker Salmon |achieve 1777/9
	step
		.create Fish Feast##57423,Cooking,1 total
		.' Cook Fish Feast |achieve 1777/10
	step
		.create Gigantic Feast##58527,Cooking,1 total
		.' Cook Gigantic Feast |achieve 1777/11
	step
		.create Great Feast##45554,Cooking,1 total
		.' Cook Great Feast |achieve 1777/12
	step
		.create Grilled Bonescale##45561,Cooking,1 total
		.' Cook Grilled Bonescale |achieve 1777/13
	step
		.create Grilled Sculpin##45563,Cooking,1 total
		.' Cook Grilled Sculpin |achieve 1777/14
	step
		.create Haunted Herring##58525,Cooking,1 total
		.' Cook Haunted Herring |achieve 1777/15
	step
		.create Hearty Rhino##57436,Cooking,1 total
		.' Cook Hearty Rhino |achieve 1778/16
	step
		.create Imperial Manta Steak##45570,Cooking,1 total
		.' Cook Imperial Manta Steak |achieve 1778/17
	step
		.create Kungaloosh##53056,Cooking,1 total
		.' Cook Kungaloosh |achieve 1778/18
	step
		.create Last Week's Mammoth##58521,Cooking,1 total
		.' Cook Last Week's Mammoth |achieve 1778/19
	step
		.create Mammoth Meal##45549,Cooking,1 total
		.' Cook Mammoth Meal |achieve 1778/20
	step
		.create Mega Mammoth Meal##45555,Cooking,1 total
		.' Cook Mega Mammoth Meal |achieve 1778/21
	step
		.create Mighty Rhino Dogs##45559,Cooking,1 total
		.' Cook Mighty Rhino Dogs |achieve 1778/22
	step
		.create Northern Stew##57421,Cooking,1 total
		.' Cook Northern Stew |achieve 1778/23
	step
		.create Pickeled Fangtooth##45566,Cooking,1 total
		.' Cook Pickeled Fangtooth |achieve 1778/24
	step
		.create Poached Nettlefish##45565,Cooking,1 total
		.' Cook Poached Nettlefish |achieve 1778/25
	step
		.create Poached Northern Sculpin##45567,Cooking,1 total
		.' Cook Poached Northern Sculpin |achieve 1778/26
	step
		.create Rhino Dogs##45553,Cooking,1 total
		.' Cook Rhino Dogs |achieve 1778/27
	step
		.create Rhinolicious Wormsteak##57434,Cooking,1 total
		.' Cook Rhinolicious Wormsteak |achieve 1778/28
	step
		.create Roasted Worg##45552,Cooking,1 total
		.' Cook Roasted Worg |achieve 1778/29
	step
		.create Sauteed Goby##45562,Cooking,1 total
		.' Cook Sauteed Goby |achieve 1778/30
	step
		.create Shoveltusk Steak##45550,Cooking,1 total
		.' Cook Shoveltusk Steak |achieve 1779/31
	step
		.create Small Feast##58528,Cooking,1 total
		.' Cook Small Feast |achieve 1779/32
	step
		.create Smoked Rockfin##45560,Cooking,1 total
		.' Cook Smoked Rockfin |achieve 1779/33
	step
		.create Smoked Salmon##45564,Cooking,1 total
		.' Cook Smoked Salmon |achieve 1779/34
	step
		.create Snapper Extreme##57437,Cooking,1 total
		.' Cook Snapper Extreme |achieve 1779/35
	step
		.create Spiced Mammoth Treats##57440,Cooking,1 total
		.' Cook Spiced Mammoth |achieve 1779/36
	step
		.create Spiced Worm Burger##45557,Cooking,1 total
		.' Cook Spiced Worm Burger |achieve 1779/37
	step
		.create Spicy Blue Nettlefish##45571,Cooking,1 total
		.' Cook Spicy Blue Nettlefish |achieve 1779/38
	step
		.create Spicy Fried Herring##57433,Cooking,1 total
		.' Cook Spicy Fried Herring |achieve 1779/39
	step
		.create Tasty Cupcake##58512,Cooking,1 total
		.' Cook Tasty Cupcake |achieve 1779/40
	step
		.create Tender Shoveltusk Steak##45556,Cooking,1 total
		.' Cook Tender Shoveltusk Steak |achieve 1779/41
	step
		.create Tracker Snacks##57443,Cooking,1 total
		.' Cook Tracker Snacks |achieve 1779/42
	step
		.create Very Burnt Worg##45558,Cooking,1 total
		.' Cook Very Burnt Worg |achieve 1779/43
	step
		.create Worg Tartare##62350,Cooking,1 total
		.' Cook Worg Tartare |achieve 1779/44
	step
		.create Worm Delight##45551,Cooking,1 total
		.' Cook Worm Delight |achieve 1779/45
		..' Cook 45 of the Northrend recipes |achieve 1779
	step
		'Congratulations! You've earned the Northrend Gourment achievement!
]])

ZygorGuidesViewer:RegisterInclude("A_Our_Daily_Bread",[[ 
	step
	title +Dalaran Cooking Dailies
		goto Dalaran,70.0,39.0
		.talk Awilo Long'gomba##29631
		.' You will only be able to accept, and turn in, 1 of these 5 daily quests per day, and they all require you have 350+ Cooking skill:
		..accept Cheese for Glowergold##13115 |or
		..accept Convention at the Legerdemain##13113 |or
		..accept Infused Mushroom Meatloaf##13112 |or
		..accept Mustard Dogs!##13116 |or
		..accept Sewer Stew##13114 |or
	step
		goto Dalaran,40.8,65.4
		.talk Katherine Lee##28705
		.' You will only be able to accept, and turn in, 1 of these 5 daily quests per day, and they all require you have 350+ Cooking skill:
		..accept Cheese for Glowergold##13103 |daily |or
		..accept Convention at the Legerdemain##13101 |daily |or
		..accept Infused Mushroom Meatloaf##13100 |daily |or
		..accept Mustard Dogs!##13107 |daily |or
		..accept Sewer Stew##13102 |daily |or
	step
		goto 54.7,31.5
		.' Click the Aged Dalaran Limburger|tip They look like piles and pieces of yellow cheese on the tables inside this building.
		.collect 1 Aged Dalaran Limburger##43137 |q 13103
		.' Click the Half Full Glasses of Wine|tip They look like small blue-ish wine glasses sitting on tables, and on the ground, inside this building.  They spawn in random locations.
		.collect 6 Half Full Dalaran Wine Glass##43138 |q 13103
		.' You can find more Half Full Glasses of Wine inside the building at [49.4,39.3]
	step
		'Use your Empty Cheese Serving Platter in your bags|use Empty Cheese Serving Platter##43139
		.get 1 Wine and Cheese Platter |q 13103/1
	step
		goto 55.0,30.8
		.' Click a Full Jug of Wine|tip They look like small blue-ish green jugs sitting on the ground inside this building.  They spawn in random locations.
		.get 1 Jug of Wine |q 13101/2
	step
		goto Dragonblight,30.0,49.8
		.from Rabid Grizzly##26643+, Blighted Elk##26616+
		.collect 4 Chilled Meat##43013 |q 13101
	step
		'Use your Cooking ability to cook 4 Northern Stew|tip You will need a cooking fire to do this.
		.get 4 Northern Stew |q 13101/1
	step
		'The entrance to the Dalaran sewers starts here|goto Dalaran,60.2,47.7,0.3|c|q 13100
	step
		goto Dalaran/2 59.5,43.6
		.from Underbelly Rat##32428+
		.collect 4 Infused Mushroom##43100 |q 13100
	step
		'Leave the Dalaran sewers|goto Dalaran,60.2,47.7,0.3|c|q 13100
	step
		goto Dragonblight,30.0,49.8
		.from Rabid Grizzly##26643+, Blighted Elk##26616+
		.collect 2 Chilled Meat##43013 |q 13100
	step
		'Use your Meatloaf Pan in your bags|use Meatloaf Pan##43101|tip You will need a cooking fire to do this.
		.get 1 Infused Mushroom Meatloaf |q 13100/1
	step
		goto Dalaran,67.7,40.0
		.' Click the Wild Mustard|tip They look like small, and kind of hard to see, bushy yellow flowers on the ground around this area.  They spawn randomly in grassy areas.
		.collect 4 Wild Mustard##43143 |q 13107
		.' You can find more Wild Mustard flowers:
		..' at [50.3,48.3]
		..' at [37.2,43.9]
	step
		goto Borean Tundra,46.7,43.6
		.from Wooly Rhino Calf##25488+, Wooly Rhino Matriarch##25487+, Wooly Rhino Bull##25489+
		.collect 4 Rhino Meat##43012 |q 13107
	step
		'Use your Cooking ability to cook 4 Rhino Dogs|tip You will need a cooking fire to do this.
		.collect 4 Rhino Dogs##34752 |q 13107
	step
		'Use your Empty Picnic Basket in your bags|use Empty Picnic Basket##43142
		.get 1 Mustard Dog Basket! |q 13107/1
	step
		goto Crystalsong Forest,26.9,45.5
		.' Click the Crystalsong Carrots|tip they look like carrots sticking out of the ground, at the base of trees around this area underneath Dalaran.  They spawn in random locations around this area.
		.collect 4 Crystalsong Carrot##43148 |q 13102
	step
		goto Dragonblight,30.0,49.8
		.from Rabid Grizzly##26643+, Blighted Elk##26616+
		.collect 4 Chilled Meat##43013 |q 13102
	step
		'Use your Stew Cookpot in your bags|use Stew Cookpot##43147|tip You will need a cooking fire to do this.
		.get 1 Vegetable Stew |q 13102/1
	step
		goto Dalaran,36.6,27.8
		.talk Ranid Glowergold##28718
		..turnin Cheese for Glowergold##13103
	step
		goto Dalaran,48.6,37.5
		.talk Arille Azuregaze##29049
		..turnin Convention at the Legerdemain##13101
	step
		goto Dalaran,52.3,55.6
		.talk Orton Bennet##29527
		..turnin Infused Mushroom Meatloaf##13100
	step
		goto Dalaran,68.6,42.0
		.talk Archmage Pentarus##28160
		..turnin Mustard Dogs!##13107
	step
		'The entrance to the Dalaran sewers starts here|goto Dalaran,60.2,47.7,0.3|c|q 13102
	step
		goto Dalaran,35.5,57.6
		.talk Ajay Green##29532
		..turnin Sewer Stew##13102
]])

ZygorGuidesViewer:RegisterInclude("A_Critter_Gitter",[[
	step
		'You can either buy these from the Auction House or farm them
		.collect 10 Critter Bites##43004
		.' Click here to go farm for these |script ZGV:GotoStep("farm1")
		|next "gitter"
	step
	label farm1
		'You can either buy these from the Auction House or farm them
		.collect 20 Chilled Meat##43013
		.collect 10 Northern Spices##43007
		.' Click here to go farm for these |script ZGV:GotoStep("farm2")
		|next "make"
	step
	label farm2
		#include rideto_borean
	step
	title +Chilled Meat
		goto Borean Tundra,78.2,24.0
		.from Scourged Mammoth##25452+
		.collect 20 Chilled Meat##43013
	step
	title +Northern Spices
		'Use the Dalaran Cooking Dailies section of this guide to get Small Spice Bags
		.collect Spice Bag##44113 |n
		.collect 10 Northern Spices##43007
	step
	label make
	title +Critter Gitter
		'Get someone to make your 10 Critter Bites |tip Ask in your guild or in trade for someone to make these. Be sure to tip well! 
		.' Or... |only if skill("Cooking")>=400
		'Build a Basic Campfire |cast Basic Campfire##818 |only if skill("Cooking")>=400
		.create Critter Bites##57435,Cooking,10 total |only if skill("Cooking")>=400
		.collect 10 Critter Bites##43004
		.' Click here if you don't have the recipe |script ZGV:GotoStep("recipe") |only if skill("Cooking")>=400
		|next "gitter"
	step
	label recipe
		'Use the Dalaran Cooking Dailies section of this guide to earn 3 Dalaran Cooking Awards
		.earn 3 Dalaran Cooking Award##81 
	step
		goto Dalaran,70.2,37.2
		.talk Misensi##31031
		.buy 1 Recipe: Critter Bites##43029
	step
		.learn Critter Bites##57435
	step
		'Build a Basic Campfire |cast Basic Campfire##818 
		.create Critter Bites##57435,Cooking,10 total 
		.collect 10 Critter Bites##43004
	step
	label gitter
		|fly Thondroril River
	step
		goto Eastern Plaguelands,4.7,35.5
		'Target the Beetles, Scorpions, and Cockroaches and use the Critter Bites on them |use Critter Bites##43004
		|tip Use all 10 Critter Bites as quick as possible. These critters are scattered all throughout the tunnel.
		.' Coerce 10 critters to be your pet within 3 minutes or less |achieve 1781
	step
		'Congratulations! You've earned the Critter Gitter achievement!
]])

ZygorGuidesViewer:RegisterInclude("A_Dinner_Impossible",[[
	step
		'You can either buy these items from the auction house or use the Cooking professions guide to reach level 375 Cooking, otherwise you cannot complete this achievement. |only if skill("Cooking")<375
		'You can either buy these items from the auction house or farm them |only if skill("Cooking")>=375
		.collect 5 Great Feast##34753
		.' Click here to go farm these materials |script ZGV:GotoStep("farm1")
		|next usefeast
	step
		#include trainCooking |only if skill("Cooking")>=375
		.learn Great Feast##45554 |only if skill("Cooking")>=375
	step
	label farm1
		'You can either buy these items from the auction house or farm them 
		.collect 5 Chunk o'Mammoth##34736 
		.collect 5 Shoveltusk Flank##43009 
		.collect 5 Worm Meat##43010 
		.collect 10 Chilled Meat##43013 
		.' Click here to go farm these materials |script ZGV:GotoStep("farm2")
		|next makefeast
	step
	label farm2
		#include rideto_borean
	step
		goto 78.2,24.0
		.from Scourged Mammoth##25452+
		.collect 5 Chunk o'Mammoth##34736 
		.collect 10 Chilled Meat##43013 
	step
		goto 76.2,23.0
		.from Tundra Crawler##25454+
		.collect 5 Worm Meat##43010 
	step
		fly Valgarde
	step
		goto 73.6,40.0
		.from Shoveltusk##23690+
		.collect 5 Shoveltusk Flank##43009 
	step
		#include hearth_hub
	step
	label makefeast
		'Have someone make the Great Feasts for you |tip Ask in your guild or in trade for someone to make these |only if skill("Cooking")<375
		'Create a basic campfire |cast Basic Campfire##818 |only if skill("Cooking")>=375
		.create 5 Great Feast##45554,Cooking,4 total |only if skill("Cooking")>=375
		.collect 5 Great Feast##34753
	step
	label usefeast
		'Push [H] on your keyboard to open your Player vs. Player interface 
		.' Click on Alterac Valley and then click on the Join Battle button on the lower left-hand corner of the Player vs. Player interface
		..' Wait for the que to pop-up in the middle of your screen and click on accept	
		..' Go to Alterac Valley |goto Alterac Valley |noway |c
	step
		'Use one of your Great Feasts |use Great Feast##34753 
		.' Present a Great Feast in Alterac Valley |achieve 1784/1 |tip You can leave the battleground now, but you will have to wait 15 minutes to complete the next step
	step
		'Push [H] on your keyboard to open your Player vs. Player interface 
		.' Click on Arathi Basin and then click on the Join Battle button on the lower left-hand corner of the Player vs. Player interface
		..' Wait for the que to pop-up in the middle of your screen and click on accept	
		..' Go to Arathi Basin |goto Arathi Basin |noway |c
	step
		'Use one of your Great Feasts |use Great Feast##34753 
		.' Present a Great Feast in Arathi Basin |achieve 1784/2 |tip You can leave the battleground now, but you will have to wait 15 minutes to complete the next step
	step
		'Push the [H] key on your keyboard to open your Player vs. Player interface 
		.' Click on Warsong Gulch and then click on the Join Battle button on the lower left-hand corner of the Player vs. Player interface
		..' Wait for the que to pop-up in the middle of your screen and click on accept	
		..' Go to Warsong Gulch |goto Warsong Gulch |noway |c
	step
		'Use one of your Great Feasts |use Great Feast##34753 
		.' Present a Great Feast in Warsong Gulch |achieve 1784/3 |tip You can leave the battleground now, but you will have to wait 15 minutes to complete the next step
	step
		'Push [H] on your keyboard to open your Player vs. Player interface 
		.' Click on Strand of the Ancients and then click on the Join Battle button on the lower left-hand corner of the Player vs. Player interface
		..' Wait for the que to pop-up in the middle of your screen and click on accept	
		..' Go to Strand of the Ancients |goto Strand of the Ancients |noway |c
	step
		'Use one of your Great Feasts |use Great Feast##34753 
		.' Present a Great Feast in Strand of the Ancients |achieve 1784/4 |tip You can leave the battleground now, but you will have to wait 15 minutes to complete the next step
	step
		'Push [H] on your keyboard to open your Player vs. Player interface 
		.' Click on Arathi Basin and then click on the Join Battle button on the lower left-hand corner of the Player vs. Player interface
		..' Wait for the que to pop-up in the middle of your screen and click on accept	
		..' Go to Eye of the Storm |goto Arathi Basin |noway |c
	step
		'Use one of your Great Feasts |use Great Feast##34753 
		.' Present a Great Feast in Eye of the Storm |achieve 1784/5 
	step
		Congratulations! You've earned the Dinner Impossible achievement!
]])

ZygorGuidesViewer:RegisterInclude("A_Captain_Rumsey's_Lager",[[ 
	step
		'Use the Shattrath or Dalaran Cooking Dailies, or the Fishing Dailies of this guide to get this recipe: |tip It's not always guarenteed to come from these daily prizes so be patient
		.collect 1 Recipe: Captain Rumsey's Lager##34834
	step
		.learn Captain Rumsey's Lager##45695 |use Recipe: Captain Rumsey's Lager##34834
	step
		goto Stormwind City,76.3,53.0
		.talk Reese Langston##1327
		.buy 1 Flask of Port##2593
		.buy 1 Flagon of Mead##2594
		.buy 1 Skin of Dwarven Stout##2596
	step
		.create Captain Rumsey's Lager##45695,Cooking,1 total
		.' Brew up Captain Rumsey's Lager |achieve 1801
	step
		'Congratulations! You've earned the Captain Rumsey's Lager achievement!
]])

--------------------------------------------------------------------------------------------------------------------------------------
-- Fishing
--------------------------------------------------------------------------------------------------------------------------------------

ZygorGuidesViewer:RegisterInclude("A_Old_Gnome_and_the_Sea",[[
	step
		|fly Lakeshire
	step
		goto Redridge Mountains,27.6,48.7
		.' Look for Sagefish Schools in the water.  Walk along the lake in Lakeshire until you find one if you're unable to see one at this spot.
		.' It looks like a swarm of fish.
		.' Use you fishing skill until your lure is inside of the school of fish, then catch one. |cast Fishing##7620
		.' Earn The Old Gnome and the Sea Achievement. |achieve 153
	step
		'Congratulations! You've earned The Old Gnome and the Sea achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_The_Scavenger",[[
	step
		#include darkportal
	step
		|fly Telredor
	step
		goto 57.0,56.0
		.' Look for Steam Pump Flotsam in the water around this area and fish from it |cast Fishing##7620
		.' Fish from Steam Pump Flotsam |achieve 1257/1
	step
		#include hearth_hub
	step
		|fly Rebel Camp
	step
		goto 55.0,64.0
		.' Look for Schooner Wreckage around this area |tip You may need to fish from other pools to get this to show up |cast Fishing##7620
		.' Fish from Schooner Wreckage |achieve 1257/3
	step
		'Go to The Cape of Stranglethorn |goto The Cape of Stranglethorn 50,50 <500
	step
		goto 30.9,81.5
		.' Look for Bloodsail Wreckage around this area |tip You may need to fish from other pools to get this to show up |cast Fishing##7620
		.' Fish from Bloodsail Wreckage |achieve 1257/2
	step
		#include ratchet
	step
		|fly Gadgetzan 
	step
		goto 67.4,38.2
		.' Look for Floating Wreckage around this area |tip You may have to fish from other pools to get this to show up |cast Fishing##7620
		.' Fish from Floating Wreckage |achieve 1257/5
	step
		|fly Feathermoon Stronghold
	step
		goto Feralas,63.1,51.5 
		.' Look for Waterlogged Wreckage around this area |tip You may have to fish from other pools to get this to show up |cast Fishing##7620
		.' Fish from Waterlogged Wreckage |achieve 1257/4
	step
		.' Successfully fish in each of the junk nodes |achieve 1257
	step
		'Congratulations! You've earned The Scavenger achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_The_Fishing_Diplomat",[[
	step
		.' Go to Stormwind City |goto Stormwind City |noway |c
	step
		goto 69.0,92.2
		.' Use your fishing skill in the moat in front of Stormwind City |cast Fishing##7620
		.' Fish in Stormwind City |achieve 150/2
	step
		|fly Booty Bay
	step
		.' Ride the Boat to Ratchet |goto Northern Barrens |noway|c
	step
		goto Northern Barrens,70.2,4.4 |n
		.' Cross the bridge over into Orgrimmar |goto Orgrimmar
	step
		goto Orgrimmar,24.8,62.8
		.' Use your fishing skill in the pond |cast Fishing##7620
		.' Fish in Orgrimmar |achieve 150/1
	step
		.' Earn The Fishing Diplomat. |achieve 150
	step
		'Congratulations! You've earned The Fishing Diplomat achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Mr._Pinchy's_Magical_Crawdad_Box",[[
	step
		.' You will need track fishing in horder to help you find Highland Mixed Schools.
		.learn Find Fish##43308  |next "HaveFishTracking"
		.' Click this line in order to attain Track Fishing |confirm
	step
		.' Go to Stormwind |goto Stormwind City |noway |c
	step
		|fly Slabchisel's Survey
	step
		goto Stormwind City,49.0,87.4 |n
		.' Click the Swirling Portal to Blasted Lands |goto Blasted Lands
	step
		goto Blasted Lands,55.0,53.9
		.' Go through the Dark Portal |goto Hellfire Peninsula |noway|c
	step
		|fly Shattrath
	step
		.' Go east to Terokkar Forest |goto Terokkar Forest
	step
		goto Terokkar Forest,65.0,76.8
		.' Use your Find Fish ability to locate Highland Mixed Schools
		.' Use your fishing skill to fish in the pond |cast Fishing##7620
	step
		goto Terokkar Forest,63.4,76.9
		.' Fish around this large pool of water from Highland Mixed Schools.
		.' Additional Pools can be found at Lake Ere'Noru, [60.6,59.9]
		.' and Lake Jorune, [45.0,40.5]
		.collect Magical Crawdad Box##27445
		.' Earn the Mr. Pinchy's Magical Crawdad Box achievement. |achieve 726
	step
		goto Terokkar Forest,66.5,84.3
		.' Here [Terokkar Forest,66.5,84.3]
		.' Here [Terokkar Forest,65.9,73.1]
		.' Here [Terokkar Forest,60.6,59.9]
		.' Here [Terokkar Forest,45.0,40.5]
		.' Use your fishing skill to fish in the pond |cast Fishing##7620
		.collect 1 Magical Crawdad Box##27445 |n
		'|modeldisplay 3215
		.learnpet Magical Crawdad##18839 |use Magical Crawdad Box##27445
]])
ZygorGuidesViewer:RegisterInclude("A_Fishing_25_Fish",[[
	step
		goto Stormwind City,54.9,69.7
		.talk Catherine Leland##5494
		.buy 1 Fishing Pole##6256
		.buy 10 Shiny Bauble##6529
	step
		.' Equip your Fishing Pole |use Fishing Pole##6256
		.' Use the Shiny Bauble to temporarily increase your Fishing skill, to make it easier to catch fish |use Shiny Bauble##6529 |tip If your Shiny Bauble Fishing skill boost expires, you can buy more Shiny Baubles to help you fish.
		.' Stand on the end of this wooden dock
		.' Use your Fishing skill to fish in the water all around the wooden dock |cast Fishing##7620
		.' Catch 25 Fish. |achieve 1556
	step
		'Congratulations! You've earned the 25 Fish achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Fishing_50_Fish",[[
	step
		goto Stormwind City,54.9,69.7
		.talk Catherine Leland##5494
		.buy 1 Fishing Pole##6256
		.buy 10 Shiny Bauble##6529
	step
		.' Equip your Fishing Pole |use Fishing Pole##6256
		.' Use the Shiny Bauble to temporarily increase your Fishing skill, to make it easier to catch fish |use Shiny Bauble##6529 |tip If your Shiny Bauble Fishing skill boost expires, you can buy more Shiny Baubles to help you fish.
		.' Stand on the end of this wooden dock
		.' Use your Fishing skill to fish in the water all around the wooden dock |cast Fishing##7620
		.' Catch 50 Fish. |achieve 1557
	step
		'Congratulations! You've earned the 50 Fish achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Fishing_100_Fish",[[
	step
		goto Stormwind City,54.9,69.7
		.talk Catherine Leland##5494
		.buy 1 Fishing Pole##6256
		.buy 10 Shiny Bauble##6529
	step
		.' Equip your Fishing Pole |use Fishing Pole##6256
		.' Use the Shiny Bauble to temporarily increase your Fishing skill, to make it easier to catch fish |use Shiny Bauble##6529 |tip If your Shiny Bauble Fishing skill boost expires, you can buy more Shiny Baubles to help you fish.
		.' Stand on the end of this wooden dock
		.' Use your Fishing skill to fish in the water all around the wooden dock |cast Fishing##7620
		.' Catch 100 Fish. |achieve 1558
	step
		'Congratulations! You've earned the 100 Fish achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Fishing_250_Fish",[[
	step
		goto Stormwind City,54.9,69.7
		.talk Catherine Leland##5494
		.buy 1 Fishing Pole##6256
		.buy 10 Shiny Bauble##6529
	step
		.' Equip your Fishing Pole |use Fishing Pole##6256
		.' Use the Shiny Bauble to temporarily increase your Fishing skill, to make it easier to catch fish |use Shiny Bauble##6529 |tip If your Shiny Bauble Fishing skill boost expires, you can buy more Shiny Baubles to help you fish.
		.' Stand on the end of this wooden dock
		.' Use your Fishing skill to fish in the water all around the wooden dock |cast Fishing##7620
		.' Catch 250 Fish. |achieve 1559
	step
		'Congratulations! You've earned the 250 Fish achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Fishing_500_Fish",[[
	step
		goto Stormwind City,54.9,69.7
		.talk Catherine Leland##5494
		.buy 1 Fishing Pole##6256
		.buy 10 Shiny Bauble##6529
	step
		.' Equip your Fishing Pole |use Fishing Pole##6256
		.' Use the Shiny Bauble to temporarily increase your Fishing skill, to make it easier to catch fish |use Shiny Bauble##6529 |tip If your Shiny Bauble Fishing skill boost expires, you can buy more Shiny Baubles to help you fish.
		.' Stand on the end of this wooden dock
		.' Use your Fishing skill to fish in the water all around the wooden dock |cast Fishing##7620
		.' Catch 500 Fish. |achieve 1560
	step
		'Congratulations! You've earned the 500 Fish achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Fishing_1000_Fish",[[
	step
		goto Stormwind City,54.9,69.7
		.talk Catherine Leland##5494
		.buy 1 Fishing Pole##6256
		.buy 10 Shiny Bauble##6529
	step
		.' Equip your Fishing Pole |use Fishing Pole##6256
		.' Use the Shiny Bauble to temporarily increase your Fishing skill, to make it easier to catch fish |use Shiny Bauble##6529 |tip If your Shiny Bauble Fishing skill boost expires, you can buy more Shiny Baubles to help you fish.
		.' Stand on the end of this wooden dock
		.' Use your Fishing skill to fish in the water all around the wooden dock |cast Fishing##7620
		.' Catch 1000 Fish. |achieve 1561
	step
		'Congratulations! You've earned the 1000 Fish achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Fishing_1-1000_Fish",[[
	step
		goto Stormwind City,54.9,69.7
		.talk Catherine Leland##5494
		.buy 1 Fishing Pole##6256
		.buy 10 Shiny Bauble##6529
	step
		.' Equip your Fishing Pole |use Fishing Pole##6256
		.' Use the Shiny Bauble to temporarily increase your Fishing skill, to make it easier to catch fish |use Shiny Bauble##6529 |tip If your Shiny Bauble Fishing skill boost expires, you can buy more Shiny Baubles to help you fish.
		.' Stand on the end of this wooden dock
		.' Use your Fishing skill to fish in the water all around the wooden dock |cast Fishing##7620
		.' Catch 25 Fish. |achieve 1556
		.' Catch 50 Fish. |achieve 1557
		.' Catch 100 Fish. |achieve 1558
		.' Catch 250 Fish. |achieve 1559
		.' Catch 500 Fish. |achieve 1560
		.' Catch 1000 Fish. |achieve 1561
	step
		'Congratulations! You've earned the 1000 Fish achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Old_Crafty_and_Ironjaw",[[
	step
		.' In order to Earn this achievement, you will need to fish from any pool of water in Orgrimmar.
		.' The higher level your fishing skill, the better.  You will catch less junk the higher you are, which gives you a higher chance to catch Old Crafty.
		.' Click here when you're ready to proceed to the next step in the guide |confirm
	step
		.' Go to Stormwind |goto Stormwind City
	step
		|fly Booty Bay
	step
		.' Ride the boat to Ratchet |goto Northern Barrens
	step
		goto Northern Barrens,70.2,4.4 |n
		.' Cross the bridge over into Orgrimmar |goto Orgrimmar
	step
		goto Orgrimmar,59.3,39.9
		.' Use your fishing ability in the stream of water. |cast Fishing##7620
		.collect Old Crafty##34486
	step
		.' Earn the Old Crafty Achievement. |achieve 1836
	step
		.' Go to Stormwind |goto Stormwind City
	step
		|fly The Great Forge
	step
		goto Ironforge,47.6,14.2
		.' Use your fishing ability in the pond. |cast Fishing##7620
		.collect Old Ironjaw##34484
	step
		.' Earn the Old Ironjaw Achievement. |achieve 1837
	step
		'Congratulations! You've earned the Old Ironjaw achievement!
		'Congratulations! You've earned the Old Crafty achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_The_Lurker_Above",[[
	step
		.' In order to earn this achievement, you will need to be in a raid group.
		.' You will also need to be at least Level 70.
		.' It would be best if you picked up Elixirs of Water Walking 
		.' You won't need a certain level of fishing, but the high level you are, the higher change you have of fishing up 'The Lurker Below'.
		.' Click here after you  have read the requirements for this achievement. |confirm
	step
		goto Stormwind City,49.0,87.4 |n
		.' Click the Swirling Portal to Blasted Lands |goto Blasted Lands
	step
		goto Blasted Lands,55.0,53.9
		.' Go through the Dark Portal |goto Hellfire Peninsula |noway|c
	step
		|fly Telredor
	step
		goto Zangarmarsh,50.4,41.0 |n
		.' Swim down underwater through the tube to the Coilfang Reservoir |goto 51.9,38.0 |c
	step
		.' Go North into Serpent Shrine Cavern |goto Serpentshrine Cavern
	step
		 goto Serpentshrine Cavern,13.5,59.6
		 .' Ride the elevator down
		.' Click here once you're at the bottom and off of the elevator |confirm
	step
		goto Serpentshrine Cavern,19.6,68.5
		.' Walk up the ramp and ride the elevator up.
		.' Click here once you ride the elevator up. |confirm
	step
		goto Serpentshrine Cavern,22.7,72.8 |n
		.' Use your water walking potion and jump into the water. |use Elixir of Water Walking##8827
		.' If you jump into the water without water walking, fish will attack you and you will have to kill them before using your Elixir.
		.' Walk over to the wooden circle with the Strange pool in the center |goto Serpentshrine Cavern,38.6,59.5 |c
	step
		.' Once you're there, use your fishing ability and make sure that your lure lands in the Strange Pool. |cast Fishing##7620
		.' Earn The Lurker Above Achievement. |achieve 144
	step
		'Congratulations! You've earned The Lurker Above achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Old_Man_Barlowned",[[
	step
		.' In order the earn this achievement, you will need to have completed these 5 daily quests:
		.' Crcolisks in the City |achieve 905/1
		.' Bait Bandits |achieve 905/2
		.' Felblood Fillet |achieve 905/3
		.' The One That Got Away |achieve 905/4
		.' Shrimpin' Ain't Easy |achieve 905/5
		.' Click here to proceed |confirm
	step
		goto Terokkar Forest,38.7,12.8
		.talk Old Man Barlo##25580
		.' You will only be able to pick up 1 of 5 dailies per day.
		.accept Crocolisks in the City##11665 |or |daily
		.accept Bait Bandits##11666 |or |daily
		.accept Felblood Fillet##11669 |or |daily
		.accept The One That Got Away##11667 |or |daily
		.accept Shrimpin' Ain't Easy##11668 |or |daily
	step
		.' Go West to Shattrath City |goto Shattrath City
		only if havequest(11665)
	step
		goto Shattrath City,57.2,48.2
		.' Click the Shattrath Portal to Stormwind |goto Stormwind City
		only if havequest(11665)
	step
		goto Stormwind City,54.9,69.7
		.' Use your Fishing skill to fish in the water all around the wooden dock |cast Fishing##7620
		..get Baby Crocolisk##34864 |q 11665/1
		only if havequest(11665)
	step
		goto Stormwind City,49.0,87.4 |n
		.' Click the Swirling Portal to Blasted Lands |goto Blasted Lands
		only if havequest(11665)
	step
		goto Blasted Lands,55.0,53.9
		.' Go through the Dark Portal |goto Hellfire Peninsula |noway|c
		only if havequest(11665)
	step
		|fly Shattrath
		only if havequest(11665)
	step
		.' Go Northeast to Terokkar Forest |goto Terokkar Forest |noway|c
		only if havequest(11665)
	step
		goto Terokkar Forest,51.8,37.2
		.' Fish in the river here |cast Fishing##7620
		..get Blackfin Darter##34865 |q 11666/1
		only if havequest(11666)
	step
		|fly Telaar
		only if havequest(11667)
	step
		goto Nagrand,37.4,47.1
		.' Use your fishing ability to fish in the lake. |cast Fishing##7620
		..get World's Largest Mudfish##34868 |q 11667/1
		only if havequest(11667)
	step
		.' Go North to Zangarmarsh |goto Zangarmarsh
		only if havequest(11668)
	step
		goto Zangarmarsh,77.9,79.7
		.' Fish from the Lake here |cast Fishing##7620
		.'Click the Bloated Barbed Gill Trout in your bags|use Bloated Barbed Gill Trout##35313
		..get Giant Freshwater Shrimp##34866 |q 11668/1
		only if havequest(11668)
	step
		|fly Wildhammer Stronghold
		only if havequest(11669)
	step
		goto Shadowmoon Valley,18.9,22.2
		.' Use your fishing ability in the green lava. |cast Fishing##7620
		..get Monstrous Felblood Snapper |q 11669/1
		only if havequest(11669)
	step
		|fly Allerian Stronghold
		only if havequest(11669)
	step
		goto Terokkar Forest,38.7,12.8
		.talk Old Man Barlo##25580
		.' You will only be able to pick up 1 of 5 dailies per day.
		.turnin Crocolisks in the City##11665 |or |daily
		.turnin Bait Bandits##11666 |or |daily
		.turnin Felblood Fillet##11669 |or |daily
		.turnin The One That Got Away##11667 |or |daily
		.turnin Shrimpin' Ain't Easy##11668 |or |daily	
	step
		.' Crocolisks in the City |achieve 905/1
		.' Bait Bandits |achieve 905/2
		.' Felblood Fillet |achieve 905/3
		.' The One That Got Away |achieve 905/4
		.' Shrimpin' Ain't Easy |achieve 905/5
	step
		.' Earn the Old Man Barlowned Achievement. |achieve 905
	step
		'Congratulations! You've earned the Old Man Barlowned achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Outland_Angler",[[
	step
		.' In order to earn this achievement, you will need to fish from 6 different pools of fish in the Outlands.
		.' Click here to proceed. |confirm
	step
		.' Go to Stormwind |goto Stormwind City |noway |c
	step
		goto Stormwind City,49.0,87.4 |n
		.' Click the Swirling Portal to Blasted Lands |goto Blasted Lands
	step
		goto Blasted Lands,55.0,53.9
		.' Go through the Dark Portal |goto Hellfire Peninsula |noway|c
	step
		|fly Telredor
	step
		goto Zangarmarsh,72.5,59.9
		.' Use your fishing skill on Sporefish School's around Umberfen Lake |cast Fishing##7620
		.' Fish from a Sporefish School |achieve 1225/6
	step
		|fly Allerian Stronghold
	step
		goto Terokkar Forest,60.8,59.0 |n
		.' You will need to fly to reach the Highland Mixed Schools.  There are two more spots you can check for them below:
		.' The large Skettis Lake |goto 66.4,80.0 |n
		.' Lake Jorune |goto 45.9,39.5 |n
		.' Fish from a Highland Mixed School |achieve 1225/5
	step
		map Terokkar Forest
		path follow loose;loop off;ants straight // this stays until the end of the guide.
		path	 60.5,51.9	62.9,48.1	63.6,45.0
		path	 60.0,36.5
		.' Follow the stream until you find a School of Darfters or Brackish Mixed School in the river.
		.' Use your fishing skill to fish from either Brackish Mixed or School of Darters
		.' Fish from a School of Darters |achieve 1225/4
		.' Fish from a Brackish Mixed School |achieve 1225/1
	step
		|fly Telaar
	step
		map Nagrand
		path follow loose;loop off;ants straight // this stays until the end of the guide.
		path	 47.2,44.4	48.7,45.3	51.1,43.2
		path	 50.9,47.6	48.8,48.1	47.4,48.6
		path	 46.5,47.6
		.' Follow the stream until you find a Bluefish and a Mudfish School.
		.' Use your fishing  skill to fish from either Bluefish and a Mudfish School |cast Fishing##7620
		.' Fish from a Bluefish School |achieve 1225/2
		.' Fish from a Mudfish School |achieve 1225/3
	step
		.' Earn the Outland Angler Achievement. |achieve 1225
	step
		'Congratulations! You've earned the Outland Angler achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Northrend_Angler_Angler",[[
	step
		.' In order to earn this achievement, you will have to fish from 10 different schools of fish in Northrend.
		.' Click here to proceed. |confirm
	step
		.' Borean Man O'War School |achieve 1517/1
		.' Dragonfin Angelfish School |achieve 1517/2
		.' Glacial Salmon School |achieve 1517/3
		.' Imperial Manta Ray School |achieve 1517/4
		.' Musselback Sculpin School |achieve 1517/5
		.' Deep Sea Monsterbelly School |achieve 1517/6
		.' Fangtooth Herring School |achieve 1517/7
		.' Glassfin Minnow School |achieve 1517/8
		.' Moonglow Cuttlefish School |achieve 1517/9
		.' Neettlefish School |achieve 1517/10
		.' Click here to proceed. |confirm
	step
		goto Stormwind City,18.2,25.4 |n
		.' Ride the boat to Borean Tundra |goto Borean Tundra |noway|c
	step
		map Borean Tundra
		path follow loose;loop off;ants straight // this stays until the end of the guide.
		path	54.3,75.2	49.5,79.0	45.8,80.9
		path	43.4,78.5	40.3,77.0
		.' Follow the coast until you find and Imperial Manta Ray and a Borean Man O' War School.  You mayb need to fish out other schools in order to force new ones to spawn.
		.' Fish from an Imperial Manta Ray School |achieve 1517/4 |cast Fishing##7620
		.' Fish from a Borean Man O' War School |achieve 1517/1 |cast Fishing##7620
	step
		goto Borean Tundra,51.2,42.4
		.' You will be able to find Musselback Sculpin Schools around Lake Kum'uya.
		.' Fish from a Musselback Scuplin School |achieve 1517/5
	step
		goto Borean Tundra,82.7,59.5
		.' Around the Glacier, you will find Schools of Moonglow Cuttlefish and Deep Sea Monsterbelly.
		.' Fish from a Deep Sea Monsterbelly School |achieve 1517/6 |cast Fishing##7620
		.' Fish from a Moonglow Cuttlefish School |achieve 1517/9 |cast Fishing##7620
	step
		|fly River's Heart
	step
		goto Sholazar Basin,46.8,64.7
		.' All around River's Heart, you will find schools of Nettlefish.
		.' Fish from a Nettlefish School |achieve 1517/10 |cast Fishing##7620
	step
		|fly Moa'ki Harbor
	step
		goto Dragonblight,42.3,67.8
		.' You can find Dragonfin Angelfish School all along Lake Indu'le.
		.' Fish from a Dragonfin Angelfish School |achieve 1517/2 |cast Fishing##7620
	step
		|fly Windrunner's Overlook
	step
		goto Crystalsong Forest,49.0,54.1
		.' Along the Twilight Rivulet you will find schools of Glassfin Minnow.
		.' Fish from a Glassfin Minnow School |achieve 1517/8 |cast Fishing##7620
	step
		|fly Amberpine Lodge
	step
		map Grizzly Hills
		path follow loose;loop off;ants straight // this stays until the end of the guide.
		path	26.4,64.9	28.6,60.8	29.5,55.8
		.' You can find Schools of Glacial Salmon along this river.
		.' Fish from a Glacial Salmon School |achieve 1517/3 |cast Fishing##7620
	step
		map Howling Fjord
		path follow loose;loop off;ants straight // this stays until the end of the guide.
		path	59.5,58.8	60.8,60.3	60.6,64.5
		.' You can find Fangtooth Herring Schools along Daggercap Bay.
		.' Fish from a Fangtooth Herring School |achieve 1517/7 |cast Fishing##7620
	step
		.' Earn the Northrend Angler Achievement. |achieve 1517 |cast Fishing##7620
	step
		'Congratulations! You've earned the Northrend Angler achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Chasing_Marcia",[[
	daily
	step
		.' In order to earn this Achievement, you will have to complete 5 daily quests.
		.' You will only be able to accept one per day, so this may take longer than 5 days to achieve.
		.' Click here to proceed |confirm
	step
		'Below is a list of the 5 daily quests you will need to complete.
		.' The Ghostfish |achieve 3217/1
		.' Jewel Of The Sewers |achieve 3217/2
		.' Dangerously Delicious |achieve 3217/3
		.' Blood is Thicker |achieve 3217/4
		.' Disarmed! |achieve 3217/5
		.' Click to proceed |confirm
	step
		goto Dalaran,53.1,64.9
		.talk Marcia Chase##28742
		.' You will only be able to accept, and turn in, 1 of these 5 daily quests per day:
		..accept Blood Is Thicker##13833 |daily |or
		..accept Dangerously Delicious##13834 |daily |or
		..accept Jewel Of The Sewers##13832 |daily |or
		..accept Disarmed!##13836 |daily |or
		..accept The Ghostfish##13830 |daily |or
	step
		goto Borean Tundra,54.6,41.8
		.from Wooly Mammoth##24614, Mammoth Calf##24613, Wooly Mammoth Bull##25743
		.' Get the Animal Blood buff|havebuff Ability_Seal|q 13833
		only if havequest (13833)
	step
		goto 53.7,42.9
		.' Walk into the water here to create a pool of blood
		.' Fish in the pool of blood
		.get 5 Bloodtooth Frenzy |q 13833/1
		only if havequest (13833)
	step
		goto Wintergrasp,79.9,41.8
		.' Fish in this big lake
		.get 10 Terrorfish |q 13834/1
		only if havequest (13834)
	step
		'The entrance to the Dalaran sewers starts here|goto Dalaran,60.2,47.7,0.3|c|q 13832
		only if havequest (13832)
	step
		goto 44.4,66.2
		.' Fish in the water in the Dalaran sewers
		.get 1 Corroded Jewelry |q 13832/1
		only if havequest (13832)
	step
		'Leave the Dalaran sewers|goto Dalaran,60.2,47.7,0.3|c|q 13832
		only if havequest (13832)
	step
		goto Dalaran,64.8,60.8
		.' Stand on the this circular platform and fish in the water here
		.collect Bloated Slippery Eel##45328|n
		.' Click the Bloated Slippery Eel in your bags|use Bloated Slippery Eel##45328
		.get 1 Severed Arm |q 13836/1
		only if havequest (13836)
	step
		goto Sholazar Basin,49.3,61.8
		.' Fish in the water here
		.collect 1 Phantom Ghostfish##45902|n
		.' Click the Phantom Ghostfish in your bags to eat it|use Phantom Ghostfish##45902
		.' Discover the Ghostfish mystery|goal Discover the Ghostfish mystery |q 13830/1
		only if havequest (13830)
	step
		goto Dalaran,53.1,64.9
		.talk Marcia Chase##28742
		.' You will only be able to accept, and turn in, 1 of these 5 daily quests per day:
		..turnin Blood Is Thicker##13833
		..turnin Dangerously Delicious##13834
		..turnin Jewel Of The Sewers##13832
		..turnin The Ghostfish##13830
	step
		goto Dalaran,36.6,37.3
		.talk Olisarra the Kind##28706
		..turnin Disarmed!##13836
	step
		.' Earn the Chasing Marcia Achievement. |achieve 3217
	step
		'Congratulations! You've earned the Chasing Marcia achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Fish_Don't_Leave_Footprints",[[
	step
		.' Go to Stormwind City. |goto Stormwind City |noway|c
	step
		|fly Rebel Camp
	step
		goto Northern Stranglethorn,31.0,37.7
		.' Use your fishing skill fish from Schooner Wreckage along The Savage Coast.  You may need to fish out the other schools of fish to get them to spawn. |cast Fishing##7620
		.collect Weather-Beaten Journal##34109
		.' Use the Weather-Beaten Journal. |use Weather-Beaten Jounral##34109
		.' Earn the Fish Don't Leave Footprints achievement. |achieve 1243
	step
		.' Congratulations, you have earned the Fish Don't Leave Footprints achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_The_Coin_Master",[[
	step
		.' This guide will help you earn the achievements A Penny For Your Thoughts, Silver in the City, There's Gold In That There Fountain, and finally, The Coin Master.
		.' Click here to proceed. |confirm
	step
		.' Here is your current progression on The Coin Master.
		.' A Penny For Your Thoughts. |achieve 2096/1
		.' Silver in the City. |achieve 2096/2
		.' There's a Gold In That There Fountain. |achieve 2096/3
		.' Click here to proceed. |confirm
	step
		#include rideto_borean
	step
		|fly Dalaran
	step
		goto Dalaran,52.6,66.5
		.' This fountain is where you will be fishing from to earn these achievements. Use your fishing skills to fish up Copper, Silver and Gold Coins. |cast Fishing##7620
		.' Earn the A penny For Your Thoughts achievement. |achieve 2096/1
		.' Earn the Silver in the City achievement. |achieve 2096/2
		.' Earn the There's Gold In That There Fountain achievement. |achieve 2096/3
		.' This achievement takes a lot of time, so try to be patient.
	step
		.' Earn the A penny For Your Thoughts Achiement. |achieve 2094
		.' Earn the Silver in the City achievement. |achieve 2095
		.' Earn the There's Gold In That There Fountain achievement. |achieve 1957
		.' Earn The Coin Master achievement. |achieve 2096
	step
		.' Congratulation, you have earned The Coin Master achievement!
]])
ZygorGuidesViewer:RegisterInclude("A_Master_Angler_of_Azeroth",[[
	step
		'To earn this Achievement, you need to go to Booty Bay, accept this quest and be the first to complete it.
		.' You can start this quest every _Sunday_ from _2pm to 4pm SERVER TIME_. 
		|confirm
	step
		goto Stormwind City,55.0,69.7
		.talk Catherine Leland##5494
		.buy 1 Fishing Pole##6256
		.buy 10 Shiny Bauble##6529
		.' Or
		|confirm
	step
		|fly Booty Bay
	step
		goto The Cape of Stranglethorn,41.7,73.0
		.talk Riggle Bassbait##15077
		..accept Master Angler##8193
	step
		goto The Cape of Stranglethorn,39.1,57.9
		.' Make sure you have you're fishing pole equipped and fish in these area's for Tasty Fish |use Fishing Pole##6256
		.' Attach your Shiny Bauble to your fishing pole to increase your fishing skill slightly |use Shiny Bauble##6529
		.get 40 Speckled Tastyfish##19807 |q 8193
		.' You can find more schools of fish here: [37.9,55.6]
		.' Here [36.3,53.8]
		.' Here [36.1,50.9]
		.' And here [36.2,47.7]
	step
		goto The Cape of Stranglethorn,41.7,73.0
		.talk Riggle Bassbait##15077
		..turnin Master Angler##8193
		.' Be the first to turn in this quest to earn achievement
		.' Earn Master Angler Achievement |achieve 306
]])
ZygorGuidesViewer:RegisterInclude("A_Master_Angler_of_Northrend",[[
	step
		'To earn this Achievement, you need to go to Northrend, catch a _Blacktip Shark_ and be the first to turn it in.
		.' You can start fishing every _Saturday_ at _2pm SERVER TIME_, you will hear the NPC yell out that the 
		.' contest has started, make sure you are next to a school of fish, and start fishing!
		|confirm
	step
		goto Stormwind City,55.0,69.7
		.talk Catherine Leland##5494
		.buy 1 Fishing Pole##6256
		.buy 10 Shiny Bauble##6529
		.' Or
		|confirm
	step
		#include "rideto_borean"
	step
		|fly Dalaran
	step
		goto Dalaran,44.7,63.3
		.talk Isirami Fairwind##32413
		.home
	step
		goto Dalaran,52.4,65.2
		.talk Elder Clearwater##38294
		.turnin Kalu'ak Fishing Derby##24803
	step
		goto Dalaran,56.0,46.8
		.click Teleport to Violet Stand Crystal##8070
		.' Teleport to the Violet Stand |goto Crystalsong Forest |noway |c
	step
		map Crystalsong Forest
		path follow loose;loop off;ants straight
		path	22.5,35.4
		path	25.2,43.4	29.6,45.2	34.0,47.9
		path	38.7,54.4	44.8,56.7	50.3,56.4
		.' Follow this path and turn your _Track Fishing_ on.
		.' Fish up a _Blacktip Shark_ from any school of fish.|use Fishing Pole##6256
		.' Attach your Shiny Bauble to your fishing pole to increase your fishing skill slightly |use Shiny Bauble##6529
		.collect Blacktip Shark##50289
	step
		.' Hearth to Dalaran |goto Dalaran |use Hearthstone##6948 |noway |c 
		.' Or
		goto Crystalsong Forest,15.7,42.4
		.click Teleport to Dalaran Crystal##8070
		.' Teleport to Dalaran |goto Dalaran |noway |c 
	step
		goto Dalaran,52.4,65.2
		.talk Elder Clearwater##38294
		.turnin Kalu'ak Fishing Derby##24803
		.' If you are the first to turn in this quest you will get an achievement
		.' Earn the Achievement Master Angler of Azeroth |achieve 306
]])


-----------------------------------------------------------------------------------------
-- Dailies
-----------------------------------------------------------------------------------------

ZygorGuidesViewer:RegisterInclude("A_SSO_PreQuest_Dailies",[[
	daily
	step
		|fly Shattrath
	step
		goto Shattrath City,49.1,42.5
		.talk Exarch Nasuun##24932
		..accept Maintaining the Sunwell Portal##11514 |daily
	step
		goto 62.8,36.0
		.talk Lord Torvos##25140
		..accept Sunfury Attack Plans##11877 |daily
	step
		goto 62.8,35.6
		.talk Emissary Mordin##19202
		..accept Gaining the Advantage##11875 |daily
		only if skill("Skinning")>300 or skill("Mining")>300 or skill("Herbalism")>300
	step
		goto Shattrath City,61.7,52.1
		.talk Harbinger Haronem##19475
		..accept The Multiphase Survey##11880 |daily
	step
		|fly Telaar
	step
		goto Nagrand,58.8,75.1
		.from Clefthoof Bull##17132+,Talbuk Thorngrazer##17131+,Wild Elekk##18334+
		.' Skin their corpses in order to collect the Nether Residue.
		.get 8 Nether Residue##35229 |q 11875/1
		only if skill("Skinning")>=300
	step
		goto 40.8,31.6
		.' Mine inside the cave and collect Nether Residue.
		.collect 8 Nether Residue##35229 |q 11875/1
		.' You can check [Nagrand,50.0,56.6] for more Mining Nodes.
		only if skill("Mining")>=300
	step
		goto Nagrand,38.3,65.3
		.' Fly around the Spirit Fields looking for Fiery Red Orbs on the ground.
		.' Use your Multiphase Spectrographic Goggles on the Orbs. |use Multiphase Spectrographic Goggles##35233
		..goal 6 Multiphase Readings Taken |q 11880/1
	step
		|fly Evergrove
	step
		goto Blade's Edge Mountains,54.0,18.1
		.from Unbound Ethereal##22244+,Bash'ir Raider##22241+,Bash'ir Arcanist##22243+,Bash'ir Spell-Thief##22242+
		.get 1 Bash'ir Phasing Device |q 11514
		'Use the Bash'ir Phasing Device. |use Bash'ir Phasing Device##34248
		.' Collect 10 Smuggled Mana Cell |q 11514/1
	step
		|fly Area 52
	step
		goto Netherstorm,25.9,66.8
		.from Sunfury Bloodwarder##18853+,Sunfury Captain##19453+,Sunfury Magister##18855+,Sunfury Geologist##19779+,Sunfury Astromancer##19643
		.get Sunfury Attack Plans |q 11877/1
	step
		|fly Shattrath
	step
		goto Shattrath City,62.8,36.0
		.talk Lord Torvos##25140
		.turnin Sunfury Attack Plans##11877 |daily
	step
		goto 62.8,35.6
		.talk Emissary Mordin##19202 
		.turnin Gaining the Advantage##11875 |daily
	step
		goto 61.6,52.2
		.talk Harbinger Haronem##19475
		.turnin The Multiphas Survey##11880 |daily
	step
		goto 49.1,42.5
		.talk Exarch Nasuun##24932 |daily
		.turnin Maintaining the Sunwell Portal##11514 |daily
	step
		goto Shattrath City,48.6,42.0 |n
		.' Click the Shattrath Portal to Isle of Quel'Danas. |goto Isle of Quel'Danas
	step
		goto Isle of Quel'Danas,47.5,35.4
		.talk Astromancer Darnarian##25133
		..accept Know Your Ley Lines##11547 |daily
	step
		goto 47.5,35.1
		.talk Battlemage Arynna##25057
		..accept The Air Strikes Must Continue##11533 |daily
	step
		goto 47.6,35.1
		.talk Harbinger Inuuro##25061
		..accept The Battle Must Go On##11537 |daily
	step
		goto 48.8,37.2
		.talk Anchorite Ayuri##25112
		..accept Your Continued Support##11548 |daily
		.' This quest requires that you give 10 Gold in trade of reputation with the Shattered Sun Offensive, you should be able to turn it in immidiately.
		..turnin Your Continued Support##11548 |daily
	step
		goto 50.6,39.0
		.talk Vindicator Kaalan##25108
		..accept Keeping the Enemy at Bay##11543 |daily
	step
		goto 49.3,40.4
		.talk Magister Ilastar##25069
		..accept Crush the Dawnblade##11540 |daily
	step
		goto 50.6,40.8
		.talk Smith Hauthaa##25046
		..accept Don't Stop Now....##11536 |daily
		..accept Ata'mal Armaments##11544 |daily
	step
		goto 51.5,32.5
		.talk Mar'nah##24975
		..accept Rediscovering Your Roots##11521 |daily
		..accept Open for Business##11546 |daily
	step
		goto 53.8,34.3
		.talk Captain Valindria##25088
		..accept Disrupt the Greengill Coast##11541 |daily
	step
		goto 47.5,30.5
		.talk Captain Theris Dawnhearth##24967
		..accept Arm the Wards!##11523 |daily
		..accept The Missing Magistrix##11526
	step
		goto 47.1,30.7
		.talk Vindicator Xayann##24965
		..accept Further Conversions##11525 |daily
	step
		goto Isle of Quel'Danas,44.3,28.5
		.from Wretched Fiend##24966+
		.collect 4 Mana Remnants##34338 |q 11523 |c
		.kill Erratic Sentry##24972+ |n
		.' Use Attuned Crystal Cores on the Erratic Sentries corpse. |use Attuned Crystal Cores##34368
		..goal 5 Converted Sentry Deployed |q 11525/1
		..collect 5 Bloodberry |q 11546/1 |tip They can be found all around this area on the ground.
	step
		goto Isle of Quel'Danas,42.1,35.7
		.kill 6 Dawnblade Summoner |q 11540/1
		.kill 6 Dawnblade Blood Knight |q 11540/2
		.kill 3 Dawnblade Marksman |q 11540/3
		.' Use your Astromancer's Crystal to sample the Bloodcrystal's density. |use Astromancer's Crystal##34533
		.' Bloodcrystal Reading Taken |q 11547/3
	step
		goto Isle of Quel'Danas,46.5,35.5
		.' Use the Mana Remnants to Energize the Crystal Ward. |use Mana Remnants##34338
		.' Energize a Crystal Ward |q 11523/1
	step
		goto 48.5,25.2
		.talk Ayren Cloudbreaker##25059
		.' Tell him you Need to Intercept the Dawnblade Reinforcements.
		.' Use your Flaming Oil to set fire to the ships in the water. |use Flaming Oil##34489
		.' Sin'loren sails burned |q 11543/1
		.' Bloodoath sails burned |q 11543/2
		.' Dawnchaser sails burned |q 11543/3
	step
		.kill Dawnblade Reservist##25087+ |q 11543/4
		.' You can find more at [Isle of Quel'Danas,51.1,9.7]
		.' Another spot for them is at [Isle of Quel'Danas,55.2,11.8]
	step
		goto Isle of Quel'Danas,52.4,17.4
		.talk Unrestrained Dragonhawk##25236
		.' Ride the dragonhawk to Sun's Reach. |goto Isle of Quel'Danas,48.4,25.3 |noway|c
	step
		goto Isle of Quel'Danas,48.5,25.2
		.talk Ayren Cloudbreaker##25059
		.' Tell him you've been ordered to undertake an airstrike.
		.' Use your Arcane Charges on mobs once you get to the Dead Scar. |use Arcane Charges##34475
		.kill 2 Pit Overlord##25031+ |q 11533/1
		.kill 3 Eredar Sorcerer##25033+ |q 11533/2
		.kill 12 Wrath Enforcer##25030+ |q 11533/3
	step
		goto Isle of Quel'Danas,48.5,43.7
		.kill Emissary of Hate##25003 |n
		.' Use your Shattered Sun Banner on his corpse. |use Shattered Sun Banner##34414
		.' Impale the Emissary of Hate |q 11537/1
		.kill 6 Burning Legion Demon |q 11537/2
		.' Use your Astromancer's Crystal to sample the Portal's density. |use Astromancer's Crystal##34533
		.' Portal Reading Taken |q 11547/1
	step
		.' Take this path back to they shoreside. |goto Isle of Quel'Danas,57.3,38.6 |c
	step
		goto Isle of Quel'Danas,64.1,49.9
		.from Darkspine Myrmidon##25060+
		..collect Darkspine Chest Key##34477 |n
		.from Darkspine Siren##25073+
		..collect Orb of Murloc Control##34483 |n
		.' Use your Orbs of Murloc Control on Greengill Slaves along the shore. |use Orb of Murloc Control##34483
		.' Free 10 Greengill Slaves |q 11541/1
		.' Use your Darkspine Chest Keys on the Darkspine Ore Chest.
		.get 3 Darkspine Iron Ore |q 11536/1
	step
		goto Isle of Quel'Danas,61.1,62.0
		.' Use your Astromancer's Crystal to sample the Shrine's density. |use Astromancer's Crystal##34533
		.' Shrine Reading Taken |q 11547/2
	step
		goto Isle of Quel'Danas,53.8,34.3
		.talk Captain Valindria##25088
		..turnin Disrupt the Greengill Coast##11541 |daily
	step
		goto 50.6,40.7
		.talk Smith Hauthaa##25046
		..turnin Don't Stop Now....##11536 |daily
	step
		goto 50.6,39.0
		.talk Vindicator Kaalan##25108
		..turnin Keeping the Enemy at Bay##11543 |daily
	step
		goto 49.3,40.4
		.talk Magister Ilastar##25069
		..turnin Crush the Dawnblade##11540 |daily
	step
		goto 51.5,32.5
		.talk Mar'nah##24975
		..turnin Open for Business##11546 |daily
	step
		goto 47.5,35.3
		.talk Astromancer Darnarian##25133
		.turnin Know Your Ley Lines##11547 |daily
	step
		goto 47.5,35.1
		.talk Battlemage Arynna##25057
		.turnin The Air Strikes Must Continue##11533 |daily
	step
		goto 47.6,35.1
		.talk Harbinger Inuuro##25061
		.turnin The Battle Must Go On##11537 |daily
	step
		goto 47.5,30.5
		.talk Captain Theris Dawnhearth##24967
		.turnin Arm the Wards!##11523 |daily
	step
		goto 47.1,30.7
		.talk Vindicator Xayann##24965
		.turnin Further Conversions##11525 |daily
	step
		goto Isle of Quel'Danas,48.5,44.7
		|use Captured Legion Scroll##34420
		.' Teleport to Hellfire Peninsula |goto Hellfire Peninsula,58.6,18.7,0.5 |noway|c
	step
		goto Hellfire Peninsula,58.2,17.6
		.talk Magistrix Seyla##24937
		.turnin The Missing Magistrix##11526
		..accept Blood for Blood##11515 |daily
		..accept Blast the Gateway##11516 |daily
	step
		goto Hellfire Peninsula,66.4,20.1
		.from Wrath Herald##24919+
		.collect 4 Demonic Blood##34259 
		.' use the Sizzling Embers to summon a Living Flare. |use Sizzling Embers##34253
		.kill Incandescent Fel Spark##22323+ |n
		.' Once you see a message that says "Living Flare becomes unstable with brimming energy!" take it to [Hellfire Peninsula,58.6,18.7].
		.' Legion Gateway Destroyed |q 11516/1
	step
		goto 59.9,21.0
		.' Use your Fel Siphon on Felblood Initiates. |use Fel Siphon##34257
		.kill 4 Emaciated Felblood##24918 |q 11515/1
	step
		goto Hellfire Peninsula,58.2,17.6
		.talk Magistrix Seyla##24937
		.turnin Blast the Gateway##11516 |daily
		.turnin Blood for Blood##11515 |daily
	step
		goto Terokkar Forest,59.7,10.3
		.from Razorthorn Flayer##24920+
		..collect Razorthorn Flayer Gland##34255 |q 11521
		.' Use your Razorthorn Flayer Gland on Razorthorn Ravagers. |use Razorthorn Flayer Gland##34255
		.' Use your pets Expose Razorthorn Root ability on mounds of dirt around the area. |cast Expose Razorthorn Root##44935
		.collect 5 Razorthorn Root##34254 |q 11521/1
	step
		|fly Altar of Sha'tar
		only if rep ("The Aldor")>=Neutral
	step
		|fly Sanctum of the Stars
		only if rep ("The Scryers")>=Neutral
	step
		 goto Shadowmoon Valley,68.5,37.5
		.from Shadowmoon Chosen##22084+,Shadowmoon Slayer##22082+,Shadowmoon Darkweaver##22081+
		.collect 5 Ata'mal Armament##34500 |q 11544
	step
		|fly Shattrath
	step
		goto Shattrath City,48.6,42.0 |n
		.' Click the Shattrath Portal to Isle of Qual'Danas. |goto Isle of Quel'Danas |noway|c
	step
		goto Isle of Quel'Danas,51.5,32.5
		.talk Mar'nah##24975
		.turnin Rediscovering Your Roots##11521 |daily
	step
		goto 50.6,40.7
		.' Click the Ata'mal Armaments and cleanse them at Hauthaa's Anvil. |use Ata'mal Armament##34500
		.' Cleanse 5 Ata'mal Metals |q 11544/1
	step
		goto 50.6,40.7
		.talk Smith Hauthaa##25046
		..turnin Ata'mal Armaments##11544 |daily
]])
ZygorGuidesViewer:RegisterInclude("A_SSO_Dailies",[[
	daily
	step
		|fly Shattrath
	step
		goto Shattrath City,56.3,81.5
		.talk Innkeeper Haelthol##19232
		.home
		only if rep ("The Scryers")>=Neutral
	step
		goto Shattrath City,28.2,49.4
		.talk Minalei##19046
		.home
		only if rep ("The Aldor")>=Neutral
	step
		goto Shattrath City,49.1,42.5
		.talk Exarch Nasuun##24932
		..accept Maintaining the Sunwell Portal##11514 |daily
	step
		goto 62.8,36.0
		.talk Lord Torvos##25140
		..accept Sunfury Attack Plans##11877 |daily
	step
		goto 62.8,35.6
		.talk Emissary Mordin##19202
		..accept Gaining the Advantage##11875 |daily
		only if skill("Skinning")>300 or skill("Mining")>300 or skill("Herbalism")>300
	step
		goto Shattrath City,61.7,52.1
		.talk Harbinger Haronem##19475
		..accept The Multiphase Survey##11880 |daily
	step
		goto Shattrath City,48.6,42.0 |n
		.' Click the Shattrath Portal to Isle of Quel'Danas. |goto Isle of Quel'Danas
	step
		goto Isle of Quel'Danas,47.5,35.4
		.talk Astromancer Darnarian##25133
		..accept Know Your Ley Lines##11547 |daily
	step
		goto 47.5,35.1
		.talk Battlemage Arynna##25057
		..accept The Air Strikes Must Continue##11533 |daily
	step
		goto 47.6,35.1
		.talk Harbinger Inuuro##25061
		..accept The Battle Must Go On##11537 |daily
	step
		goto 48.8,37.2
		.talk Anchorite Ayuri##25112
		..accept Your Continued Support##11548 |daily
		.' This quest requires that you give 10 Gold in trade of reputation with the Shattered Sun Offensive, you should be able to turn it in immidiately.
		..turnin Your Continued Support##11548 |daily
	step
		goto 50.6,39.0
		.talk Vindicator Kaalan##25108
		..accept Keeping the Enemy at Bay##11543 |daily
	step
		oto 49.3,40.4
		.talk Magister Ilastar##25069
		..accept Crush the Dawnblade##11540 |daily
	step
		goto 50.6,40.8
		.talk Smith Hauthaa##25046
		..accept Don't Stop Now....##11536 |daily
		..accept Ata'mal Armaments##11544 |daily
	step
		goto 51.5,32.5
		.talk Mar'nah##24975
		..accept Rediscovering Your Roots##11521 |daily
		..accept Open for Business##11546 |daily
	step
		goto 53.8,34.3
		.talk Captain Valindria##25088
		..accept Disrupt the Greengill Coast##11541 |daily
	step
		goto 47.5,30.5
		.talk Captain Theris Dawnhearth##24967
		..accept Arm the Wards!##11523 |daily
		..accept The Missing Magistrix##11526
	step
		goto 47.1,30.7
		.talk Vindicator Xayann##24965
		..accept Further Conversions##11525 |daily
	step
		goto Isle of Quel'Danas,44.3,28.5
		.from Wretched Fiend##24966+
		.collect 4 Mana Remnants##34338 |q 11523 |c
		.kill Erratic Sentry##24972+ |n
		.' Use Attuned Crystal Cores on the Erratic Sentries corpse. |use Attuned Crystal Cores##34368
		..goal 5 Converted Sentry Deployed |q 11525/1
		..collect 5 Bloodberry |q 11546/1 |tip They can be found all around this area on the ground.
	step
		goto Isle of Quel'Danas,42.1,35.7
		.kill 6 Dawnblade Summoner |q 11540/1
		.kill 6 Dawnblade Blood Knight |q 11540/2
		.kill 3 Dawnblade Marksman |q 11540/3
		.' Use your Astromancer's Crystal to sample the Bloodcrystal's density. |use Astromancer's Crystal##34533
		.' Bloodcrystal Reading Taken |q 11547/3
	step
		goto Isle of Quel'Danas,46.5,35.5
		.' Use the Mana Remnants to Energize the Crystal Ward. |use Mana Remnants##34338
		.' Energize a Crystal Ward |q 11523/1
	step
		goto 48.5,25.2
		.talk Ayren Cloudbreaker##25059
		.' Tell him you Need to Intercept the Dawnblade Reinforcements.
		.' Use your Flaming Oil to set fire to the ships in the water. |use Flaming Oil##34489
		.' Sin'loren sails burned |q 11543/1
		.' Bloodoath sails burned |q 11543/2
		.' Dawnchaser sails burned |q 11543/3
	step
		.kill Dawnblade Reservist##25087+ |q 11543/4
		.' You can find more at [Isle of Quel'Danas,51.1,9.7]
		.' Another spot for them is at [Isle of Quel'Danas,55.2,11.8]
	step
		goto Isle of Quel'Danas,52.4,17.4
		.talk Unrestrained Dragonhawk##25236
		.' Ride the dragonhawk to Sun's Reach. |goto Isle of Quel'Danas,48.4,25.3 |noway|c
	step
		goto Isle of Quel'Danas,48.5,25.2
		.talk Ayren Cloudbreaker##25059
		.' Tell him you've been ordered to undertake an airstrike.
		.' Use your Arcane Charges on mobs once you get to the Dead Scar. |use Arcane Charges##34475
		.kill 2 Pit Overlord##25031+ |q 11533/1
		.kill 3 Eredar Sorcerer##25033+ |q 11533/2
		.kill 12 Wrath Enforcer##25030+ |q 11533/3
	step
		goto Isle of Quel'Danas,48.5,43.7
		.kill Emissary of Hate##25003 |n
		.' Use your Shattered Sun Banner on his corpse. |use Shattered Sun Banner##34414
		.' Impale the Emissary of Hate |q 11537/1
		.kill 6 Burning Legion Demon |q 11537/2
		.' Use your Astromancer's Crystal to sample the Portal's density. |use Astromancer's Crystal##34533
		.' Portal Reading Taken |q 11547/1
	step
		.' Take this path back to they shoreside. |goto Isle of Quel'Danas,57.3,38.6 |c
	step
		goto Isle of Quel'Danas,64.1,49.9
		.from Darkspine Myrmidon##25060+
		..collect Darkspine Chest Key##34477 |n
		.from Darkspine Siren##25073+
		..collect Orb of Murloc Control##34483 |n
		.' Use your Orbs of Murloc Control on Greengill Slaves along the shore. |use Orb of Murloc Control##34483
		.' Free 10 Greengill Slaves |q 11541/1
		.' Use your Darkspine Chest Keys on the Darkspine Ore Chest.
		.get 3 Darkspine Iron Ore |q 11536/1
	step
		goto Isle of Quel'Danas,61.1,62.0
		.' Use your Astromancer's Crystal to sample the Shrine's density. |use Astromancer's Crystal##34533
		.' Shrine Reading Taken |q 11547/2
	step
		'Hearth to the Scryer's Tier Inn |goto Shattrath City,56.3,81.5,0.5 |use Hearthstone##6948 |noway|c
		only if rep("The Scryers")>=Neutral
	step
		'Hearth to the Aldor Rise Inn |goto Shattrath City,28.2,49.4,0.5 |use Hearthstone##6948 |noway|c
		only if rep ("The Aldor")>=Neutral
	step
		|fly Altar of Sha'tar
		only if rep ("The Aldor")>=Neutral
	step
		|fly Sanctum of the Stars
		only if rep ("The Scryers")>=Neutral
	step
		 goto Shadowmoon Valley,68.5,37.5
		.from Shadowmoon Chosen##22084+,Shadowmoon Slayer##22082+,Shadowmoon Darkweaver##22081+
		.collect 5 Ata'mal Armament##34500 |q 11544
	step
		|fly Allerian Stronghold
	step
		goto Terokkar Forest,59.7,10.3
		.from Razorthorn Flayer##24920+
		..collect Razorthorn Flayer Gland##34255 |q 11521
		.' Use your Razorthorn Flayer Gland on Razorthorn Ravagers. |use Razorthorn Flayer Gland##34255
		.' Use your pets Expose Razorthorn Root ability on mounds of dirt around the area. |cast Expose Razorthorn Root##44935
		.collect 5 Razorthorn Root##34254 |q 11521/1
	step
		|fly Telaar
	step
		goto Nagrand,58.8,75.1
		.from Clefthoof Bull##17132+,Talbuk Thorngrazer##17131+,Wild Elekk##18334+
		.' Skin their corpses in order to collect the Nether Residue.
		.get 8 Nether Residue##35229 |q 11875/1
		only if skill("Skinning")>=300
	step
		goto 40.8,31.6
		.' Mine inside the cave and collect Nether Residue.
		.collect 8 Nether Residue##35229 |q 11875/1
		.' You can check [Nagrand,50.0,56.6] for more Mining Nodes.
		only if skill("Mining")>=300
	step
		goto Nagrand,38.3,65.3
		.' Fly around the Spirit Fields looking for Fiery Red Orbs on the ground.
		.' Use your Multiphase Spectrographic Goggles on the Orbs. |use Multiphase Spectrographic Goggles##35233
		..goal 6 Multiphase Readings Taken |q 11880/1
	step
		|fly Evergrove
	step
		goto Blade's Edge Mountains,54.0,18.1
		.from Unbound Ethereal##22244+,Bash'ir Raider##22241+,Bash'ir Arcanist##22243+,Bash'ir Spell-Thief##22242+
		.get 1 Bash'ir Phasing Device |q 11514
		'Use the Bash'ir Phasing Device. |use Bash'ir Phasing Device##34248
		.' Collect 10 Smuggled Mana Cell |q 11514/1
	step
		|fly Area 52
	step
		goto Netherstorm,25.9,66.8
		.from Sunfury Bloodwarder##18853+,Sunfury Captain##19453+,Sunfury Magister##18855+,Sunfury Geologist##19779+,Sunfury Astromancer##19643
		.get Sunfury Attack Plans |q 11877/1
	step
		|fly Honor Hold
		.' You can fly through the Twisting Nether to [Hellfire Peninsula,58.2,17.6], but you risk a possible death in doing so.
		.' If you choose to fly on your own, click here to proceed. |confirm
	step
		goto Hellfire Peninsula,58.2,17.6
		.talk Magistrix Seyla##24937
		..accept Blood for Blood##11515 |daily
		..accept Blast the Gateway##11516 |daily
	step
		goto Hellfire Peninsula,66.4,20.1
		.from Wrath Herald##24919+
		.collect 4 Demonic Blood##34259 
		.' use the Sizzling Embers to summon a Living Flare. |use Sizzling Embers##34253
		.kill Incandescent Fel Spark##22323+ |n
		.' Once you see a message that says "Living Flare becomes unstable with brimming energy!" take it to [Hellfire Peninsula,58.6,18.7].
		.' Legion Gateway Destroyed |q 11516/1
	step
		goto 59.9,21.0
		.' Use your Fel Siphon on Felblood Initiates. |use Fel Siphon##34257
		.kill 4 Emaciated Felblood##24918 |q 11515/1
	step
		goto Hellfire Peninsula,58.2,17.6
		.talk Magistrix Seyla##24937
		.turnin Blast the Gateway##11516 |daily
		.turnin Blood for Blood##11515 |daily
	step
		|fly Shattrath
	step
		goto Shattrath City,62.8,36.0
		.talk Lord Torvos##25140
		.turnin Sunfury Attack Plans##11877 |daily
	step
		goto 62.8,35.6
		.talk Emissary Mordin##19202 
		.turnin Gaining the Advantage##11875 |daily
	step
		goto 61.6,52.2
		.talk Harbinger Haronem##19475
		.turnin The Multiphas Survey##11880 |daily
	step
		goto 49.1,42.5
		.talk Exarch Nasuun##24932 |daily
		.turnin Maintaining the Sunwell Portal##11514 |daily
	step
		goto Shattrath City,48.6,42.0 |n
		.' Click the Shattrath Portal to Isle of Qual'Danas. |goto Isle of Quel'Danas |noway|c
	step
		goto Isle of Quel'Danas,53.8,34.3
		.talk Captain Valindria##25088
		..turnin Disrupt the Greengill Coast##11541 |daily
	step
		goto 50.6,40.7
		.' Click the Ata'mal Armaments and cleanse them at Hauthaa's Anvil. |use Ata'mal Armament##34500
		.' Cleanse 5 Ata'mal Metals |q 11544/1
	step
		goto 50.6,40.7
		.talk Smith Hauthaa##25046
		..turnin Don't Stop Now....##11536 |daily
		..turnin Ata'mal Armaments##11544 |daily
	step
		goto 50.6,39.0
		.talk Vindicator Kaalan##25108
		..turnin Keeping the Enemy at Bay##11543 |daily
	step
		goto 49.3,40.4
		.talk Magister Ilastar##25069
		..turnin Crush the Dawnblade##11540 |daily
	step
		goto 51.5,32.5
		.talk Mar'nah##24975
		..turnin Open for Business##11546 |daily
		.turnin Rediscovering Your Roots##11521 |daily
	step
		goto 47.5,35.3
		.talk Astromancer Darnarian##25133
		.turnin Know Your Ley Lines##11547 |daily
	step
		goto 47.5,35.1
		.talk Battlemage Arynna##25057
		.turnin The Air Strikes Must Continue##11533 |daily
	step
		goto 47.6,35.1
		.talk Harbinger Inuuro##25061
		.turnin The Battle Must Go On##11537 |daily
	step
		goto 47.5,30.5
		.talk Captain Theris Dawnhearth##24967
		.turnin Arm the Wards!##11523 |daily
	step
		goto 47.1,30.7
		.talk Vindicator Xayann##24965
		.turnin Further Conversions##11525 |daily
	step
		goto Isle of Quel'Danas,47.3,30.7
		.talk Eldara Dawnrunner##25032
		..accept A Friend in the Frontlines##11554 |instant
		only if rep ("Shattered Sun Offensive")==Friendly
	step
		goto Isle of Quel'Danas,47.3,30.7
		.talk Eldara Dawnrunner##25032
		..accept Honored By Your Allies##11555 |instant
		only if rep ("Shattered Sun Offensive")==Honored
	step
		goto Isle of Quel'Danas,47.3,30.7
		.talk Eldara Dawnrunner##25032
		..accept Revered in the Field of Battle##11556 |instant
		only if rep ("Shattered Sun Offensive")==Revered
	step
		goto Isle of Quel'Danas,47.3,30.7
		.talk Eldara Dawnrunner##25032
		..accept Exalted Among All Combatants##11557 |instant
		only if rep ("Shattered Sun Offensive")==Exalted
	step
		goto Isle of Quel'Danas,51.2,33.1
		.talk Anchorite Kairthos##25163
		..accept A Magnanimous Benefactor##11549 |tip This quest will cost you 1,000 Gold, but give you the title "Of the Shattered Sun".
		only if rep ("Shattered Sun Offensive")==Exalted
	step
		goto Isle of Quel'Danas,51.2,33.1
		.talk Anchorite Kairthos##25163
		.' _WARNING_, by turning in this quest, you will spend _1000 gold!_
		..turnin A Magnanimous Benefactor##11549
		only if rep ("Shattered Sun Offensive")==Exalted
	step
		'Congratulations, you have earned the title _of the Shattered Sun_!
		only if rep ("Shattered Sun Offensive")==Exalted
]])

ZygorGuidesViewer:RegisterInclude("A_Therazane_PreQuest", [[
		goto Stormwind City,62.9,71.6
		.' Click the Hero's Call Board |tip It's a big white stone hanging board with a gold lion head on it.
		..accept Hero's Call: Deepholm!##27727
	step
		goto 74.5,19.0
		.talk Naraat the Earthspeaker##45226
		..turnin Hero's Call: Deepholm!##27727
		..accept The Maelstrom##27203
	step
		goto 74.5,18.4
		.' Click the Portal to the Maelstrom |tip It looks like a swirling green portal.
		.' Teleport to The Maelstrom |goto The Maelstrom |noway |c
	step
		goto The Maelstrom,33.4,50.2
		.talk Thrall##45042
		..turnin The Maelstrom##27203
		..accept Deepholm, Realm of Earth##27123
	step
		goto 32.5,52.0
		.' Click the Wyvern |tip It looks like a wind rider flying in place.
		.' You will fly into Deepholm |goto Deepholm,49.9,54.7,0.5 |noway |c
	step
		goto Deepholm,49.6,53.0
		.talk Maruut Stonebinder##43065
		..turnin Deepholm, Realm of Earth##27123
		..accept Gunship Down##26245
	step
		goto 49.7,52.9
		.talk Seer Kormo##43397
		..accept Elemental Energy##27136
		..accept The Earth Claims All##26244
	step
		goto 49.5,53.3
		.talk Earthcaller Yevaa##42573
		..accept Where's Goldmine?##26409
	step
		goto 49.2,51.9
		.talk Caretaker Nuunwa##45300
		.home Temple of Earth
	step
		goto 46.5,57.3
		.talk Initiate Goldmine##42574
		..turnin Where's Goldmine?##26409
		..accept Explosive Bonding Compound##26410
		..accept Something that Burns##27135
	step
		goto 45.5,57.9
		.from Rockslice Flayer##42606+
		.get 5 Quartzite Resin |q 26410/1
		.' You can find more Rockslice Flayers around [42.5,55.6]
	step
		goto 46.5,57.3
		.talk Initiate Goldmine##42574
		..turnin Explosive Bonding Compound##26410
	step
		goto 51.1,61.6
		.' Use your Depleted Totem |use Depleted Totem##60835
		.from Lodestone Elemental##43258+, Energized Geode##43254+ |tip Kill them next to your Depleted Totems.
		.' Energize the Totem 8 Times |q 27136/1
	step
		goto 52.0,58.9
		.' Use Goldmine's Fire Totem in the red lava spot |use Goldmines's Fire Totem##60834
		.from Magmatooth##45099
		.get The Burning Heart |q 27135/1
	step
		goto 49.7,52.9
		.talk Seer Kormo##43397
		..turnin Elemental Energy##27136
	step
		goto 46.5,57.3
		.talk Initiate Goldmine##42574
		..turnin Something that Burns##27135
		..accept Apply and Flash Dry##26411
	step
		goto 46.6,57.2
		.' Use your Explosive Bonding Compound on Flint Oremantle |use Explosive Bonding Compound##58502 |tip He's laying on the ground next to Initiate Goldmine.
		.' Apply the Explosive Bonding Compound |q 26411/1
	step
		goto 46.5,57.3
		.talk Initiate Goldmine##42574
		..turnin Apply and Flash Dry##26411
		..accept Take Him to the Earthcaller##26413
	step
		goto 49.5,53.3
		.' Introduce Flint Oremantle to Earthcaller Yevaa |q 26413/1
	step
		goto 49.5,53.3
		.talk Earthcaller Yevaa##42573
		..turnin Take Him to the Earthcaller##26413
		..accept To Stonehearth's Aid##26484
	step
		goto 56.1,74.2
		.' Click the Slain Cannoneer |tip It looks like a dead orc on the deck of the crashed zeppelin, laying next to a pile of cannon balls and a cannon.
		.' Receive the Second Clue |q 26245/2
	step
		goto 53.5,73.8
		.' Click Captain Skullshatter |tip He's a dead orc laying on the ground next to a small round table in a side room on the deck of the crashed zeppelin.
		.' Receive the First Clue |q 26245/1
	step
		goto 53.6,73.8
		.' Click the Captain's Log |tip It's a gray book laying on the small round table next to Captain Skullshatter.
		..accept Captain's Log##26246
	step
		goto 56.7,76.4
		.' Click the Unexploded Artillery Shell |tip It looks like a metal casing, or bullet type of object laying on the ground underneath the crashed zeppelin.  You can get to it by flying in the 3 open side doors on the north side of the crashed zeppelin.
		.' Receive the Third Clue |q 26245/3
	step
		goto 55.9,74.9
		.kill 5 Deepstone Elemental |q 26244/1
	step
		goto 49.6,52.9
		.talk Maruut Stonebinder##43065
		..turnin Gunship Down##26245
		..turnin Captain's Log##26246
	step
		goto 49.7,52.9
		.talk Seer Kormo##43397
		..turnin The Earth Claims All##26244
	step
		goto 49.6,53.0
		.talk Maruut Stonebinder##43065
		..accept Diplomacy First##26247
	step
		goto 62.4,52.6
		.talk Stormcaller Mylra##42684
		..turnin Diplomacy First##26247
		..accept All Our Friends Are Dead##26248
		..accept The Admiral's Cabin##26249
	step
		'All around on this air ship:
		.' Use your Spirit Totem on Slain Crew Members |use Spirit Totem##58167 |tip They look like dead Alliance soldiers all over this airship.
		.' Receive 6 Slain Crew Member Information |q 26248/1
	step
		'Enter the doorway on the main deck of the air ship:
		.talk First Mate Moody##43082
		..turnin The Admiral's Cabin##26249
		..accept Without a Captain or Crew##26427
	step
		'Leave through the doorway and immediately turn right:
		.' Click the Bottle of Whiskey |tip It's a yellow bottle sitting on the edge of a small life boat on the side of the airship.
		.get Bottle of Whiskey |q 26427/1
	step
		'All around on the deck of the air ship:
		.' Click a Spool of Rope |tip They are coiled up ropes laying all around on the deck of the airship.
		.get Spool of Rope |q 26427/2
	step
		'Enter the doorway on the main deck of the air ship:
		.talk First Mate Moody##43082
		..turnin Without a Captain or Crew##26427
	step
		'Go to the very top of the air ship:
		.talk Stormcaller Mylra##42684
		..turnin All Our Friends Are Dead##26248
		..accept Take No Prisoners##26251
		..accept On Second Thought, Take One Prisoner##26250
	step
		'Go onto the main deck of the ship and go down the stairs to the deck below:
		.' Fight Mor'norokk the Hateful until he surrenders |tip He's downstairs in the airship, in the very back of the first level you come to.
		.talk Mor'norokk the Hateful##42801
		.' Subdue Mor'norokk the Hateful |q 26250/1
	step
		'All around on this lower deck of the air ship:
		.kill 6 Twilight Saboteur |q 26251/1
	step
		'Go to the very top of the air ship:
		.talk Stormcaller Mylra##42684
		..turnin Take No Prisoners##26251
		..turnin On Second Thought, Take One Prisoner##26250
		..accept Some Spraining to Do##26254
	step
		Next to Stormcaller Mylra:
		.' Click Stormbeak |tip It's a gryphon flying in place next to the air ship.
		.' Interrogate Mok'norrok |q 26254/1
	step
		'When you land on the air ship again:
		.talk Stormcaller Mylra##42684
		..turnin Some Spraining to Do##26254
		..accept Return to the Temple of Earth##26255
	step
		'Hearth to Temple of Earth |goto 49.2,51.9,0.5 |use Hearthstone##6948 |noway |c
	step
		goto 49.6,53.0
		.talk Maruut Stonebinder##43065
		..turnin Return to the Temple of Earth##26255
		..accept Deathwing's Fall##26258
	step
		goto 49.7,52.9
		.talk Seer Kormo##43397
		..accept Blood of the Earthwarder##26259
	step
		goto 59.4,58.2
		.' Go to this spot
		.' Reach Deathwing's Fall |q 26258/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Deathwing's Fall##26258
		..accept Bleed the Bloodshaper##26256
	step
		goto 61.5,60.6
		.from Twilight Bloodshaper##43218+
		.get Twilight Orders |q 26256/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Bleed the Bloodshaper##26256
		..accept Question the Slaves##26261
	step
		goto 62.8,59.5
		.' Click the Slavemaster's Coffer |tip It looks like a small wooden chest on the ground inside a red tent.
		.collect Twilight Slaver's Key##60739 |q 26261
	step
		goto 61.2,60.1
		.from Living Blood##43123+
		.get 5 Blood of Neltharion |q 26259/1
	step
		goto 64.5,65.5
		.' Click Ball and Chains |tip They are attached to the feet of the Enslaved Miners around this area.
		.' Free 6 Enslaved Miners |q 26261/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Question the Slaves##26261
		..accept The Forgemaster's Log##26260
	step
		goto 63.7,55.4
		.' Click the Forgemaster's Log |tip It's a blue-ish book laying on the floor at the very top of this tower.
		..turnin The Forgemaster's Log##26260
		..accept Silvermarsh Rendezvous##27007
	step
		goto 70.6,61.2
		.' Go to this spot
		.' Reach Upper Silvermarsh |q 27007/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Silvermarsh Rendezvous##27007
		..accept Quicksilver Submersion##27010
	step
		goto 71.8,64.3
		.' Click the Trogg Crate |tip It's a brown box sitting next to the water.
		.collect Trogg Crate##60809 |q 27010
		.from Murkstone Trogg##44936
		.collect Maziel's Research##60816 |n
		.' Click Maziel's Research in your bags |use Maziel's Research##60816
		..accept Twilight Research##27100
	step
		goto 74.9,64.8
		.' Use your Trogg Crate in the water and swim to this spot |use Trogg Crate##60809
		.' Watch the dialogue
		.' Uncover the World Pillar Fragment Clue |q 27010/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Quicksilver Submersion##27010
		..accept The Twilight Overlook##27061
	step
		goto 72.5,65.2
		.from Mercurial Ooze##43158+
		.get 4 Twilight Research Notes |q 27100/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Twilight Research##27100
		..accept Maziel's Revelation##27101
	step
		goto 67.2,70.2
		.' Click Maziel's Journal |tip It looks like a small black book laying on the ground on this tiny island in a pond, next to a big rock.
		..turnin Maziel's Revelation##27101
		..accept Maziel's Ascendancy##27102
	step
		goto 69.5,68.0 |n
		.' Enter the cave |goto 69.5,68.0,0.5 |noway |c
	step
		goto 72.8,62.0
		.kill Maziel |q 27102/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Maziel's Ascendancy##27102
	step
		goto 69.5,68.0 |n
		.' Leave the cave |goto 69.5,68.0,0.5 |noway |c	
	step
		goto 64.5,82.1
		.talk Stormcaller Mylra##44010
		..turnin The Twilight Overlook##27061
		..accept Big Game, Big Bait##26766
		..accept To Catch a Dragon##26768
	step
		goto 68.2,77.9
		.from Scalesworn Cultist##44221+
		.get Twilight Snare |q 26768/1
	step
		goto 64.5,82.1
		.talk Stormcaller Mylra##44010
		..turnin To Catch a Dragon##26768
	step
		goto 59.9,83.6
		.from Jadecrest Basilisk##43981+
		.' Use Mylra's Knife on Jadefire Basilisk corpses |use Mylra's Knife##60382
		.get 5 Side of Basilisk Meat |q 26766/1 
	step
		goto 64.5,82.1
		.talk Stormcaller Mylra##44010
		..turnin Big Game, Big Bait##26766
		..accept Testing the Trap##26771
	step
		goto 50.9,85.3
		.' Use your Trapped Basilisk Meat |use Trapped Basilisk Meat##60773
		.kill Stonescale Matriarch |q 26771/1
	step
		goto 64.5,82.1
		.talk Stormcaller Mylra##44010
		..turnin Testing the Trap##26771
		..accept Abyssion's Minions##26857
	step
		goto 64.6,82.2
		.talk Seer Galekk##44222
		..accept Block the Gates##26861
	step
		goto 68.7,75.0
		.' Use your Stormstone next to the swirling blue portal |use Stormstone##60501
		.' Disrupt the Twilight Gate |q 26861/1
	step
		goto 71.2,75.1
		.' Use your Stormstone next to the structure with the floating yellow crystal |use Stormstone##60501
		.' Disrupt the Elemental Gate |q 26861/2
	step
		goto 69.9,76.7
		.from Scalesworn Cultist##44221+, Twilight Scalesister##43967+, Twilight Dragonspawn##43966+
		.' Defeat 8 Abyssion's Underlings |q 26857/1
	step
		goto 64.6,82.2
		.talk Seer Galekk##44222
		..turnin Block the Gates##26861
	step
		goto 64.5,82.2
		.talk Stormcaller Mylra##44010
		..turnin Abyssion's Minions##26857
		..accept The World Pillar Fragment##26876
	step
		goto 69.9,76.9
		.' Use your Earthen Ring Banner |use Earthen Ring Banner##60810
		.from Abyssion##
		.' Click The First Fragment of the World Pillar |tip It's a floating green rock that appears after you kill Abyssion.
		.get The Upper World Pillar Fragment |q 26876/1
	step
		'Hearth to Temple of Earth |goto 49.2,51.9,0.5 |use Hearthstone##6948 |noway |c
	step
		goto 49.6,53.0
		.talk Maruut Stonebinder##43065
		..turnin The World Pillar Fragment##26876
	step
		goto 49.7,52.9
		.talk Seer Kormo##43397
		..turnin Blood of the Earthwarder##26259
	step
		goto 27.9,68.7
		.talk Crag Rockcrusher##43071
		..turnin To Stonehearth's Aid##26484
		..accept The Quaking Fields##27931
	step
		goto 30.6,77.7
		.talk Slate Quicksand##47195
		..turnin The Quaking Fields##27931
		..accept The Axe of Earthly Sundering##27932
		..accept Elemental Ore##27933
	step
		goto 32.2,79.1
		.' Use The Axe of Earthly Sundering on Emerald Colossi |use The Ace of Earthly Sundering##60490 |tip They look like glowing giants that walk around this area.
		.kill 5 Sundered Emerald Colossus |q 27932/1 
		.from Jade Rager##44220+
		.get 6 Elemental Ore |q 27933/1
	step
		goto 30.6,77.7
		.talk Slate Quicksand##47195
		..turnin The Axe of Earthly Sundering##27932
		..turnin Elemental Ore##27933
		..accept One With the Ground##27934
	step
		goto 30.6,77.7
		.talk Slate Quicksand##47195
		..' Tell him you are ready for the ritual
		.' Complete the One With the Ground Ritual |q 27934/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin One With the Ground##27934
		..accept Bring Down the Avalanche##27935
	step
		goto 46.9,89.1
		.kill Avalanchion |q 27935/1
	step
		goto 43.4,82.0 |n
		.' Leave the cave |goto 43.4,82.0,0.5 |noway |c
	step
		goto 27.9,68.7
		.talk Crag Rockcrusher##43071
		..turnin Bring Down the Avalanche##27935
		..accept Stonefather's Boon##26499
	step
		goto 28.2,69.6
		.talk Earthbreaker Dolomite##43160
		..accept We're Surrounded##26500
	step
		goto 29.7,68.8
		kill 12 Stone Trogg Ambusher |q 26500/1
		.' Use Stonefather's Banner next to Stone Hearth Defenders |use Stonefather's Banner##58884 |tip They look like dwarves.  Stonefather's Banner won't work on the Stone Hearth Defenders if they already have the Stonefather's Boon buff.
		.' Grant the Stonefather's Boon 12 times |q 26499/1
	step
		goto 28.2,69.6
		.talk Earthbreaker Dolomite##43160
		..turnin We're Surrounded##26500
		..accept Thunder Stones##26502
	step
		goto 27.9,68.7
		.talk Crag Rockcrusher##43071
		..turnin Stonefather's Boon##26499
		..accept Sealing the Way##26501
	step
		goto 27.3,67.8
		.' Use your Rockslide Reagent on the Earthen Geomancer |use Rockslide Reagent##58885 |tip They must be out of combat for it to work, so kill any troggs attacking the Earthen Geomancer.
		.' Seal the Shrine |q 26501/4
	step
		goto 26.0,68.8
		.' Use your Rockslide Reagent on the Earthen Geomancer |use Rockslide Reagent##58885 |tip They must be out of combat for it to work, so kill any troggs attacking the Earthen Geomancer.
		.' Seal the Barracks |q 26501/3
	step
		goto 26.2,69.8
		.' Use your Rockslide Reagent on the Earthen Geomancer |use Rockslide Reagent##58885 |tip They must be out of combat for it to work, so kill any troggs attacking the Earthen Geomancer.
		.' Seal the Inn |q 26501/2
	step
		goto 27.3,70.1
		.' Use your Rockslide Reagent on the Earthen Geomancer |use Rockslide Reagent##58885 |tip They must be out of combat for it to work, so kill any troggs attacking the Earthen Geomancer.
		.' Seal the Armory |q 26501/1
		.' Click Thunder Stones |tip They looks like blue round spiked cannonballs on the ground and in wagons around this area.
		.get 12 Thunder Stone |q 26502/1 
	step
		goto 24.5,62.4
		.talk Gravel Longslab##43168
		..turnin Sealing the Way##26501
		..accept Shatter Them!##26537
	step
		goto 24.8,62.2
		.talk Clay Mudaxle##43169
		..turnin Thunder Stones##26502
		..accept Fixer Upper##26564
	step
		goto 24.6,62.2
		.talk Earthmender Deepvein##43319
		..accept Battlefront Triage##26591
	step
		goto 23.9,60.3
		.' Use Deepvein's Patch Kit on Injured Earthens |use Deepvein's Patch Kit##58965 |tip They look like dwarves laying on the ground around this area.
		.' Patch up 10 Injured Earthen |q 26591/1
		.' Click Catapult Parts |tip They look kind of like big metal parts laying on the ground around this area.
		.get 6 Catapult Part |q 26564/1 
		.from Stone Trogg Berserker##43228+, Stone Trogg Geomancer##43234+, Needlerock Rider##43250+
		.kill 12 Fractured Battlefront stone troggs |q 26537/1
		.' You can also look around 23.1,53.9 for more
	step
		goto 24.5,62.4
		.talk Gravel Longslab##43168
		..turnin Shatter Them!##26537
	step
		goto 24.6,62.2
		.talk Earthmender Deepvein##43319
		..turnin Battlefront Triage##26591
	step
		goto 24.8,62.2
		.talk Clay Mudaxle##43169
		..turnin Fixer Upper##26564
	step
		goto 24.5,62.4
		.talk Gravel Longslab##43168
		..accept Troggzor the Earthinator##26625
	step
		goto 22.6,56.9
		.from Troggzor the Earthinator##43456
		.get The Earthinator's Cudgel |q 26625/1 
	step
		goto 24.5,62.4
		.talk Gravel Longslab##43168
		..turnin Troggzor the Earthinator##26625
	step
		goto 24.8,62.2
		.talk Clay Mudaxle##43169
		..accept Rush Delivery##27126
	step
		goto 20.7,61.6
		.talk Peak Grindstone##45043
		..turnin Rush Delivery##27126
		..accept Close Escort##26632
	step
		goto 20.7,61.6
		.talk Peak Grindstone##45043
		..' Tell him you're ready to escort the catapult
		.' Safely Escort the Earthen Catapult |q 26632/1
	step
		goto 22.7,52.0
		.talk Pyrium Lodestone##43897
		..turnin Close Escort##26632
		..accept Keep Them off the Front##26755
	step
		goto 22.4,52.0
		.' Click an Earthen Catapult |tip They look like wooden launchers with stone wheels.
		.' Use your Fire Catapult ability on your hotbar on the Stone Trogg and Fungal mobs
		.' Bombarb 30 Reinforcements |q 26755/1
	step
		goto 22.7,52.0
		.talk Pyrium Lodestone##43897
		..turnin Keep Them off the Front##26755
		..accept Reactivate the Constructs##26762
	step
		goto 22.8,52.1
		.talk Flint Oremantle##43898
		..accept Mystic Masters##26770
	step
		goto 22.6,47.6
		.' Click Deactivated War Construct |tip They look like metal golems around this area.
		.' Reactivate 5 Deactivated War Constructs |q 26762/1
		.kill 5 Needlerock Mystic |q 26770/1
	step
		goto 22.8,52.1
		.talk Flint Oremantle##43898
		..turnin Mystic Masters##26770
	step
		goto 22.7,52.0
		.talk Pyrium Lodestone##43897
		..turnin Reactivate the Constructs##26762
		..accept Down Into the Chasm##26834
	step
		goto 27.6,44.8
		.talk Slate Quicksand##44143
		..turnin Down Into the Chasm##26834
		..accept Sprout No More##26791
		..accept Fungal Monstrosities##26792
	step
		goto 27.6,44.7
		.' Click the War Guardian |tip It looks like a metal golem.
		.' Obtain a War Guardian for the Sprout No More quest |q 26791/1
		.' Obtain a War Guardian for the Fungal Monstrosities quest |q 26792/1
	step
		goto 26.8,41.8
		.kill 5 Fungal Monstronsity |q 26792/2
		.' Click Giant Mushrooms |tip They look like huge mushrooms with orange caps around this area.
		.' Destroy 5 Giant Mushrooms |q 26791/2
	step
		goto 27.6,44.8
		.talk Slate Quicksand##44143
		..turnin Sprout No More##26791
		..turnin Fungal Monstrosities##26792
		..accept A Slight Problem##26835
	step
		goto 22.7,52.0
		.talk Pyrium Lodestone##43897
		..turnin A Slight Problem##26835
		..accept Rescue the Stonefather... and Flint##26836
	step
		goto 24.5,31.1
		.from Bouldergut##44151
		.' Rescue Stonefather Oremantle |q 26836/1
	step
		goto 22.7,52.0
		.talk Pyrium Lodestone##43897
		..turnin Rescue the Stonefather... and Flint##26836
		..accept The Hero Returns##27937
	step
		goto 28.0,68.6
		.talk Stonefather Oremantle##44204
		..turnin The Hero Returns##27937
		..accept The Middle Fragment##27938
	step
		goto 28.0,68.7
		.' Click The Stonefather's Safe |tip It looks like a metal vault door with gold circles and symbols on it.
		.get The Middle Fragment of the World Pillar |q 27938/1
	step
		'Hearth to Temple of Earth |goto 49.2,51.9,0.5 |use Hearthstone##6948 |noway |c
	step
		goto 49.5,53.3
		.talk Earthcaller Yevaa##42573
		..turnin The Middle Fragment##27938
	step
		goto 49.6,53.0
		.talk Maruut Stonebinder##43065
		..accept The Very Earth Beneath Our Feet##26326
	step
		goto 46.1,45.6
		.talk Earthcaller Torunscar##42730
		..turnin The Very Earth Beneath Our Feet##26326
		..accept Crumbling Defenses##26312
		..accept On Even Ground##26314
	step
		goto 46.2,45.7
		.talk Earthmender Norsala##42731
		..accept Core of Our Troubles##26313
	step
		goto 44.3,43.7
		.from Irestone Rumbler##42780+
		.' Use your Elementium Grapple Line on Servants of Therazane |use Elementium Grapple Line##58169 |tip Run away from the Servants of Therazane to bring them down.
		.' Relieve Stormcaller Mylra |q 26312/2
	step
		goto 44.5,41.3
		.from Irestone Rumbler##42780+
		.' Use your Elementium Grapple Line on Servants of Therazane |use Elementium Grapple Line##58169 |tip Run away from the Servants of Therazane to bring them down.
		.' Relieve Tawn Winterbluff |q 26312/1
	step
		goto 47.6,42.8
		.from Irestone Rumbler##42780+
		.' Use your Elementium Grapple Line on Servants of Therazane |use Elementium Grapple Line##58169 |tip Run away from the Servants of Therazane to bring them down.
		.' Relieve Hargoth Dimblaze |q 26312/3
	step
		goto 46.2,42.2
		.from Irestone Rumbler##42780+
		.get 6 Irestone Core |q 26313/1
		.' Use your Elementium Grapple Line on Servants of Therazane |use Elementium Grapple Line##58169 |tip Run away from the Servants of Therazane to bring them down.
		.' Bring down 3 Servants of Therazane |q 26314/1
	step
		goto 46.2,45.7
		.talk Earthmender Norsala##42731
		..turnin Core of Our Troubles##26313
	step
		goto 46.1,45.6
		.talk Earthcaller Torunscar##42730
		..turnin Crumbling Defenses##26312
		..turnin On Even Ground##26314
	step
		goto 46.2,45.7
		.talk Earthmender Norsala##42731
		..accept Imposing Confrontation##26315
	step
		goto 49.2,40.1
		.' Use your Earthen Ring Proclamation on Boden the Imposing |use Earthen Ring Proclamation##58177 |tip He's a huge rock giant that walks around this area.
		.' Seek Peace with Boden the Imposing |q 26315/1
	step
		goto 46.2,45.7
		.talk Earthmender Norsala##42731
		..turnin Imposing Confrontation##26315
		..accept Rocky Relations##26328
	step
		goto 56.5,42.7
		.talk Diamant the Patient##42467
		..turnin Rocky Relations##26328
		..accept Hatred Runs Deep##26376
		..accept Unsolid Ground##26377
	step
		goto 56.5,41.0
		.talk Quartz Stonetender##42899
		..accept Loose Stones##26375
	step
		goto 60.2,39.4
		.kill Dragul Giantbutcher |q 26376/1
	step
		goto 59.5,41.5
		.' Click Jade Crystal Clusters |tip They look like green glowing rocks sitting on the ground all around this area.
		.collect 6 Jade Crystal Cluster##58500 |q 26377
		.' Use your Delicate Chain Smasher next to Quartz Rocklings |use Delicate Chain Smasher##58254 |tip They look like small rock giants around this area.
		.' Release 6 Quartz Rocklings |q 26375/1
	step
		'Use the Jade Crystal Clusters |use Jade Crystal Cluster##58500
		.collect Jade Crystal Composite##58783 |q 26377
	step
		goto 59.6,41.4
		.' Use your Jade Crystal Composite |use Jade Crystal Composite##58783
		.' Lure an Agitated Tunneler |q 26377/1
	step
		goto 59.3,40.6
		.from Twilight Laborer##42924+, Twilight Priestess##42823+, Twilight Duskwarden##42917+
		.kill 12 Lorthuna's Gate Cultists |q 26376/2 
	step
		goto 56.5,41.0
		.talk Quartz Stonetender##42899
		..turnin Loose Stones##26375
	step
		goto 56.5,42.7
		.talk Diamant the Patient##42467
		..turnin Hatred Runs Deep##26376
		..turnin Unsolid Ground##26377
		..accept Violent Gale##26426
	step
		goto 51.7,31.6
		.' Get next to Felsen the Enduring |tip He's a big white rock giant.
		.' Find Felsen the Enduring |q 26426/1
	step
		goto 58.4,25.7
		.' Fly to the mouth of this cave
		.' Find the entrance to the Crumbling Depths |q 26426/2
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Violent Gale##26426
		..accept Depth of the Depths##26869
	step
		goto 64.5,21.7 |n
		.' Follow the path |goto 64.5,21.7,0.5 |noway |c
	step
		goto 65.3,18.4 |n
		.' Follow the path |goto 65.3,18.4,0.5 |noway |c
	step
		goto 66.4,20.6
		.' Click the Gigantic Painite Cluster |tip It looks like a green crystal cluster near the mouth of the cave.
		..turnin Depth of the Depths##26869
		..accept A Rock Amongst Many##26871
	step
		goto 64.3,23.5
		.' Follow the path to this spot, then jump down |goto 64.3,23.5,0.5 |noway |c
	step
		goto 58.3,25.5 |n
		.' Leave the cave |goto 58.3,25.5,0.5 |noway |c
	step
		goto 56.5,42.7
		.talk Diamant the Patient##42467
		..turnin A Rock Amongst Many##26871
		..accept Entrenched##26436
	step
		goto 34.3,34.3
		.talk Kor the Immovable##42469
		..turnin Entrenched##26436
		..accept Intervention##26438
		..accept Making Things Crystal Clear##26437
	step
		goto 34.1,35.2
		.talk Berracite##43344
		..accept Putting the Pieces Together##26439
	step
		goto 30.5,46.8
		.from Jaspertip Borer##42524+, Jaspertip Swarmer##42521+, Jaspertip Ravager##42525+, Jaspertip Crystal-gorger##43171+
		.kill 12 Jaspertip flayers |q 26438/1
		.' Click Chalky Crystal Formations |tip They look like big white blocks on the ground around this area.
		.get 8 Chalky Crystal Formation |q 26437/1 
		.' Click Dormant Stonebound Elementals |tip They look like crumbled rock elementals on the ground around this area.
		.' Reform 6 Stonebound Elementals |q 26439/1
	step
		goto 34.3,34.3
		.talk Kor the Immovable##42469
		..turnin Intervention##26438
		..turnin Making Things Crystal Clear##26437
	step
		goto 34.1,35.2
		.talk Berracite##43344
		..turnin Putting the Pieces Together##26439
	step
		goto 34.4,34.4
		.talk Kor the Immovable##42469
		..accept Pebble##28869
	step
		'Next to you:
		.talk Pebble##43116
		..turnin Pebble##28869
		..accept Clingy##26440
	step
		goto 30.1,47.7
		.' Get next to the huge green crystals
		.' Bring Pebble to the crystal formation |q 26440/1
	step
		'Next to you:
		.talk Pebble##43116
		..turnin Clingy##26440
		..accept So Big, So Round...##26441
	step
		goto 34.3,34.3
		.talk Kor the Immovable##42469
		..turnin So Big, So Round...##26441
		..accept Petrified Delicacies##26507
		..accept Rock Bottom##26575
	step
		goto 47.6,26.8
		.kill Gorgonite |q 26575/1
	step
		goto 47.5,26.8
		.' Click Petrified Stone Bats |tip They looks like black stone bats laying on the ground around this area.
		.get 12 Petrified Stone Bat |q 26507/1
	step
		'Next to you:
		.talk Pebble##43116
		..turnin Petrified Delicacies##26507
	step
		goto 34.3,34.3
		.talk Kor the Immovable##42469
		..turnin Rock Bottom##26575
		..accept Steady Hand##26576
		..accept Rocky Upheaval##26577
	step
		goto 39.9,19.4
		.talk Terrath the Steady##42466
		..turnin Steady Hand##26576
		..accept Don't. Stop. Moving.##26656
	step
		goto 39.9,19.4
		.talk Terrath the Steady##42466
		..' Tell him you are ready to escort a group of elementals across the open.
		.' Speak to Terrath the Steady |q 26656/1
	step
		goto 51.1,14.7
		.' Go to this spot
		.' Escort 5 Opalescent Guardians to safety |q 26656/2 |tip Run on the ground with your mount, don't fly or you the rock elementals will disappear when you get too far away from them.
	step
		goto 39.9,19.4
		.talk Terrath the Steady##42466
		..turnin Don't. Stop. Moving.##26656
		..accept Hard Falls##26657
		..accept Fragile Values##26658
	step
		goto 35.4,22.5
		.from Stone Trogg Beast Tamer##43598 |tip He moves all around this area capturing basilisks, so you may need to look around a bit for him.
		.get Stonework Mallet |q 26658/1
	step
		goto 36.5,18.8
		.kill 6 Stone Drake |q 26657/1 |tip They will fall to the ground with half health, so you can kill them, even though they are elite.
	step
		goto 40.0,19.4
		.talk Terrath the Steady##42466
		..turnin Hard Falls##26657
		..turnin Fragile Values##26658
		..accept Resonating Blow##26659
	step
		goto 32.7,24.3
		.' Use your Stonework Mallet next to the Pale Resonating Crystal |use Stonework Mallet##60266 |tip It's a huge green crystal sitting on the ground.
		.' Strike the Pale Resonating Crystal |q 26659/1
		.from Aeosera##43641 |tip Click the Boulder Platforms to jump from rock to rock while fighting Aeosera.  When she is casting her Breath Fire ability, jump to another rock and attack her while she is breathing fire to the other rock.  Repeat this until she surrenders.
		.' Defeat Aeosera |q 26659/2
	step
		goto 33.1,24.1
		.talk Terrath the Steady##42466
		..turnin Resonating Blow##26659
		.' If Terrath the Steady doesn't spawn at the appropriate spot, go to 40.0,19.4
	step
		'Hearth to the Temple of Earth |goto 49.2,51.9,0.5 |use Hearthstone##6948 |noway |c
	step
		goto 72.2,54.0
		.talk Gorsik the Tumultuous##42472
		..turnin Rocky Upheaval##26577
		..accept Doomshrooms##26578
		..accept Gone Soft##26579
		..accept Familiar Intruders##26580
	step
		goto 71.8,47.6
		.talk Windspeaker Lorvarius##43395
		..turnin Familiar Intruders##26580
		..accept A Head Full of Wind##26581
	step
		goto 73.6,40.8
		.kill 8 Fungal Behemoth |q 26579/1
		.from Doomshroom##+ |tip They look like orange mushrooms around this area.
		.' Destroy 10 Doomshrooms |q 26578/1
		.' Gather a sample of the red mist|q 26581/1 |tip There are small clouds of red mist that float around on the ground around this area.  Walk into one of them to gather a sample.
		.' You will be able to find more Fungal Behemoths and Doomshrooms around [76.6,44.4]
	step
		goto 71.8,47.6
		.talk Windspeaker Lorvarius##43395
		..turnin A Head Full of Wind##26581
		..accept Unnatural Causes##26582
	step
		goto 72.2,54.0
		.talk Gorsik the Tumultuous##42472
		..turnin Doomshrooms##26578
		..turnin Gone Soft##26579
		..turnin Unnatural Causes##26582
		..accept Shaken and Stirred##26584
		..accept Corruption Destruction##26585
	step
		goto 68.5,26.4
		.talk Ruberick##43442
		..accept Wrath of the Fungalmancer##26583
	step
		goto 68.6,29.1 |n
		.' Enter the cave |goto 68.6,29.1,0.5 |noway |c
	step
		goto 69.8,31.9
		.talk Earthmender Norsala##43503
		..' Tell her you're ready when she is |q 26583/1
		.kill Fungalmancer Glop |q 26583/2 |tip Follow him each time he runs away.  Avoid the mushrooms as you walk, they will give you a debuff.  While fighting Fungalmancer Glop, kill the Boomshrooms he creates.  Don't let them grow too big, they will explode and deal a lot of damage.
	step
		goto 70.2,33.8 |n
		.' Follow the path up |goto 70.2,33.8,0.5 |noway |c
	step
		goto 68.6,29.1 |n
		.' Leave the cave |goto 68.6,29.1,0.5 |noway |c
	step
		goto 68.5,26.3
		.talk Ruberick##43442
		..turnin Wrath of the Fungalmancer##26583
	step
		goto 69.4,24.8
		.kill 8 Verlok Pillartumbler |q 26584/1
		.' Click Verlok Miracle-grow |tip They look like gray bags sitting on the ground around this area.
		.get 8 Verlok Miracle-grow |q 26585/1
	step
		goto 72.2,54.0
		.talk Gorsik the Tumultuous##42472
		..turnin Shaken and Stirred##26584
		..turnin Corruption Destruction##26585
		..accept At the Stonemother's Call##26750
	step
		goto 56.3,12.2
		.talk Therazane##42465
		..turnin At the Stonemother's Call##26750
		..accept Audience with the Stonemother##26752
	step
		'Watch the dialogue
		.' Attend the Stonemother's Audience |q 26752/1
	step
		goto 56.1,13.5
		.talk Earthcaller Torunscar##43809
		..turnin Audience with the Stonemother##26752
		..accept Rallying the Earthen Ring##26827
	step
		'Hearth to the Temple of Earth |goto 49.2,51.9,0.5 |use Hearthstone##6948 |noway |c
	step
		goto 47.3,51.4
		.talk Explorer Mowi##44799
		..accept The Twilight Plot##27004
	step
		goto 47.3,51.4
		.talk Prospector Brewer##44802
		..accept Fly Over##27006
	step
		goto 39.0,74.2
		.' Go to this spot next to the big white portal
		.' Investigate the Master's Gate |q 27006/1 
	step
		goto 40.1,72.2
		.from Twilight Cryptomancer##44855+, Twilight Crusher##44849+, Twilight Armsman##44847+
		.get Masters' Gate Plans |q 27004/1
	step
		goto 47.3,51.4
		.talk Explorer Mowi##44799
		..turnin The Twilight Plot##27004
	step
		goto 47.3,51.4
		.talk Prospector Brewer##44802
		..turnin Fly Over##27006
		..accept Fight Fire and Water and Air with...##27042
	step
		goto 47.3,51.4
		.talk Explorer Mowi##44799
		..accept Decryption Made Easy##27040
	step
		goto 40.8,66.3
		.from Bound Water Elemental##44886
		.' Acquire the Water Ward |q 27042/2
	step
		goto 36.0,67.4
		.from Bound Fire Elemental##44887
		.' Acquire the Fire Ward |q 27042/1
	step
		goto 40.5,72.4
		.from Bound Air Elemental##44885
		.' Acquire the Air Ward |q 27042/3
	step
		goto 40.2,67.5
		.' Click One-Time Decryption Engines |tip They look like machines around this area with a circular scroll spinning around them, and yellow cores floating in the middle of the spinning scrolls.
		.' Decrypt 6 Plans |q 27040/1
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Decryption Made Easy##27040
		..accept The Wrong Sequence##27058
	step
		goto 39.1,73.9
		.' Click the Waygate Controller |tip It looks like a cylinder stone container with a stone ring on top of it, sitting in front of the huge white portal.
		.' Destroy the Waygate |q 27058/1
	step
		goto 39.9,62.2
		.kill Haethen Kaul |q 27042/4 |tip He's up on a huge floating rock.
	step
		goto 47.3,51.4
		.talk Explorer Mowi##44799
		..turnin The Wrong Sequence##27058
		..accept That's No Pyramid!##28292
	step
		goto 47.3,51.4
		.talk Prospector Brewer##44802
		..turnin Fight Fire and Water and Air with...##27042
	step
		goto 48.0,53.7
		.' Talk with Windspeaker Lorvarius, Yuldris Smolderfury, Tawn Winterbluff, Earthcaller Yevaa and Tharm Wildfire at the below locations:
		.' 48.5,50.1
		.' 47.4,50.9
		.' 48.1,49.9
		..' Tell her you are joining an assault on Lorthuna's Gate and she is needed.
		.' Rally 5 Earthen Ring |q 26827/1
	step
		goto 49.6,53.0
		.talk Maruut Stonebinder##43065
		..turnin Rallying the Earthen Ring##26827
		..accept Our Part of the Bargain##26828
	step
		goto 63.3,25.0
		.talk Therazane##44025
		..turnin Our Part of the Bargain##26828
		..accept The Stone March##26829
		..accept Therazane's Mercy##26832
	step
		goto 62.6,26.9
		.talk Boden the Imposing##44080
		..accept The Twilight Flight##26831
	step
		goto 62.4,31.8
		.from High Priestess Lorthuna##42914 |tip She is in a small room on the top of this building.  She is elite, but you can still kill her.  She will run away when she is almost dead.
		.' Defeat High Priestess Lorthuna |q 26832/2
	step
		goto 58.9,32.9
		.from Boldrich Stonerender##42923
		.' Defeat Boldrich Stonerender |q 26832/1
	step
		goto 63.1,38.1
		.from Zoltrik Drakebane##42918 |tip You will eventually get on a stone drake and fly after Zoltrik Drakebane.  You can use your Jump ability to jump onto his drake, if you are a melee class.  Either way, you will land on a rock with him and kill him there.
		.' Defeat Zoltrik Drakebane |q 26831/1
	step
		goto 64.1,36.9
		.talk Terrath the Steady##42614
		..turnin The Twilight Flight##26831
	step
		goto 60.3,33.2
		.from Defaced Earthrager##44076+, Twilight Soulreaper##42916+, Twilight Priestess##42823+
		.kill 15 Twilight Precipice Cultists |q 26829/1
	step
		goto 63.3,25.0
		.talk Therazane##44025
		..turnin The Stone March##26829
		..turnin Therazane's Mercy##26832
		..accept Word In Stone##26833
	step
		goto 49.6,53.0
		.talk Maruut Stonebinder##43818
		..turnin Word In Stone##26833
		..accept Undying Twilight##26875
	step
		goto 50.7,49.6
		.kill 12 Twilight Invaders |q 26875/1
		.kill Desecrated Earthrager |q 26875/2
		.' Click the Quest Complete box that displays on the right side of the screen under your minimap
		..turnin Undying Twilight##26875
		..accept The Binding##26971
	step
		goto 49.6,52.9
		.kill High Priestess Lorthuna |q 26971/1 
	step
		goto 49.6,52.9
		.talk Earthcaller Torunscar##43835
		..turnin The Binding##26971
	step
		goto 49.8,53.4
		.talk Therazane##43792
		..accept The Stone Throne##26709
	step
		goto 56.4,12.1
		.talk Therazane##42465
		..turnin The Stone Throne##26709
]])
ZygorGuidesViewer:RegisterInclude("A_Therazane_DailyQuest", [[
		'Increasing your Therazane reputation to Revered will unlock more daily quests. |tip Use the THERAZANE guide in the Cataclysm Reputation section to do this.
		.' Skip to the next step in the guide
	step
		goto Deepholm,56.1,14.4
		.talk Felsen the Enduring##43805
		..accept Fear of Boring##27046 |daily
		..accept Motes##27047 |daily
		..accept Beneath the Surface##28488 |daily |tip This quest can be offered at random and may not be offered everyday.
	step
		goto 56.6,14.1
		.talk Terrath the Steady##43806
		..accept The Restless Brood##28391 |daily |tip This quest can be offered at random if you have at least Revered reputation with Therazane.  However, the quest may not be offered everyday.
		only if rep ('Therazane') >= Revered
	step
		goto 57.3,12.5
		.talk Gorsik the Tumultuous##43804
		..accept Soft Rock##27049 |daily
		..accept Fungal Fury##27050 |daily
	step
		goto 55.4,14.2
		.talk Pyrite Stonetender##44945
		..accept Lost In The Deeps##26710 |daily |tip This quest can be offered at random and may not be offered everyday.
	step
		goto 59.6,14.0
		.talk Ruberick##44973
		..accept Through Persistence##27051 |daily
		..accept Glop, Son of Glop##28390 |daily |only if rep ('Therazane') >= Revered |tip This quest can be offered at random if you have at least Revered reputation with Therazane.  However, the quest may not be offered everyday.
	step
		goto 32.7,24.3
		.' Use your Stonework Mallet next to the Pale Resonating Crystal |use Stonework Mallet##60266 |tip It's a huge green crystal sitting on the ground.
		.' Strike the Pale Resonating Crystal |q 28391/1
		.from Aeosera##43641 |tip Click the Boulder Platforms to jump from rock to rock while fighting Aeosera.  When she is casting her Breath Fire ability, jump to another rock and attack her while she is breathing fire to the other rock.  Repeat this until she surrenders.
		.' Defeat Aeosera |q 28391/2
		only if rep ('Therazane') >= Revered
	step
		goto 56.6,14.1
		.talk Terrath the Steady##43806
		..turnin The Restless Brood##28391
		only if rep ('Therazane') >= Revered
	step
		goto 58.3,25.6 |n
		.' Enter the cave |goto 58.3,25.6,0.5 |noway |c
	step
		goto 61.3,26.2
		.talk Ricket##44968
		..accept Underground Economy##27048 |daily |tip This quest can be offered at random and may not be offered everyday.
	step
		goto 66.1,28.1
		.' Follow the path inside the cave
		.' Click the Ruby Gemstone Cluster |tip It looks like 3 dark colored spinning rings with a bunch of red crystals spinning above them.
		.from Enormous Gyreworm##48533
		.get Ruby Crystal Cluster |q 28488/1
	step
		goto 63.6,23.0
		.' Use Ricket's Tickers next to Deep Alabaster Crystals |use Ricket's Tickers##65514 |tip They look like huge white rocks around this area.
		.get 3 Deep Alabaster Crystal |q 27048/1
	step
		goto 62.6,23.9 |n
		.' Follow this path |goto 62.6,23.9,0.5 |noway |c
	step
		goto 61.8,19.7
		.' Use Ricket's Tickers next to Deep Celestite Crystals |use Ricket's Tickers##65514 |tip They look like huge blue rocks around this area.
		.get 3 Deep Celestite Crystal |q 27048/2
	step
		goto 62.0,18.0 |n
		.' Follow this path |goto 62.0,18.0,0.5 |noway |c
	step
		goto 64.4,18.6
		.' Use Ricket's Tickers next to Deep Amethyst Crystals |use Ricket's Tickers##65514 |tip They look like huge purple rocks around this area.
		.get 3 Deep Amethyst Crystal |q 27048/3
	step
		goto 65.3,18.4 |n
		.' Follow this path |goto 65.3,18.4,0.5 |noway |c
	step
		goto 66.4,20.2
		.' Use Ricket's Tickers next to Deep Garnet Crystals |use Ricket's Tickers##65514 |tip They look like huge red rocks around this area.
		.get 3 Deep Garnet Crystal |q 27048/4	
	step
		goto 63.6,23.9
		.' All around inside this cave:
		.from Gorged Gyreworm##42766+, Gyreworm##44257+
		.kill 10 Gyreworm |q 27046/1
		.' Click Painite Shards |tip They look like small green glowing crystals sitting on the ground all around inside this cave.
		.get 10 Painite Mote |q 27047/1
	step
		goto 63.1,20.8
		.talk Pebble##49956
		..' Tell him to follow you
	step
		goto 64.2,17.6 |n
		.' Follow this path |goto 64.2,17.6,0.5 |noway |c
	step
		goto 61.3,26.2
		.talk Ricket##44968
		..turnin Underground Economy##27048
	step
		goto 58.3,25.6 |n
		.' Leave the cave |goto 58.3,25.6,0.5 |noway |c
	step
		goto 58.3,25.6
		.' Wait in this spot until Pebble bobbles around appreciatively and then disappears into the distance
		.' Bring Pebble to safety |q 26710/1
	step
		goto 74.0,41.2
		.kill 8 Fungal Behemoth |q 27049/1
		.from Verlok Grubthumper##43367+, Verlok Shroomtender##43368+
		.get Bag of Verlok Miracle-Grow |q 27051/1
		.' Click Sprouting Crimson Mushrooms |tip They look like tiny mushrooms on the ground around this area.  Try to only click the solid blue, solid red or white-brown ones.  The blue ones with red spots will explode and hurt you. 
		.' Destroy 10 Freshly Sprouted Mushrooms |q 27050/1
	step
		goto 68.6,29.1 |n
		.' Enter the cave |goto 68.6,29.1,0.5 |noway |c
	step
		goto 69.8,31.9
		.talk Earthmender Norsala##43503
		..' Tell her you're ready when she is
		.kill Fungalmancer Glop |q 28390/1 |tip Follow him each time he runs away.  Avoid the mushrooms as you walk, they will give you a debuff.  While fighting Fungalmancer Glop, kill the Boomshrooms he creates.  Don't let them grow too big, they will explode and deal a lot of damage.
	step
		goto 70.2,33.8 |n
		.' Follow the path up |goto 70.2,33.8,0.5 |noway |c
	step
		goto 68.6,29.1 |n
		.' Leave the cave |goto 68.6,29.1,0.5 |noway |c
	step
		goto 59.6,14.0
		.talk Ruberick##44973
		..turnin Through Persistence##27051
		..turnin Glop, Son of Glop##28390 |only if rep ('Therazane') >= Revered
	step
		goto Deepholm,56.1,14.4
		.talk Felsen the Enduring##43805
		..turnin Fear of Boring##27046
		..turnin Motes##27047
		..turnin Beneath the Surface##28488
	step
		goto 55.4,14.2
		.talk Pyrite Stonetender##44945
		..turnin Lost In The Deeps##26710
	step
		goto 57.3,12.5
		.talk Gorsik the Tumultuous##43804
		..turnin Soft Rock##27049
		..turnin Fungal Fury##27050
]])
--------------------------------------------------------------------------------------------------------------------------------------
-- ACHIEVEMENTS
--------------------------------------------------------------------------------------------------------------------------------------

ZygorGuidesViewer:RegisterInclude("Explorer_Kalimdor",[[
	step
		' This guide assumes you have a flying mount and can fly in Azeroth as well. You can do this
		.' without having a flying mount but it will be much more efficient with one.
		|confirm always
	step
		#include "ratchet"
	step
	label	"start"
		' Explore Azshara |achieve 852
		' Explore Durotar |achieve 728
		' Explore Southern Barrens |achieve 4996
		' Explore Dustwallow Marsh |achieve 850
		' Explore Thousand Needles |achieve 846
		' Explore Tanaris |achieve 851
		' Explore Un'Goro Crater |achieve 854
		' Explore Uldum |achieve 4865
		' Explore Silithus |achieve 856
		' Explore Ferals |achieve 849
		' Explore Desolace |achieve 848
		' Explore Mulgore |achieve 736
		' Explore Stonetalon Mountains |achieve 847
		' Explore Ashenvale |achieve 845
		' Explore Mount Hyjal |achieve 4863
		' Explore Winterspring |achieve 857
		' Explore Moonglade |achieve 855
		' Explore Felwood |achieve 853
		' Explore Darkshore |achieve 844
		' Explore Teldrassil |achieve 842
		' Explore Azuremyst Isle |achieve 860
		' Explore Bloodmyst Isle |achieve 861
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
		.' Discover Darnassian Base Camp |achieve 852/7
	step
		goto 73.69,20.98
		.' Discover Bitter Reaches |achieve 852/4
	step
		goto 80.90,32.34
		.' Discover Tower of Eldara |achieve 852/5
	step
		goto 69.89,34.83
		.' Discover Ruins of Arkkoran |achieve 852/6
	step
		goto 58.29,51.00
		.' Discover Bilgewater Harbor |achieve 852/3
	step
		goto 68.41,75.62
		.' Discover Southridge Beach |achieve 852/13
	step
		goto 64.65,79.31
		.' Discover Ravencrest Monument |achieve 852/14
	step
		goto 56.99,76.50
		.' Discover Storm Cliffs |achieve 852/17
	step
		goto 46.54,76.25
		.' Discover The Secret Lab |achieve 852/8
	step
		goto 39.83,84.67
		.' Discover The Ruined Reaches |achieve 852/16
	step
		goto 35.72,73.99
		.' Discover Lake Mennar |achieve 852/15
	step
		goto 26.75,77.96
		.' Discover Orgrimmar Rear Gate |achieve 852/11
	step
		goto 21.04,57.1
		.' Discover Gallywix Pleasure Palace |achieve 852/1
	step
		goto 39.21,55.46
		.' Discover The Shattered Strand |achieve 852/2
	step
		goto 31.95,50.02
		.' Discover Ruins of Eldarath |achieve 852/12
	step
		goto 25.47,38.00
		.' Discover Bear's Head |achieve 852/9
	step
		goto 33.06,32.76
		.' Discover Blackmaw Hold |achieve 852/10
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
		goto 43.96,39.82 
		.' Discover Withering Thicket |achieve 844/5
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
		goto 55.0,91.0
		.' Rut'theran Village |achieve 842/12
	step
		goto 58.4,33.0
		.' Discover Shadowglen |achieve 842/1
	step
		goto 50.7,38.0
		.' Discover The Cleft |achieve 842/2
	step
		goto 46.16,50.68 
		.' Ban'ethil Hollow |achieve 842/4
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

ZygorGuidesViewer:RegisterInclude("Explorer_EasternKingdoms",[[
	step
		' This guide assumes you have a flying mount and can fly in Azeroth as well. You can do this
		.' without having a flying mount but it will be much more efficient with one.
		|confirm always
	step
	label	"start"
		' Explore Elwynn Forest |achieve 776
		' Explore Badlands |achieve 765
		' Explore Burning Steppes |achieve 775
		' Explore Duskwood |achieve 778
		' Explore Loch Modan |achieve 779
		' Explore Tirisfal Glades |achieve 768
		' Explore Searing Gorge |achieve 774
		' Explore Ghostlands |achieve 858
		' Explore The Cape of Stranglethorn |achieve 4995
		' Explore The Hinterlands |achieve 773
		' Explore Wetlands |achieve 841
		' Explore Western Plaguelands |achieve 770
		' Explore Isle of Quel'Danas |achieve 868
		' Explore Arathi Highlands |achieve 761
		' Explore Blasted Lands |achieve 766
		' Explore Dun Morogh |achieve 627
		' Explore Hillsbrad Foothills |achieve 772
		' Explore Redridge Mountains |achieve 780
		' Explore Eversong Woods |achieve 859
		' Explore Silverpine Forest |achieve 769
		' Explore Northern Stranglethorn |achieve 781
		' Explore Swamp of Sorrows |achieve 782
		' Explore Westfall |achieve 802
		' Explore Deadwind Pass |achieve 777
		' Explore Eastern Plaguelands |achieve 771     
		' Explore Vashj'ir |achieve 4825
		' Explore Deepholm |achieve 4864
		' Explore Twilight Highlands |achieve 4866
		|confirm
	step
		'Skipping next part of guide |next "+vashj'ir" |only if step:Find("+deepholm1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		#include "portal_deepholm"
	step
		goto Deepholm,55.8,75.4
		.' Discover Storm's Fury Wreckage |achieve 4864/5
	step
		goto 68.3,77.8
		.' Discover Twilight Overlook |achieve 4864/10
	step
		goto 62.9,58.5
		.' Discover Deathwing's Fall |achieve 4864/1
	step
		goto 74.2,40.7
		.' Discover Crimson Expanse |achieve 4864/12
	step
		goto 56.6,10.9
		.' Discover Therazane's Throne |achieve 4864/8
	step
		goto 39.8,18.6
		.' Discover The Pale Roost |achieve 4864/7
	step
		goto 26.8,32.6
		.' Discover Needlerock Chasm |achieve 4864/2
	step
		goto 21.7,47.7
		.' Discover Needlerock Slag |achieve  4864/3
	step
		goto 26.3,69.5
		.' Discover Stonehearth |achieve 4864/4
	step
		goto 35.2,80.3
		.' Discover The Quaking Fields |achieve 4864/9
	step
		goto 39.2,69.1
		.' Discover Masters' Gate |achieve 4864/11
	step
	label	"deepholm1"
		' Explore Deepholm |achieve 4864
	step
		goto Deepholm,48.5,53.8
		.' Click on the Portal to Stormwind |tip It looks like a blue and red swirling portal.
		.' Teleport to Stormwind|goto Stormwind City |noway |c
	step
	label	"vashj'ir"
		'Skipping next part of guide |next "+strangle" |only if step:Find("+vashj'ir1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		#include "portal_vashjir"
	step
		goto Abyssal Depths,54.1,63.9
		.' Discover Korthun's End |achieve 4825/5
	step
		goto 42.2,70.0
		.' Discover Underlight Canyon |achieve 4825/3
	step
		goto 22.1,80.2
		.' Discover Abandoned Reef |achieve 4825/1
	step
		goto 32.3,54.1
		.' Discover L'ghorek |achieve 4825/6
	step
		goto 39.4,19.3
		.' Discover Deepfin Ridge |achieve 4825/4
	step
		goto 54.9,43.5
		.' Discover Seabrush |achieve 4825/7
	step
		goto 71.5,29.8
		.' Discover Abyssal Breach |achieve 4825/2
	step
		goto Shimmering Expanse,50.9,21.5
		.' Discover Shimmering Grotto |achieve 4825/20
	step
		goto 47.9,37.8
		.' Discover Silver Tide Hollow |achieve 4825/21
	step
		goto 43.6,48.4
		.' Discover Glimmerdeep Gorge |achieve 4825/9
	step
		goto 33.7,72.4
		.' Discover Ruins of Vashj'ir |achieve 4825/19
	step
		goto 55.4,83.0
		.' Discover Beth'mora Ridge |achieve 4825/16
	step
		goto 59.2,56.5
		.' Discover Nespirah |achieve 4825/17
	step
		goto 66.4,41.7
		.' Discover Ruins of Thelserai Temple |achieve 4825/18
	step
		goto Kelp'thar Forest,58.8,81.4
		.' Discover The Clutch |achieve 4825/12
	step
		goto 61.5,58.9
		.' Discover Gnaws' Boneyard |achieve 4825/10
	step
		goto 53.2,56.2
		.' Discover Gurboggle's Ledge |achieve 4825/11
	step
		goto 39.7,29.7
		.' Discover Legion's Fate |achieve 4825/14
	step
		goto 50.3,24.1 
		.' Discover Seafarer's Tomb |achieve 4825/13
	step
		goto Kelp'thar Forest,64.8,49.3
		.' Discover The Skeletal Reef |achieve 4825/15
	step
	label	"vashj'ir1"
		' Explore Vashj'ir |achieve 4825
	step
		#include "hearth"
	step
	label	"strangle"
		'Skipping next part of guide |next "+n_strangle" |only if step:Find("+strangle1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto The Cape of Stranglethorn,39.7,71.0
		.' Discover Booty Bay |achieve 4995/1
	step
		goto 43.5,81.4
		.' Discover The Wild Shore |achieve 4995/10
	step
		goto 60.8,81.6
		.' Discover Jaquero Isle |achieve 4995/5
	step
		goto 50.5,58.1
		.' Discover Mistvale Valley |achieve 4995/6
	step
		goto 43.0,49.1
		.' Discover Nek'mani Wellspring |achieve 4995/7
	step
		goto 34.1,32.4
		.' Discover Hardwrench Hideaway |achieve 4995/4
	step
		goto 46.3,22.5
		.' Discover Gurubashi Arena |achieve 4995/3
	step
		goto 54.4,30.3
		.' Discover Ruins of Jubuwal |achieve 4995/9
	step
		goto 62.2,43.7
		.' Discover Ruins of Aboraz |achieve 4995/8
	step
		goto 62.4,28.1
		.' Discover Crystalvein Mine |achieve 4995/2
	step
	label	"strangle1"
		' Explore The Cape of Stranglethorn |achieve 4995
	step
	label	"n_strangle"
		'Skipping next part of guide |next "+westfall" |only if step:Find("+n_strangle1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Northern Stranglethorn,53.2,66.0
		.' Discover Fort Livingston |achieve 781/4
	step
		goto 59.0,55.2
		.' Discover Balia'mah Ruins |achieve 781/2
	step
		goto 66.9,50.9
		.' Discover Mosh'Ogg Ogre Mound |achieve 781/11
	step
		goto 64.7,39.7
		.' Discover Bambala |achieve 781/3
	step
		goto 83.9,32.5
		.' Discover Zul'Gurub |achieve 781/16
	step
		goto 60.2,19.9
		.' Discover Kurzen's Compound |achieve 781/8
	step
		goto 46.7,9.5
		.' Discover Rebel Camp |achieve 781/7
	step
		goto 44.1,19.8
		.' Discover Nesingwary's Expedition |achieve 781/6
	step
		goto 42.2,38.4
		.' Discover Kal'ai Ruins |achieve 781/9
	step
		goto 46.1,52.9
		.' Discover Mizjah Ruins |achieve 781/10
	step
		goto 37.8,48.4
		.' Discover Grom'gol Base Camp |achieve 781/1
	step
		goto 33.0,42.5
		.' Discover The Vile Reef |achieve 781/14
	step
		goto 34.3,36.2
		.' Discover Bal'lal Ruins |achieve 781/13
	step
		goto 19.2,25.6
		.' Discover Zuuldaia Ruins |achieve 781/5
	step
		goto 26.4,20.2
		.' Discover Ruins of Zul'Kunda |achieve 781/15
	step
	label	"n_strangle1"
		' Explore Northern Stranglethorn |achieve 781
	step
	label	"westfall"
		'Skipping next part of guide |next "+duskwood" |only if step:Find("+westfall1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Westfall,63.4,72.5
		.' Discover The Dust Plains |achieve 802/14
	step
		goto 44.9,82.0
		.' Discover The Dagger Hills |achieve 802/12
	step
		goto 30.0,86.8
		.' Discover Westfall Lighthouse |achieve 802/11
	step
		goto 33.9,73.6
		.' Discover Demont's Place |achieve 802/10
	step
		goto 42.4,65.5
		.' Discover Moonbrook |achieve 802/8
	step
		goto 38.2,52.3
		.' Discover Alexston Farmstead |achieve 802/9
	step
		goto 39.2,43.2
		.' Discover The Raging Chasm |achieve 802/13
	step
		goto 45.3,34.9
		.' Discover the Molsen Farm |achieve 802/6
	step
		goto 44.9,23.9
		.' Discover Jangolode Mine |achieve 802/5
	step
		goto 51.0,21.4
		.' Discover Furlbrow's Pumpkin Farm |achieve 802/3
	step
		goto 57.7,15.8
		.' Discover The Jansen Stead |achieve 802/4
	step
		goto 54.4,32.3
		.' Discover Saldean's Farm |achieve 802/2
	step
		goto 55.9,49.3
		.' Discover Sentinel Hill |achieve 802/1
	step
		goto 61.5,59.2
		.' Discover the Dead Acre |achieve 802/7
	step
	label	"westfall1"
		' Explore Westfall |achieve 802
	step
	label	"duskwood"
		'Skipping next part of guide |next "+deadwind" |only if step:Find("+duskwood1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Duskwood,10.1,44.3
		.' Discover The Hushed Bank |achieve 778/1
	step
		goto 19.6,41.3
		.' Discover Raven Hill Cemetery |achieve 778/4
	step
		goto 19.8,55.2
		.' Discover Raven Hill |achieve 778/3
	step
		goto 21.4,69.9
		.' Discover Addle's Stead |achieve 778/2
	step
		goto 35.8,72.7
		.' Discover Vul'Gol Ogre Mound |achieve 778/5
	step
		goto 51.0,74.0
		.' Discover The Yorgen Farmstead |achieve 778/7
	step
		goto 63.8,71.9
		.' Discover The Rotting Orchard |achieve 778/9
	step
		goto 46.8,38.6
		.' Discover Twilight Grove |achieve 778/6
	step
		goto 54.6,21.2
		.' Discover The Darkened Bank |achieve 778/13
	step
		goto 64.7,37.7
		.' Discover Brightwood Grove |achieve 778/8
	step
		goto 77.1,35.9
		.' Discover Manor Mistmantle |achieve 778/12
	step
		goto 74.5,46.2
		.' Discover Darkshire |achieve 778/11
	step
		goto 79.7,66.1
		.' Discover Tranquil Gardens Cemetery |achieve 778/10
	step
	label	"duskwood1"
		' Explore Duskwood |achieve 778
	step
	label	"deadwind"
		'Skipping next part of guide |next "+blasted" |only if step:Find("+deadwind1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Deadwind Pass,45.1,35.8
		.' Discover Deadman's Crossing |achieve 777/1
	step
		goto 42.6,68.8
		.' Discover Karazhan |achieve 777/3
	step
		goto 58.6,64.7
		.' Discover The Vice |achieve 777/2
	step
	label	"deadwind1"
		' Explore Deadwind Pass |achieve 777
	step
	label	"blasted"
		'Skipping next part of guide |next "+swamp" |only if step:Find("+blasted1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Blasted Lands,39.5,12.9
		.' Discover Dreadmaul Hold |achieve 766/1
	step
		goto 45.1,26.7
		.' Discover Rise of the Defiler |achieve 766/9
	step
		goto 47.1,40.1
		.' Discover Dreadmaul Post |achieve 766/7
	step
		goto 54.4,52.9
		.' Discover The Dark Portal |achieve 766/5
	step
		goto 32.3,45.7
		.' Discover The Tainted Scar |achieve 766/8
	step
		goto 34.2,72.3
		.' Discover The Tainted Forest |achieve 766/14
	step
		goto 44.5,86.1
		.' Discover Surwich |achieve 766/12
	step
		goto 50.7,70.9
		.' Discover Sunveil Excursion |achieve 766/11
	step
		goto 65.8,78.0
		.' Discover The Red Reaches |achieve 766/13
	step
		goto 69.1,33.5
		.' Discover Shattershore |achieve 766/10
	step
		goto 60.3,28.4
		.' Discover Serpent's Coil |achieve 766/4
	step
		goto 64.3,15.8
		.' Discover Nethergare Keep |achieve 766/3
	step
	label	"blasted1"
		' Explore Blasted Lands |achieve 766
	step
	label	"swamp"
		'Skipping next part of guide |next "+redridge" |only if step:Find("+swamp1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Swamp of Sorrows,67.8,74.9
		.' Discover Stagalbog |achieve 782/7
	step
		goto 84.2,38.9
		.' Discover Sorrowmurk |achieve 782/8
	step
		goto 77.3,13.7
		.' Discover Misty Reed Strand |achieve 782/10
	step
		goto 72.3,12.8
		.' Discover Bogpaddle |achieve 782/9
	step
		goto 68.4,35.8
		.' Discover Marshtide Watch |achieve 782/12
	step
		goto 62.6,50.0
		.' Discover Pool of Tears |achieve 782/6
	step
		goto 48.8,42.1
		.' Discover The Shifting Mire |achieve 782/4
	step
		goto 47.1,54.2
		.' Discover Stonard |achieve 782/5
	step
		goto 18.6,68.1
		.' Discover Purespring Cavern |achieve 782/11
	step
		goto 22.3,49.4
		.' Discover Splinterspear Junction |achieve 782/3
	step
		goto 14.7,35.8
		.' Misty Valley |achieve 782/1
	step
		goto 28.8,32.1
		.' Discover The Harborage |achieve 782/2
	step
	label	"swamp1"
		' Explore Swamp of Sorrows |achieve 782
	step
	label	"redridge"
		'Skipping next part of guide |next "+elwynn" |only if step:Find("+redridge1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Redridge Mountains,38.2,68.5
		.' Discover Lakeridge Highway |achieve 780/4
	step
		goto 41.9,52.6
		.' Discover Lake Everstill |achieve 780/2
	step
		goto 53.4,54.7
		.' Discover Camp Everstill |achieve 780/13
	step
		goto 60.9,52.5
		.' Discover Stonewatch Keep |achieve 780/10
	step
		goto 64.7,71.3
		.' Discover Render's Valley |achieve 780/8
	step
		goto 81.0,62.4
		.' Discover Shalewind Canyon |achieve 780/12
	step
		goto 47.2,39.2
		.' Discover Alther's Mill |achieve 780/6
	step
		goto 35.1,12.8
		.' Discover Render's Camp |achieve 780/9
	step
		goto 30.2,26.1
		.' Discover Redridge Canyons |achieve 780/5
	step
		goto 25.5,43.4
		.' Discover Lakeshire |achieve 780/1
	step
		goto 19.7,59.1
		.' Discover Three Corners |achieve 780/3
	step
	label	"redridge1"
		' Explore Redridge Mountains |achieve 780
	step
	label	"elwynn"
		'Skipping next part of guide |next "+burning" |only if step:Find("+elwynn1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Elwynn Forest,83.5,66.9
		.' Discover Eastvale Logging Camp |achieve 776/8
	step
		goto 84.8,79.4
		.' Discover Ridgepoint Tower |achieve 776/9
	step
		goto 69.4,79.4
		.' Discover Brackwell Pumpkin Patch |achieve 776/7
	step
		goto 64.6,69.3
		.' Discover Tower of Azora |achieve 776/6
	step
		goto 52.9,66.2
		.' Discover Crystal Lake |achieve 776/10
	step
		goto 48.5,85.8
		.' Discover Jerod's Landing |achieve 776/5
	step
		goto 39.5,80.3
		.' Discover Fargodeep Mine |achieve 776/4
	step
		goto 24.5,73.3
		.' Discover Westbrook Garrison |achieve 776/2
	step
		goto 42.1,64.7
		.' Discover Goldshire |achieve 776/3
	step
		goto 50.4,42.5
		.' Discover Northshire Valley |achieve 776/1
	step
		goto 74.0,51.5
		.' Discover Stone Cairn Lake |achieve 776/11
	step
	label	"elwynn1"
		' Explore Elwynn Forest |achieve 776
	step
	label	"burning"
		'Skipping next part of guide |next "+searing" |only if step:Find("+burning1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Burning Steppes,66.7,77.5
		.' Discover Blackrock Pass |achieve 775/4
	step
		goto 73.5,68.0
		.' Discover Morgan's Vigil |achieve 775/2
	step
		goto 73.9,53.4
		.' Discover Terror Wing Path |achieve 775/3
	step
		goto 69.7,40.5
		.' Discover Dreadmaul Rock |achieve 775/1
	step
		goto 56.6,37.4
		.' Discover Ruins of Thaurissan |achieve 775/5
	step
		goto 36.1,53.5
		.' Discover Black Tooth Hovel |achieve 775/6
	step
		goto 24.3,57.7
		.' Discover The Whelping Downs |achieve 775/8
	step
		goto 32.3,36.5
		.' Discover Blackrock Stronghold |achieve 775/7
	step
		goto 20.7,29.2
		.' Discover Blackrock Mountain |achieve 775/10
	step
		goto 9.4,27.5
		.' Discover Altar of Storms |achieve 775/9
	step
	label	"burning1"
		' Explore Burning Steppes |achieve 775
	step
	label	"searing"
		'Skipping next part of guide |next "+dun" |only if step:Find("+searing1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Searing Gorge,39.9,82.9
		.' Discover Blackrock Mountain |achieve 774/8
	step
		goto 21.2,80.1
		.' Discover Balckchar Cave |achieve 774/3
	step
		goto 23.8,31.8
		.' Discover Firewatch Ridge |achieve 774/1
	step
		goto 37.7,29.9
		.' Discover Thorium Point |achieve 774/7
	step
		goto 52.7,49.6
		.' Discover The Cauldron |achieve 774/2
	step
		goto 71.8,26.8
		.' Discover Dustfire Valley |achieve 774/6
	step
	label	"searing1"
		' Explore Searing Gorge |achieve 774
	step
	label	"dun"
		'Skipping next part of guide |next "+loch" |only if step:Find("+dun1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Dun Morogh,84.1,51.8
		.' Discover Helm's Bed Lake |achieve 627/10
	step
		goto 76.5,57.2
		.' Discover Gol'Bolar Quarry |achieve 627/11
	step
		goto 71.5,46.2
		.' Discover Amberstill Ranch |achieve 627/9
	step
		goto 67.2,53.9
		.' Discover The Tundrid Hills |achieve 627/8
	step
		goto 58.6,57.7
		.' Discover Frostmane Front |achieve 627/3
	step
		goto 53.6,50.5
		.' Discover Kharanos |achieve 627/7
	step
		goto 48.3,52.8
		.' Discover The Grizzled Den |achieve 627/14
	step
		goto 43.9,64.5
		.' Discover Coldridge Pass |achieve 627/1
	step
		goto 34.6,75.6
		.' Discover Coldridge Valley |achieve 627/2
	step
		goto 31.5,51.9
		.' Discover Frostmane Hold |achieve 627/13
	step
		goto 33.8,37.5
		.' Discover New Tinkertown |achieve 627/4
	step
		goto 41.4,40.2
		.' Discover Iceflow Lake |achieve 627/15
	step
		goto 48.3,37.9
		.' Discover Shimmer Ridge |achieve 627/6
	step
		goto 59.6,33.8
		.' Discover Gates of Ironforge |achieve 627/16
	step
		goto 78.0,24.2
		.' Discover Ironforge Airfield |achieve 627/5
	step
		goto 90.3,37.6
		.' Discover North Gate Outpost |achieve 627/12
	step
	label	"dun1"
		' Explore Dun Morogh |achieve 627
	step
	label	"loch"
		'Skipping next part of guide |next "+twilight" |only if step:Find("+loch1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Loch Modan,20.3,78.5
		.' Discover Valley of Kings |achieve 779/11
	step
		goto 32.5,78.3
		.' Discover Stonesplinter Valley |achieve 779/10
	step
		goto 38.0,60.7
		.' Discover Grizzlepaw Ridge |achieve 779/8
	step
		goto 69.4,65.3
		.' Discover Ironband's Excavation Site |achieve 779/7
	step
		goto 82.3,65.0
		.' Discover The Farstrider Lodge |achieve 779/6
	step
		goto 71.0,23.8
		.' Discover Mo'grosh Stronghold |achieve 779/3
	step
		goto 35.2,47.6
		.' Discover Thelsamar |achieve 779/9
	step
		goto 20.2,17.1
		.' Discover North Gate Pass |achieve 779/5
	step
		goto 34.8,21.5
		.' Discover Silver Stream Mine |achieve 779/4
	step
		goto 48.0,11.4
		.' Discover Stonewrought Dam |achieve 779/2
	step
	label	"loch1"
		' Explore Loch Modan |achieve 779
	step
	label	"twilight"
		'Skipping next part of guide |next "+wetlands" |only if step:Find("+twilight1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Twilight Highlands,18.9,51.4
		.' Discover Grim Batol |achieve 4866/10
	step
		goto 28.18,37.67
		.' Discover Dragonmaw Pass |achieve 4866/4 
	step
		goto 29.0,47.8
		.' Discover Wyrms' Bend |achieve 4866/26
	step
		goto 36.39,38.03 
		.' The Gullet |achieve 4866/19
	step
		goto 39.9,46.6
		.' The Twilight Breach |achieve 4866/21
	step
		goto 43.2,58.1
		.' Discover Victor's Point |achieve 4866/25
	step
		goto 46.1,77.2
		.' Discover Crushblow |achieve 4866/3
	step
		goto 49.5,68.8
		.' Discover Dunwald Ruins |achieve 4866/6
	step
		goto 64.4,78.9
		.' Discover Obsibian Forest |achieve 4866/15
	step
		goto 71.0,70.9
		.' Discover Twilight Shore |achieve 4866/23
	step
		goto 80.7,76.8
		.' Discover Highbank |achieve 4866/11
	step
		goto 76.0,53.0
		.' Discover Dragonmaw Port |achieve 4866/5
	step
		goto 59.9,57.0
		.' Discover Firebeards's Patrol |achieve 4866/7
	step
		goto 54.0,62.9
		.' Discover Highland Forest |achieve 4866/12
	step
		goto 50.7,56.9
		.' Discover Crucible of Carnage |achieve 4866/2
	step
		goto 54.1,42.7
		.' Discover Bloodgulch |achieve 4866/1
	step
		goto 62.7,46.0
		.' Discover Gorshak War Camp |achieve 4866/9
	step
		goto 71.0,38.8
		.' Discover Slithering Cove |achieve 4866/17
	step
		goto 76.8,14.5
		.' Discover The Krazzworks |achieve 4866/20
	step
		goto 54.9,17.3
		.' Discover Kirthaven |achieve 4866/14
	step
		goto 57.9,30.3
		.' Discover The Black Breach |achieve 4866/18
	step
		goto 50.2,29.1
		.' Discover Thundermar |achieve 4866/22
	step
		goto 47.8,10.6
		.' The Maw of Madness |achieve 4866/27
	step
		goto 43.6,18.1
		.' Ruins of Drakgor |achieve 4866/16
	step
		goto 44.3,27.3
		.' Discover Humboldt Conflagration |achieve 4866/13
	step
		goto 38.3,29.0
		.' Discover Glopgut's Hollow |achieve 4866/8
	step
		goto 25.3,21.0
		.' Discover Vermillion Redoubt |achieve 4866/24
	step
	label	"twilight1"
		' Explore Twilight Highlands |achieve 4866
	step
	label	"wetlands"
		'Skipping next part of guide |next "+arathi" |only if step:Find("+wetlands1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Wetlands,67.9,34.9
		.' Discover Raptor Ridge |achieve 841/16
	step
		goto 57.9,40.6
		.' Discover Greenwarden's Grove |achieve 841/11
	step
		goto 61.9,56.6
		.' Discover Mosshide Fen |achieve 841/12
	step
		goto 58.4,71.0
		.' Discover Slabchisel's Survey |achieve 841/15
	step
		goto 50.0,76.4
		.' Discover Dun Algaz |achieve 841/14
	step
		goto 52.2,61.4
		.' Discover Thelgen Rock |achieve 841/10
	step
		goto 48.5,48.0
		.' Discover Angerfang Encampment |achieve 841/9
	step
		goto 35.8,48.9
		.' Discover Whelgar's Excavation Site |achieve 841/4
	step
		goto 10.2,58.2
		.' Discover Menethil Harbor |achieve 841/1
	step
		goto 19.3,46.9
		.' Discover Black Channel Marsh |achieve 841/2
	step
		goto 18.9,36.0
		.' Discover Bluegill Marsh |achieve 841/3
	step
		goto 24.5,24.3
		.' Discover Sundown Marsh |achieve 841/5
	step
		goto 32.5,17.6
		.' Discover Saltspray Glen |achieve 841/6
	step
		goto 43.6,25.9
		.' Discover Ironbeard's Tomb |achieve 841/7
	step
		goto 46.9,16.5
		.' Discover Dun Modr |achieve 841/8
	step
	label	"wetlands1"
		' Explore Wetland |achieve 841
	step
	label	"arathi" 
		'Skipping next part of guide |next "+hillsbrad" |only if step:Find("+arathi1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Arathi Highlands,41.3,91.0
		.' Discover Thandol Span |achieve 761/8
	step
		goto 49.1,78.9
		.' Discover Boulderfist Hall |achieve 761/9
	step
		goto 61.6,70.3
		.' Discover Witherbark Village |achieve 761/12
	step
		goto 56.4,57.6
		.' Discover Go'Shek Farm |achieve 761/13
	step
		goto 69.3,37.2
		.' Discover Hammerfall |achieve 761/16
	step
		goto 59.3,32.8
		.' Discover Circle of East Binding |achieve 761/15
	step
		goto 49.9,41.3
		.' Discover Dabyrie's Farmstead |achieve 761/14
	step
		goto 47.3,51.4
		.' Discover Circle of Outer Binding |achieve 761/11
	step
		goto 39.8,46.4
		.' Discover Refuge Pointe |achieve 761/10
	step
		goto 30.1,59.3
		.' Discover Circle of Inner Binding |achieve 761/7
	step
		goto 23.8,81.8
		.' Discover Faldir's Cove |achieve 761/6
	step
		goto 16.5,64.1
		.' Discover Stromgarde Keep |achieve 761/5
	step
		goto 27.5,44.2
		.' Discover Boulder'gor |achieve 761/3
	step
		goto 27.0,27.1
		.' Discover Northfold Manor |achieve 761/2
	step
		goto 13.0,36.4
		.' Discover Galen's Fall |achieve 761/4
	step
	label	"arathi1"
		' Explore Arathi Highlands |achieve 761
	step
	label	"hillsbrad"
		'Skipping next part of guide |next "+silver" |only if step:Find("+hillsbrad1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Hillsbrad Foothills,68.3,60.0
		.' Discover Durnholde Keep |achieve 772/10
	step
		goto 68.1,32.9
		.' Discover Chillwind Point |achieve 772/5
	step
		goto 58.3,23.4
		.' Discover Strahnbrad |achieve 772/22
	step
		goto 57.51,74.96
		.' Discover Nethander Stead |achieve 772/15
	step
		goto 52.4,12.6
		.' Discover The Uplands |achieve 772/26
	step
		goto 44.9,9.1
		.' Discover Dandred's Fold |achieve 772/7
	step
		goto 45.3,29.0
		.' Discover Ruins of Alterac |achieve 772/17
	step
		goto 43.2,38.5
		.' Discover Growless Cave |achieve 772/13
	step
		goto 55.6,38.5
		.' Discover Sofera's Naze |achieve 772/20
	step
		goto 56.7,46.9
		.' Discover Tarren Mill |achieve 772/23
	step
		goto 49.6,46.7
		.' Discover Corrahn's Dagger |achieve 772/3
	step
		goto 48.97,71.89
		.' Discover Ruins of Southshore |achieve 772/18
	step
		goto 44.2,48.6
		.' Discover The Headland |achieve 772/24
	step
		goto 40.0,47.6
		.' Discover Gavin's Naze |achieve 772/12
	step
		goto 35.06,26.14
		.' Discover Misty Shore |achieve 772/14
	step
		goto 33.8,46.5
		.' Discover Brazie Farmstead |achieve 772/2
	step
		goto 30.4,36.2
		.' Discover Dalaran Crater |achieve 772/6
	step
		goto 29.5,63.6
		.' Discover Southpoint Gate |achieve 772/21
	step
		goto 34.0,73.8
		.' Discover Azurlode Mine |achieve 772/1
	step
		goto 27.0,85.6
		.' Discover Purgation Isle |achieve 772/16
	step
	label	"hillsbrad1"
		' Explore Hillsbrad Foothills |achieve 772
	step
	label	"silver"
		'Skipping next part of guide |next "+tirisfal" |only if step:Find("+silver1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Silverpine Forest,46.1,79.5
		.' Discover The Battlefront |achieve 769/1
	step
		goto 42.2,63.2
		.' Discover Shadowfang Keep |achieve 769/12
	step
		goto 50.9,66.6
		.' Discover The Forsaken Front |achieve 769/3
	step
		goto 61.2,62.4
		.' Discover Ambermill |achieve 769/11
	step
		goto 46.1,51.0
		.' Discover Olsen's Farthing |achieve 769/10
	step
		goto 45.0,40.0
		.' Discover The Sepulcher |achieve 769/8
	step
		goto 37.3,28.0
		.' Discover North Tide's Beachead |achieve 769/5
	step
		goto 34.8,12.4
		.' Discover The Skittering Dark |achieve 769/4
	step
		goto 44.9,18.8
		.' Discover Forsaken Rear Guard |achieve 769/15
	step
		goto 53.2,25.6
		.' Discover Valgan's Field |achieve 769/7
	step
		goto 56.5,34.7
		.' Discover The Decrepit Fields |achieve 769/2
	step
		goto 59.3,45.4
		.' Discover Deep Elem Mine |achieve 769/9
	step
		goto 69.1,26.8
		.' Discover Fenris Isle |achieve 769/6
	step
		goto 62.0,8.7
		.' Discover Forsaken High Command |achieve 769/13
	step
	label	"silver1"
		' Explore Silverpine Forest |achieve 769
	step
	label	"tirisfal"
		'Skipping next part of guide |next "+w_plague" |only if step:Find("+tirisfal1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Tirisfal Glades,32.2,63.8
		.' Discover Deathknell |achieve 768/1
	step
		goto 45.1,65.4
		.' Discover Nightmare Vale |achieve 768/4
	step
		goto 53.8,58.7
		.' Discover Cold Hearth Manor |achieve 768/5
	step
		goto 46.2,51.4
		.' Discover Calston Estate |achieve 768/16
	step
		goto 38.4,48.9
		.' Discover Solliden Farmstead |achieve 768/9
	step
		goto 45.6,32.9
		.' Discover Agamand Mills |achieve 768/3
	step
		goto 56.9,35.6
		.' Discover Garren's Haunt |achieve 768/7
	step
		goto 59.7,50.9
		.' Discover Brill |achieve 768/6
	step
		goto 68.3,45.0
		.' Discover Brightwater Lake |achieve 768/8
	step
		goto 78.4,26.9
		.' Discover Scarlet Watch Post |achieve 768/11
	step
		goto 87.00,47.2
		.' Discover Venomweb Vale |achieve 768/12
	step
		goto 79.1,54.7
		.' Discover Crusader Outpost |achieve 768/10
	step
		goto 73.7,60.0
		.' Discover Balnir Farmstead |achieve 768/9
	step
		goto 84.9,69.4
		.' Discover The Bulwark |achieve 768/15
	step
	label	"tirisfal1"
		' Explore Tirisfal Glades |achieve 768
	step
	label	"w_plague"
		'Skipping next part of guide |next "+hinterlands" |only if step:Find("+w_plague1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Western Plaguelands,27.0,57.7
		.' Discover The Bulwark |achieve 770/5
	step
		goto 36.5,54.6
		.' Discover Felstone Field |achieve 770/6
	step
		goto 45.1,51.2
		.' Discover Dalson's Farm |achieve 770/7
	step
		goto 46.0,45.5
		.' Discover Redpine Dell |achieve 770/11
	step
		goto 47.2,33.4
		.' Northridge Lumber Camp |achieve 770/9
	step
		goto 44.9,17.0
		.' Discover Hearthglen |achieve 770/10
	step
		goto 64.4,40.1
		.' Discover The Weeping Cave |achieve 770/13
	step
		goto 69.6,50.7
		.' Discover Thondroril River |achieve 770/14
	step
		goto 63.9,58.2
		.' Discover Gahrron's Withering |achieve 770/12
	step
		goto 54.9,66.2
		.' Discover The Writhing Haunt |achieve 770/8
	step
		goto 54.6,85.5
		.' Discover Sorrow Hill |achieve 770/3
	step
		goto 68.3,81.1
		.' Discover Caer Darrow |achieve 770/2
	step
	label	"w_plague1"
		' Explore Western Plaguelands |achieve 770
	step
	label	"hinterlands"
		'Skipping next part of guide |next "+e_plague" |only if step:Find("+hinterlands1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto The Hinterlands,13.9,45.0
		.' Discover Aerie Peak |achieve 773/1
	step
		goto 23.1,33.5
		.' Discover Plaguemist Ravine |achieve 773/2
	step
		goto 33.3,45.6
		.' Discover Quel'Danil Lodge |achieve 773/4
	step
		goto 34.6,72.0
		.' Discover Shadra'Alor |achieve 773/5
	step
		goto 40.5,59.3
		.' Discover Valorwind Lake |achieve 773/6
	step
		goto 48.4,66.9
		.' Discover The Altar of Zul |achieve 773/9
	step
		goto 49.0,52.1
		.' Discover The Creeping Ruin |achieve 773/8
	step
		goto 63.1,74.7
		.' Discover Jintha'Alor |achieve 773/13
	step
		goto 72.7,66.1
		.' Discover The Overlook Cliffs |achieve 773/14
	step
		goto 73.2,54.2
		.' Discover Shaol'watha |achieve 773/12
	step
		goto 57.6,42.6
		.' Discover Skulk Rock |achieve 773/11
	step
		goto 62.7,24.1
		.' Discover Seradane |achieve 773/10
	step
	label	"hinterlands1"
		' Explore The Hinterlands |achieve 773
	step
	label	"e_plague"
		'Skipping next part of guide |next "+ghost" |only if step:Find("+e_plague1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Eastern Plaguelands,35.1,84.2
		.' Discover Darrowshire |achieve 771/6
	step
		goto 24.0,78.8
		.' Discover The Undercroft |achieve 771/3
	step
		goto 22.6,66.0
		.' The Marris Stead |achieve 771/2
	step
		goto 12.5,26.3
		.' Discover Terrordale |achieve 771/20
	step
		goto 26.8,9.8
		.' Discover Statholme |achieve 771/22
	step
		goto 33.6,24.4
		.' Discover Plaguewood |achieve 771/21
	step
		goto 36.1,44.8
		.' Discover The Fungal Vale |achieve 771/5
	step
		goto 35.7,68.5
		.' Discover Crown Guard Tower |achieve 771/4
	step
		goto 57.4,74.1
		.' Discover Lake Mereldar |achieve 771/9
	step
		goto 55.6,62.9
		.' Discover Corin's Crossing |achieve 771/8
	step
		goto 46.3,43.5
		.' Discover Blackwood Lake |achieve 771/15
	step
		goto 48.1,13.1
		.' Discover Quel'Lithien Lodge |achieve 771/19
	step
		goto 50.5,20.5
		.' Discover Northpass Tower |achieve 771/18
	step
		goto 62.4,41.7
		.' Discover Eastwall Tower |achieve 771/14
	step
		goto 68.7,56.5
		.' Discover Pestilent Scar |achieve 771/7
	step
		goto 75.6,75.2
		.' Discover Tyr's Hand |achieve 771/10
	step
		goto 87.1,78.5
		.' Discover Ruins of the Scarlet Enclave |achieve 771/23
	step
		goto 76.8,53.9
		.' Discover Light's Hope Chapel |achieve 771/11
	step
		goto 78.1,35.8
		.' Discover The Noxious Glade |achieve 771/13
	step
		goto 66.1,25.0
		.' Discover Northdale |achieve 771/16
	step
		goto 66.4,10.3
		.' Discover Zul'Mashar |achieve 771/17
	step
	label	"e_plague1"
		' Explore Eastern Plaguelands |achieve 771
	step
	label	"ghost"
		'Skipping next part of guide |next "+eversong" |only if step:Find("+ghost1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto 54.4,7.0
		.' Go through the Portal to Ghostlands |tip It looks like a big swirling portal.
		.' Teleport to Ghostlands |goto Ghostlands |noway |c
	step
		goto Ghostlands,48.2,84.3
		.' Discover Thalassian Pass |achieve 858/16
	step
		goto 33.1,79.9
		.' Discover Deatholme |achieve 858/10
	step
		goto 13.6,55.7
		.' Discover Windrunner Spire |achieve 858/13
	step
		goto 17.9,41.4
		.' Discover Windrunner Village |achieve 858/4
	step
		goto 25.0,15.0
		.' Discover Goldenmist Village |achieve 858/3
	step
		goto 33.4,32.2
		.' Discover Sanctum of the Moon |achieve 858/5
	step
		goto 34.2,46.7
		.' Discover Bleeding Ziggurat |achieve 858/14
	step
		goto 41.2,49.7
		.' Discover Howling Ziggurat |achieve 858/9
	step
		goto 47.12,32.8
		.' Discover Tranquillien |achieve 858/1
	step
		goto 56.1,47.9
		.' Sanctum of the Sun |achieve 858/6
	step
		goto 66.2,61.1
		.' Discover Zeb'Nowa |achieve 858/11
	step
		goto 77.3,64.4
		.' Discover Amani Pass |achieve 858/12
	step
		goto 77.2,32.1
		.' Discover Farstrider Enclave |achieve 858/6
	step
		goto 78.6,18.7
		.' Discover Dawnstart Spire |achieve 858/7
	step
		goto 60.46,11.7
		.' Discover Suncrown Village |achieve 858/2
	step
	label	"ghost1"
		' Explore Ghostlands |achieve 858
	step
	label	"eversong"
		'Skipping next part of guide |next "+isle_q" |only if step:Find("+eversong1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Eversong Woods,36.2,86.0
		.' Discover The Scorched Grove |achieve 859/13
	step
		goto 44.1,85.8
		.' Discover Runestone Falithas |achieve 859/19
	step
		goto 55.8,84.2
		.' Discover Rusestone Shan'dor |achieve 859/20
	step
		goto 62.2,79.3
		.' Discover Zeb'Watha |achieve 859/25
	step
		goto 65.9,78.6
		.' Discover Lake Elrendar |achieve 859/18
	step
		goto 72.0,79.3
		.' Discover Tor'Watha |achieve 859/12
	step
		goto 64.6,73.1
		.' Discover Elreandar Falls |achieve 859/16
	step
		goto 61.2,63.7
		.' Discover Farstrider Rereat |achieve 859/7
	step
		goto 55.7,56.4
		.' Discover Stillwhisper Pond |achieve 859/8
	step
		goto 60.6,54.2
		.' Discover Thuron's Livery |achieve 859/23
	step
		goto 71.6,45.3
		.' Discover Azurebreeze Coast |achieve 859/15
	step
		goto 52.4,39.4
		.' Disocver Silvermoon City |achieve 859/14
	step
		goto 31.3,16.0
		.' Discover Sunstrider Isle |achieve 859/1
	step
		goto 42.9,39.3
		.' Discover Ruins of Silvermoon |achieve 859/2
	step
		goto 42.7,50.4
		.' Discover North Sanctum |achieve 859/5
	step
		goto 35.3,57.6
		.' Discover West Sanctum |achieve 859/3
	step
		goto 28.5,57.8
		.' Discover Tranquil Shore |achieve 859/24
	step
		goto 29.4,69.3
		.' Discover Sunsail Anchorage |achieve 859/4
	step
		goto 23.5,74.8
		.' Discover Golden Strand |achieve 859/22
	step
		goto 33.4,77.6
		.' Discover Goldenbough Pass |achieve 859/17
	step
		goto 38.3,73.5
		.' Discover Saltheril's Haven |achieve 859/21
	step
		goto 43.9,73.7
		.' Discover Fairbreeze Village |achieve 859/10
	step
		goto 52.3,73.1
		.' Discover East Sanctum |achieve 859/6
	step
		goto 54.2,71.9
		.' Discover The Living Wood |achieve 859/11
	step
		goto 36.2,86.0
		.' Discover The Scorched Grove |achieve 859/13
	step
	label	"eversong1"
		' Explore Eversong Woods |achieve 859
	step
	label	"isle_q"
		'Skipping next part of guide |next "+end" |only if step:Find("+isle_q1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		|fly Shattered Sun Staging Area
	step
	label	"isle_q1"
		' Explore Isle of Quel'Danas |achieve 868
	step
	label	"end"
		' Congratulations! You have Explored the Eastern Kingdoms |achieve 42 |only if achieved(42)
		.' Congratulations! You have Explored Cataclysm |achieve 4868 |only if achieved(4868)
		' Congratulations! You have Earned the Achievement World Explorer! |achieve 46 |only if achieved(46)
		.' You have not explored all of Eastern Kingdoms yet |only if not achieved(42)
		|confirm |next "start" |only if not achieved(42)
]])

ZygorGuidesViewer:RegisterInclude("Explorer_Outlands",[[
	step
		' This guide assumes you have a flying mount. You can do this guide
		.' without having a flying mount but it will be much more efficient with one.
		|confirm always
	step
	label	"start"
		' Explore Hellfire Peninsula |achieve 862
		' Explore Terokkar Forest |achieve 867
		' Explore Shadowmoon Valley |achieve 864
		' Explore Nagrand |achieve 866
		' Explore Zangarmarsh |achieve 863
		' Explore Blade's Edge Mountains |achieve 865
		' Explore Netherstorm |achieve 843                 
		|confirm always
	step
		#include "darkportal"
	step
		'Skipping next part of guide |next "+terokkar" |only if step:Find("+hellfire1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Hellfire Peninsula,87.7,50.3
		.' Discover The Stair of Destiny |achieve 862/1
	step
		goto 62.0,17.8
		.' Discover Throne of Kil'jaeden |achieve 862/12
	step
		goto 58.9,31.2
		.' Discover Forge Camp: Mageddon |achieve 862/18
	step
		goto 55.4,38.7
		.' Disocver Thrallmar |achieve 862/11
	step
		goto 70.0,50.4
		.' Discover The Legion Front |achieve 862/10
	step
		goto 79.1,72.9
		.' Discover Void Ridge |achieve 862/16
	step
		goto 70.1,73.6
		.' Discover Zeth'Gor |achieve 862/13
	step
		goto 54.3,84.3
		.' Discover Expedition Armory |achieve 862/2
	step
		goto 45.3,82.5
		.' Discover The Warp Fields |achieve 862/17
	step
		goto 54.8,64.5
		.' Discover Honor Hold |achieve 862/5
	step
		goto 47.2,52.9
		.' Discover Hellfire Citadel |achieve 862/4 
	step
		goto 41.2,32.6
		.' Discover Pools of Aggonar |achieve 862/7
	step
		goto 31.3,26.9
		.' Discover Mag'har Post |achieve 862/6
	step
		goto 23.5,40.0
		.' Discover Temple of Telhamat |achieve 862/9 
	step
		goto 26.9,62.3
		.' Discvoer Falcon Watch |achieve 862/3
	step
		goto 27.5,77.0
		.' Discover Den of Haal'esh |achieve 862/14
	step
		goto 14.3,41.0
		.' Discover Fallen Sky Ridge |achieve 862/15
	step
		goto 13.3,59.4
		.' Discover Ruins of Sha'naar |achieve 862/8
	step
	label	"hellfire1"
		' Explore Hellfire Peninsula |achieve 862
	step
	label	"terokkar"
		'Skipping next part of guide |next "+shadowmoon" |only if step:Find("+terokkar1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Terokkar Forest,59.9,17.0
		.' Discover Razorthorn Shelf |achieve 867/11
	step
		goto 53.0,29.1
		.' Discover Tuurem |achieve 867/7
	step
		goto 43.8,20.2
		.' Discover Cenarion Thicket |achieve 867/3
	step
		goto 29.1,23.3
		.' Discover Shattrath City |achieve 867/8
	step
		goto 22.4,10.5
		.' Discover The Barrier Hills |achieve 867/10
	step
		goto 17.8,65.4
		.' Discover Bleeding Hollow Ruins |achieve 867/1
	step
		goto 24.4,59.9
		.' Discover Veil Rhaze |achieve 867/19
	step
		goto 31.3,52.5
		.' Discover Shadow Tomb |achieve 867/17
	step
		goto 37.5,49.6
		.' Discover Refugee Caravan |achieve 867/15
	step
		goto 42.9,51.0
		.' Discover Carrion Hill |achieve 867/14
	step
		goto 39.5,39.4
		.' Discover Grangol'var Village |achieve 867/5
	step
		goto 46.6,43.0
		.' Discover Stonebreaker Hold |achieve 867/6
	step
		goto 60.6,40.2
		.' Discover Raastok Glade |achieve 867/9
	step
		goto 71.7,34.7
		.' Discover Firewing Point |achieve 867/4
	step
		goto 66.5,52.3
		.' Discover Bonechewer Ruins |achieve 867/12
	step
		goto 57.1,56.6
		.' Discover Allerian Stronghold |achieve 867/2
	step
		goto 49.1,66.0
		.' Discover Writhing Mound |achieve 867/20
	step
		goto 39.5,65.5
		.' Discover Ring of Observance |achieve 867/16
	step
		goto 33.0,71.8
		.' Discover Auchenai Grounds |achieve 867/13
	step
		goto 43.9,76.1
		.' Discover Derelict Caravan |achieve 867/18
	step
		goto 58.9,76.4
		.' Discover Skettis |achieve 867/21
	step
	label	"terokkar1"
		' Explore terokkar Forest |achieve 867
	step
	label	"shadowmoon"
		'Skipping next part of guide |next "+nagrand" |only if step:Find("+shadowmoon1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Shadowmoon Valley,24.1,39.2
		.' Discover Legion Hold |achieve 864/3
	step
		goto 29.8,52.3
		.' Discover Illidari Point |achieve 864/12
	step
		goto 35.5,60.2
		.' Discover Wildhammer Stronghold |achieve 864/10 
	step
		goto 44.9,66.8
		.' Discover Eclipse Point |achieve 864/2
	step
		goto 70.8,85.7
		.' Discover Netherwing Ledge |achieve 864/4
	step
		goto 64.2,58.5
		.' Discover Netherwing Fields |achieve 864/15
	step
		goto 57.3,50.1
		.' Discover Warden's Cage |achieve 864/9
	step
		goto 49.8,41.2
		.' Discover The Hand of Gul'dan |achieve 864/8 
	step
		goto 39.6,39.6
		.' Discover The Deathforge |achieve 864/7
	step
		goto 29.4,26.1
		.' Discover Shadowmoon Village |achieve 864/5
	step
		goto 45.3,26.3
		.' Discover Coilskar Point |achieve 864/1
	step
		goto 61.5,26.1
		.' Discover Altar of Sha'tar |achieve 864/11
	step
		goto 77.6,40.6
		.' Discover The Black Temple |achieve 864/6
	step
	label	"shadowmoon1"
		' Explore Shadowmoon Valley |achieve 864
	step
	label	"nagrand"
		'Skipping next part of guide |next "+zangar" |only if step:Find("+nagrand1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Nagrand,74.3,52.9
		.' Discover Windyreed Village |achieve 866/18
	step
		goto 75.1,66.8
		.' Discover Burning Blade Ruins |achieve 866/12
	step
		goto 68.9,79.9
		.' Discover Kil'sorrow Fortress |achieve 866/4
	step
		goto 62.5,64.3
		.' Discover Clan Watch |achieve 866/13
	step
		goto 65.8,54.0
		.' Discover The Ring of Trials |achieve 866/9
	step
		goto 49.8,55.9
		.' Discover Southwind Cleft |achieve 866/15
	step
		goto 52.8,69.1
		.' Discover Telaar |achieve 866/8
	step
		goto 42.0,71.8
		.' Discover Spirit Fields |achieve 866/6
	step
		goto 42.5,44.0
		.' Discover Halaa |achieve 866/3
	step
		goto 33.5,44.7
		.' Discover Sunspring Post |achieve 866/7
	step
		goto 20.6,51.3
		.' Discover Forge Camp: Fear |achieve 866/1
	step
		goto 10.8,39.2
		.' Discover The Twilight Ridge |achieve 866/16
	step
		goto 25.9,37.1
		.' Discover Forge Camp: Hate |achieve 866/14
	step
		goto 29.7,24.6
		.' Discover Warmaul Hill |achieve 866/11
	step
		goto 33.9,18.4
		.' Discover Zangar Ridge |achieve 866/19
	step
		goto 46.9,18.9
		.' Discover Laughing Skull Ruins |achieve 866/5
	step
		goto 56.1,36.4
		.' Discover Garadar |achieve 866/2
	step
		goto 60.8,21.1
		.' Discover Throne of the Elements |achieve 866/10
	step
		goto 72.4,36.3
		.' Discover Windyreed Pass |achieve 866/17
	step
	label	"nagrand1"
		' Explore Nagrand |achieve 866
	step
	label	"zangar"
		'Skipping next part of guide |next "+blade" |only if step:Find("+zangar1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Zangarmarsh,70.6,79.9
		.' Discover Darkcrest Shore |achieve 863/20
	step
		goto 83.5,82.0
		.' Discover Umbrafen Village |achieve 863/11
	step
		goto 81.1,63.4
		.' Discover Cenarion Refuge |achieve 863/1
	step
		goto 82.5,37.5
		.' Discover The Dead Mire |achieve 863/8
	step
		goto 68.5,49.2
		.' Discover Teredor |achieve 863/7
	step
		goto 62.7,41.2
		.' Discover Bloodscale Grounds |achieve 863/14
	step
		goto 58.6,61.8
		.' Discover The Lagoon |achieve 863/9
	step
		goto 47.8,51.7
		.' Discover Twin Spire Ruins |achieve 863/10
	step
		goto 44.9,66.3
		.' Discover Feralfen Village |achieve 863/3
	step
		goto 31.8,52.3
		.' Discover Zabra'jin |achieve 863/17
	step
		goto 29.0,60.7
		.' Discover Quagg Ridge |achieve 863/6
	step
		goto 14.5,61.9
		.' Discover The Spawning Glen |achieve 863/16 
	step
		goto 17.8,49.6
		.' Discover Sporeggar |achieve 863/12
	step
		goto 21.7,39.6
		.' Discover Marshlight Lake |achieve 863/5
	step
		goto 18.0,23.1
		.' Disocver Ango'rosh Grounds |achieve 863/2
	step
		goto 18.6,8.0
		.' Discover Ango'rosh Stronghold |achieve 863/13
	step
		goto 33.6,35.3
		.' Discover Hewn Bog |achieve 863/4
	step
		goto 44.9,25.2
		.' Discover Orebor Harborage |achieve 863/15
	step
	label	"zangar1"
		' Explore Zangarmarsh |achieve 863
	step
	label	"blade"
		'Skipping next part of guide |next "+nether" |only if step:Find("+blade1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Blade's Edge Mountains,29.1,81.0
		.' Discover Forge Camp: Terror |achieve 865/10
	step
		goto 30.5,59.5
		.' Discover Vortex Summit |achieve 865/26
	step
		goto 33.5,41.1
		.' Discover Forge Camp: Wrath |achieve 865/11
	step
		goto 31.9,27.5
		.' Discover Raven's Wood |achieve 865/16
	step
		goto 39.6,19.9
		.' Discover Grishnath |achieve 865/12
	step
		goto 51.7,16.7
		.' Discover Bash'ir Landing |achieve 865/1
	step
		goto 68.0,10.8
		.' Discover Crystal Spine |achieve 865/21
	step
		goto 77.9,25.9
		.' Discover Broken Wilds |achieve 865/6
	step
		goto 72.0,22.9
		.' Discover Skald |achieve 865/19
	step
		goto 67.7,23.5
		.' Discover Gruul's Lair |achieve 865/13 
	step
		goto 55.6,26.2
		.' Discover Bloodmaul Camp |achieve 865/4
	step
		goto 40.7,53.0
		.' Discover Bladespire Hold |achieve 865/3
	step
		goto 37.0,65.4
		.' Discover Sylvanaar |achieve 865/20
	step
		goto 36.4,78.7
		.' Discover Veil Lashh |achieve 865/22
	step
		goto 46.3,77.2
		.' Discover Bloodmaul Outpost |achieve 865/5 
	step
		goto 48.0,64.9
		.' Discover Jagged Ridge |achieve 865/14
	step
		goto 56.0,69.0
		.' Discover Razor Ridge |achieve 865/17
	step
		goto 64.2,61.0
		.' Discover Death's Door |achieve 865/8
	step
		goto 53.1,54.7
		.' Discover Thunderlord Stronghold |achieve 865/22
	step
		goto 53.6,43.9
		.' Discover Circle of Blood |achieve 865/7
	step
		goto 61.2,36.5
		.' Discover Ruuan Weald |achieve 865/18
	step
		goto 65.1,31.6
		.' Discover Veil Ruuan |achieve 865/24
	step
		goto 65.9,36.8
		.' Discover Bladed Gulch |achieve 865/2
	step
		goto 74.7,41.8
		.' Discover Forge Camp: Anger |achieve 865/9
	step
		goto 73.9,62.6
		.' Discover Mok'Nathal Village |achieve 865/15
	step
		goto 77.1,75.2
		.' Discover Vekhaar Stand |achieve 865/25
	step
	label	"blade1"
		' Explore Blade's Edge Mountains |achieve 865 
	step
	label	"nether"
		'Skipping next part of guide |next "+end" |only if step:Find("+nether1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Netherstorm,23.5,72.9
		.' Discover Manaforge B'naar |achieve 843/2
	step
		goto 28.4,77.5
		.' Discover The Heap |achieve 843/9
	step
		goto 33.5,66.0
		.' Discover Area 52 |achieve 843/1
	step
		goto 39.7,73.5
		.' Discover Arklon Ruins |achieve 843/10
	step
		goto 48.8,84.5
		.' Discover Manaforge Coruu |achieve 843/3
	step
		goto 57.1,88.5
		.' Discover Kirin'Var Village |achieve 843/12
	step
		goto 56.0,77.8
		.' Discover Sunfury Hold |achieve 843/15
	step
		goto 59.6,68.2
		.' Discover Maforge Duro |achieve 843/4
	step
		goto 75.8,62.5
		.' Discover Tempest Keep |achieve 843/8
	step
		goto 72.5,38.7
		.' Discover Celestial Ridge |achieve 843/11
	step
		goto 61.7,38.2
		.' Discover Manaforge Ultris |achieve 843/6
	step
		goto 55.1,43.5
		.' Discover Ethereum Staging Grounds |achieve 843/19
	step
		goto 54.4,21.3
		.' Discover Ruins of Farahlon |achieve 843/7
	step
		goto 49.5,17.0
		.' Discover Netherstone |achieve 843/13
	step
		goto 46.1,9.6
		.' Discover Eco-Dome Farfield |achieve 843/18
	step
		goto 29.9,16.0
		.' Discover Socrethar's Seat |achieve 843/20
	step
		goto 37.5,26.4
		.' Discover Forge Base: Oblivion |achieve 843/21
	step
		goto 45.1,35.8
		.' Discover The Stormspire |achieve 843/16
	step
		goto 45.3,53.7
		.' Discover Eco-Dome Midrealm |achieve 843/22
	step
		goto 32.9,54.9
		.' Discover ruins of Enkaat |achieve 843/14
	step
		goto 23.2,55.9
		.' Discover Gyro-Plank Bridge |achieve 843/17
	step
		goto 26.8,39.3
		.' Discover Manaforge Ara |achieve 843/5
	step
	label	"nether1"
		' Explore Netherstorm |achieve 843
	step
	label	"end"
		' Congratulations! You have Explored Outlands! |achieve 44 |only if achieved(44)
		' Congratulations! You have Earned the Achievement World Explorer! |achieve 46 |only if achieved(46)
		' You have not fully explored Outlands yet |only if not achieved(44)
		|confirm |next "start" |only if not achieved(44)	
]])

ZygorGuidesViewer:RegisterInclude("Explorer_Northrend",[[
	step
		' This guide requires that you have a flying mount. You can _NOT_ do this guide
		.' without having a flying mount.
		|confirm always
	step
	label	"start"
		' Explore Borean Tundra |achieve 1264
		' Explore Dragonblight |achieve 1265
		' Explore Zul'Drak |achieve 1267
		' Explore Crystalsong Forest |achieve 1457
		' Explore Icecrown |achieve 1270
		' Explore Howling Fjord |achieve 1263
		' Explore Grizzly Hills |achieve 1266
		' Explore Sholazar Basin |achieve 1268
		' Explore Storm Peaks |achieve 1269 |tip       
		|confirm always
	step
		#include "rideto_borean"
	step
	label	"borean"
		'Skipping next part of guide |next "+sholazar" |only if step:Find("+borean1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Borean Tundra,57.7,69.3
		.' Discover Valiance Keep |achieve 1264/11
	step
		goto 43.4,53.2
		.' Discover Warsong Hold |achieve 1264/10
	step
		goto 47.4,81.1
		.' Discover Riplash Stand |achieve 1264/3
	step
		goto 27.9,51.6
		.' Discover Garrosh's Landing |achieve 1264/5
	step
		goto 25.8,38.4
		.' Discover Coldarra |achieve 1264/7
	step
		goto 46.1,34.8
		.' Discover Amber Ledge |achieve 1264/9
	step
		goto 50.2,24.3
		.' Discover Steeljaw's Carvan |achieve 1264/2
	step
		goto 50.2,10.3
		.' Discover Bor'gorok Outpost |achieve 1264/8
	step
		goto 66.3,28.5
		.' Discover The Geyser Fields |achieve 1264/12
	step
		goto 66.2,51.1
		.' Discover Kaskala |achieve 1264/4
	step
		goto 82.4,46.4
		.' Discover Death's Stand |achieve 1264/6
	step
		goto 87.6,25.1
		.' Discover Temple City of En'kilah |achieve 1264/1
	step
		goto 76.4,16.4
		.' Discover The Dens of the Dying |achieve 1264/13
	step
	label	"borean1"
		' Explore Borean Tundra |achieve 1264
	step
	label	"sholazar"
		'Skipping next part of guide |next "+icecrown" |only if step:Find("+sholazar1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Sholazar Basin,81.0,55.4
		.' Discover Makers' Overlook |achieve 1268/4
	step
		goto 65.9,60.1
		.' Discover The Lifeblood Pillar |achieve 1268/8
	step
		goto 53.7,52.5
		.' Discover Rainspeaker Canopy |achieve 1268/7
	step
		goto 48.0,63.2
		.' Discover River's Heart |achieve 1268/1
	step
		goto 36.0,75.3
		.' Discover The Mosslight Pillar |achieve 1268/3
	step
		goto 24.3,81.7
		.' Discover Kartak's Hold |achieve 1268/11
	step
		goto 33.3,52.3
		.' Discover The Suntouched Pillar |achieve 1268/6
	step
		goto 29.7,40.1
		.' Discover Makers' Perch |achieve 1268/5
	step
		goto 24.5,33.5
		.' Discover The Stormwright's Shelf |achieve 1268/12
	step
		goto 46.8,26.1
		.' Discover The Savage Thicket |achieve 1268/2
	step
		goto 29.5,36.3
		.' Discover The Glimmering Pillar |achieve 1268/10
	step
		goto 74.5,34.6
		.' Discover The Avalanche |achieve 1268/9
	step
	label	"sholazar1"
		' Explore Sholazar Basin |achieve 1268
	step
	label	"icecrown"
		'Skipping next part of guide |next "+dragon" |only if step:Find("+icecrown1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Icecrown,8.9,42.9
		.' Discover Onslaught Harbor |achieve 1270/3
	step
		goto 27.1,39.0
		.' Discover Jotunheim |achieve 1270/13
	step
		goto 36.5,24.1
		.' Discover Valhalas |achieve 1270/8
	step
		goto 44.4,22.6
		.' Discover The Shadow Vault |achieve 1270/15
	step
		goto 52.8,30.6
		.' Discover Aldur'thar: The Desolation Gate |achieve 1270/6
	step
		goto 63.7,44.0
		.' Discover The Bombardment |achieve 1270/1
	step
		goto 74.0,37.7
		.' Discover Sindragosa's Fall |achieve 1270/7
	step
		goto 78.4,60.2
		.' Discover Scourgeholme |achieve 1270/14
	step
		goto 83.8,73.4
		.' Valley of Echoes |achieve 1270/9
	step
		goto 69.2,64.4
		.' Discover The Broken Front |achieve 1270/4
	step
		goto 54.9,56.2
		.' Discover Ymirheim |achieve 1270/10
	step
		goto 43.6,56.5
		.' Discover The Conflagration |achieve 1270/11
	step
		goto 33.1,66.4
		.' Discover The Fleshwerks |achieve 1270/5
	step
		goto 48.4,70.6
		.' Discover Corp'rethar: The Horror Gate |achieve 1270/12
	step
		goto 54.2,85.8
		.' Discover Icecrown Citadel |achieve 1270/2
	step
	label	"icecrown1"
		' Explore Icecrown |achieve 1270
	step
	label	"dragon"
		'Skipping next part of guide |next "+crystal" |only if step:Find("+dragon1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Dragonblight,36.0,15.0
		.' Discover Angrathar the Wrath Gate |achieve 1265/10
	step
		goto 38.4,31.9
		.' Discover Obsidian Dragonshrine |achieve 1265/3
	step
		goto 25.1,43.2
		.' Discover Icemist Village |achieve 1265/7
	step
		goto 13.8,46.2
		.' Discover Westwind Refugee Camp |achieve 1265/13
	step
		goto 36.9,47.8
		.' Discover Agmar's Hammer |achieve 1265/11
	step
		goto 39.7,67.0
		.' Discover Lake Indu'le |achieve 1265/2
	step
		goto 47.3,48.7
		.' Discover Ruby Dragonshrine |achieve 1265/3
	step
		goto 54.9,32.7
		.' Discover Galakrond's Rest |achieve 1265/1
	step
		goto 59.7,49.8
		.' Discover Wyrmrest Temple |achieve 1265/12
	step
		goto 63.5,72.7
		.' Discover Emerald Dragonshrine |achieve 1265/8
	step
		goto 71.0,75.2
		.' Discover New Hearthglen |achieve 1265/4
	step
		goto 77.1,60.0
		.' Discover Venomspite |achieve 1265/14
	step
		goto 82.5,70.7
		.' Discover The Forgotten Shore |achieve 1265/15
	step
		goto 88.9,44.0
		.' Discover Naxxramas |achieve 1265/5
	step
		goto 83.6,25.6
		.' Discover Light's Trust |achieve 1265/6
	step
		goto 72.7,25.6
		.' Discover Scarlet Point |achieve 1265/17
	step
		goto 61.8,19.5
		.' Discover The Crystal Vice |achieve 1265/16
	step
		goto 50.0,17.5
		.' Discover Coldwind Heights |achieve 1265/9
	step
	label	"dragon1"
		' Explore Dragonblight |achieve 1265
	step
	label	"crystal"
		'Skipping next part of guide |next "+storm" |only if step:Find("+crystal1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Crystalsong Forest,26.4,61.4
		.' Discover The Azure Front |achieve 1457/1
	step
		goto 14.5,44.1
		.' Discover Violet Stand |achieve 1457/7
	step
		goto 13.1,33.9
		.' Discover The Great Tree |achieve 1457/6
	step
		goto 16.0,15.4
		.' Discover The Decrepit Flow |achieve 1457/2
	step
		goto 43.0,42.5
		.' Discover Forlorn Woods |achieve 1457/4
	step
		goto 64.7,60.4
		.' Discover The Unbound Thicket |achieve 1457/8
	step
		goto 75.2,83.0
		.' Discover Windrunner's Overlook |achieve 1457/5
	step
		goto 76.9,46.3
		.' Discover Sunreaver's Command |achieve 1457/3
	step
	label	"crystal1"
		' Explore Crystalsong Forest |achieve 1457
	step
	label	"storm"
		'Skipping next part of guide |next "+zul" |only if step:Find("+storm1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto The Storm Peaks,35.1,84.0
		.' Discover Sparksocket Minefield |achieve 1269/7
	step
		goto 35.3,68.7
		.' Discover Bor's Breath |achieve 1269/4
	step
		goto 35.9,58.0
		.' Discover Temple of Storms |achieve 1269/12
	step
		goto 29.4,73.8
		.' Discover Frosthold |achieve 1269/15
	step
		goto 24.0,60.5
		.' Discover Valkyrion |achieve 1269/5
	step
		goto 23.9,50.1
		.' Discover Nidavelir |achieve 1269/16
	step
		goto 27.3,41.9
		.' Discover Snowdrift Plains |achieve 1269/13
	step
		goto 32.2,39.6
		.' Discover Narvir's Cradle |achieve 1269/2
	step
		goto 41.3,17.4
		.' Discover Ulduar |achieve 1269/10
	step
		goto 50.3,44.7
		.' Discover Terrace of the Makers |achieve 1269/6
	step
		goto 64.8,44.8
		.' Discover Temple of Life |achieve 1269/9
	step
		goto 72.9,48.5
		.' Discover Thunderfall |achieve 1269/11
	step
		goto 64.4,59.1
		.' Discover Dun Niffelem |achieve 1269/3
	step
		goto 40.9,57.2
		.' Discover Engine of the Makers |achieve 1269/8
	step
		goto 47.8,68.2
		.' Discover Brunnhildar Village |achieve 1269/1
	step
		goto 47.1,81.6
		.' Discover Garm's Bane |achieve 1269/14
	step
	label	"storm1"
		' Explore The Storm Peaks |achieve 1269
	step
	label	"zul"
		'Skipping next part of guide |next "+grizzly" |only if step:Find("+zul1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Zul'Drak,17.0,57.3
		.' Discover Thrym's End |achieve 1267/12
	step
		goto 28.2,45.1
		.' Discover Voltarus |achieve 1267/11
	step
		goto 40.5,38.8
		.' Discover Altar of Sseratus |achieve 1267/4
	step
		goto 53.3,36.5
		.' Discover Altar of Rhunok |achieve 1267/5
	step
		goto 83.7,16.7
		.' Discover Gundrak |achieve 1267/1
	step
		goto 73.2,45.6
		.' Discover Altar of Mam'toth |achieve 1267/7
	step
		goto 76.9,59.3
		.' Discover Altar of Quetz'lun |achieve 1267/6
	step
		goto 59.3,57.8
		.' Discover Zim'Torga |achieve 1267/9
	step
		goto 64.4,68.9
		.' Discover Altar of Har'koa |achieve 1267/8
	step
		goto 62.0,77.6
		.' Discover Kolrama |achieve 1267/14
	step
		goto 48.2,56.4
		.' Discover Ampitheater of Anguish |achieve 1267/3
	step
		goto 41.7,76.8
		.' Discover Drak'Sorta Fields |achieve 1267/2
	step
		goto 32.0,76.4
		.' Discover Light's Breach |achieve 1267/13
	step
		goto 21.1,75.2
		.' Discover Zeramas |achieve 1267/10
	step
	label	"zul1"
		' Explore Zul'Drak |achieve 1267
	step
	label	"grizzly"
		'Skipping next part of guide |next "+howling" |only if step:Find("+grizzly1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Grizzly Hills,17.5,23.6
		.' Discover Drak'Tharon Keep |achieve 1266/2
	step
		goto 15.8,49.6
		.' Discover Granite Springs |achieve 1266/5
	step
		goto 21.3,65.3
		.' Discover Conquest Hold |achieve 1266/1
	step
		goto 14.5,84.4
		.' Discover Venture Bay |achieve 1266/9
	step
		goto 29.0,76.5
		.' Discover Voldrune |achieve 1266/10
	step
		goto 31.4,57.9
		.' Discover Amberpine Lodge |achieve 1266/11
	step
		goto 36.0,37.9
		.' Discover Blue Sky Logging Grounds |achieve 1266/12
	step
		goto 48.2,42.2
		.' Discover Grizzlemaw |achieve 1266/6
	step
		goto 56.8,28.4
		.' Discover Westfall Brigade Encampment |achieve 1266/14
	step
		goto 68.1,14.8
		.' Discover Thor Modan |achieve 1266/8
	step
		goto 71.8,27.9
		.' Discover Drakil'jin Ruins |achieve 1266/3
	step
		goto 64.9,45.6
		.' Discover Camp Oneqwah |achieve 1266/13
	step
		goto 77.9,59.3
		.' Discover Dun Argol |achieve 1266/4
	step
		goto 50.3,57.2
		.' Discover Rage Fang Shrine |achieve 1266/7
	step
	label	"grizzly1"
		' Explore Grizzly Hills |achieve 1266
	step
	label	"howling"
		'Skipping next part of guide |next "+end" |only if step:Find("+howling1"):IsComplete()
		'Proceeding next step |next |only if default
	step
		goto Howling Fjord,36.6,9.5
		.' Discover Gjalerbron |achieve 1263/9
	step
		goto 47.8,12.1
		.' Discover Camp Winterhoof |achieve 1263/3
	step
		goto 54.2,16.8
		.' Discover The Twisted Glade |achieve 1263/17
	step
		goto 60.7,12.8
		.' Discover Fort Wildervar |achieve 1263/12
	step
		goto 68.6,26.5
		.' Discover Giant's Run |achieve 1263/9
	step
		goto 78.1,27.3
		.' Discover Vengeance Landing |achieve 1263/5
	step
		goto 78.2,46.2
		.' Discover Ivald's Ruin |achieve 1263/13
	step
		goto 72.5,71.3
		.' Discover Baelgun's Excavation Site |achieve 1263/20
	step
		goto 67.9,52.8
		.' Discover Nifflevar |achieve 1263/8
	step
		goto 66.6,39.1
		.' Discover Baleheim |achieve 1263/21
	step
		goto 57.6,35.9
		.' Discover Cauldros Isle |achieve 1263/2
	step
		goto 58.3,45.9
		.' Discover Utgarde Keep |achieve 1263/18
	step
		goto 50.1,54.1
		.' Discover Halgrind |achieve 1263/14
	step
		goto 52.9,69.0
		.' Discover New Agamand |achieve 1263/15
	step
		goto 34.3,75.5
		.' Discover Scalawag Point |achieve 1263/7
	step
		goto 24.9,57.7
		.' Discover Kamagua |achieve 1263/1
	step
		goto 40.0,50.6
		.' Discover Ember Clutch |achieve 1263/10
	step
		goto 45.1,33.1
		.' Discover Skorn |achieve 1263/16
	step
		goto 30.3,41.4
		.' Discover Westguard Keep |achieve 1263/19
	step
		goto 31.3,25.9
		.' Discover Steel Gate |achieve 1263/6
	step
		goto 27.0,24.1
		.' Discover Apothecary Camp |achieve 1263/4
	step
	label	"howling1"
		' Explore Howling Fjord |achieve 1263
	step
	label	"end"
		' Congratulations! You have Explored Northrend |achieve 45 |only if achieved(45)
		' Congratulations! You have Earned the Achievement World Explorer! |achieve 46 |only if achieved(46)
		.' You have not fully discovered Northrend yet |only if not achieved(45)
		|confirm |next "start" |only if not achieved(45)
]])

ZygorGuidesViewer:RegisterGuideSorting({
	"Leveling Guides",
	"Loremaster Guides",
	"Dailies Guides",
	"Events Guides",
	"Dungeon Guides",
	"Gear Guides",
	"Professions Guides",
	"Achievements Guides",
	"Pets & Mounts Guide",
	"Titles",
	"Reputations Guides",
	"Macro Guides",
})
