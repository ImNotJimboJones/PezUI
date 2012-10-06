local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("Gear") then return end
if not ZygorGuidesViewer.ItemScore then return end
ZygorGuidesViewer.ItemScore.Items = {}
ZygorGuidesViewer.ItemScore.Items["Classic Dungeons\\Ragefire Chasm (RFC)"] = {
dungeonmap=680,
dungeon=4,
{ boss=61408, -- Adarogg
82880, -- Fang of Adarogg
                82879, -- Collarspike Bracers
82772, -- Snarlmouth Leggings
},
{ boss=61528, -- Lava Guard Gordoth
82888, -- Heartboiler Staff
                82883, -- Bloodcursed Felblade
82886, -- Gorewalker Treads
},
{ boss=61463, -- Slagmaw
82878, -- Fireworm Robes
                82885, -- Flameseared Carapace
82884, --Chitonous Bracers
},
{ boss=61412, -- Dark Shaman Koranthal
82882, -- Dark Ritual Cape
                82877, -- Grasp of the Broken Totem
82881, -- Cuffs of Black Elements
},
{ quest=30996, -- Quest: The Dark Shaman
82891, -- Robes of the Doomed Ritual
82892, -- Ragefire Leggings
82893, -- Hide Vest of the Shaman
82894, -- Stone Guard Greaves
82895, -- Searing Belt
}
}
ZygorGuidesViewer.ItemScore.Items["Classic Dungeons\\Deadmines (DM or VC)"] = {
dungeonmap=756,
dungeon=6,
{ boss=47739,
5202, -- Corsair's Overshirt
5193, -- Cape of the Brotherhood
5198, -- Cookie's Stirring Rod
5197, -- Cookie's Tenderizer
5192, -- Thief's Blade
},
{ boss=47626, -- Admiral Ripsnarl
872, -- Rockslicer
5196, -- Smite's Reaver
},
{ boss=43778, -- Foe Reaper 5000
1937, -- Buzz Saw
5187, -- Foe Reaper
},
{ boss=47162,
2169, -- Buzzer Blade
5195, -- Gold-Flecked Gloves
},
{ boss=47296, -- Helix Gearbreaker
5443, -- Gold-Plated Buckler
5191, -- Cruel Barb
5200, -- Impaling Harpoon
5199, -- Smelting Pants
},
{ quest={27790},
65935, -- Cookie's Meat Mallet    --Alliance Quest--The Defias Kingpin
65959, -- Cookie's Stirring Stick    --Alliance Quest--The Defias Kingpin
65983, -- Cookie's Table Cloth    --Alliance Quest--The Defias Kingpin
}
}
ZygorGuidesViewer.ItemScore.Items["Classic Dungeons\\Wailing Caverns"] = {
dungeonmap=749,
dungeon=1,
{ boss=5912, -- Deviate Faerie Dragon
6632, -- Feyscale Cloak
5243, -- Firebelcher
},
{ boss=3653, -- Kresh
13245, -- Kresh's Back
6447, -- Worn Turtle Shell Shield
},
{ boss=3671, -- Lady Anacondra
5404, -- Serpent's Shoulders
10412, -- Belt of the Fang
6446, -- Snakeskin Bag
},
{ boss=3669, -- Lord Cobrahn
6465, -- Robe of the Moccasin
6460, -- Cobrahn's Grasp
10410, -- Leggings of the Fang
},
{ boss=3670, -- Lord Pythas
6472, -- Stinging Viper
6473, -- Armor of the Fang
},
{ boss=3673, -- Lord Serpentis
6469, -- Venomstrike
5970, -- Serpent Gloves
10411, -- Footpads of the Fang
6459, -- Savage Trodders
},
{ boss=3654, -- Mutanus the Devourer
6627, -- Mutant Scale Breastplate
6463, -- Deep Fathom Ring
6461, -- Slime-Encrusted Pads
},
{ boss=3674, -- Skum
6448, -- Tail Spike
6449, -- Glowing Lizardscale Cloak
},
{ boss=5775, -- Verdan the Everliving
6630, -- Seedcloud Buckler
6631, -- Living Root
6629, -- Sporid Cape
},
{ quest=26870, -- Cleansing the Caverns
65985, -- Cleansed Pauldrons
65937, -- Serpentis' Gloves
65961, -- Cobrahn's Boots
66003, -- Pythas' Vest
65911, -- Anacondra's Robe
}
}
