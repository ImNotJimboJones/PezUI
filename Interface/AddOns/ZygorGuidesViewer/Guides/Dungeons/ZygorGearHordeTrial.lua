local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("Gear") then return end
if not ZygorGuidesViewer.ItemScore then return end
ZygorGuidesViewer.ItemScore.Items = {}
ZygorGuidesViewer.ItemScore.Items["Classic Dungeons\\Ragefire Chasm (RFC)"] = {
dungeonmap=680,
dungeon=4,
{ boss=61408,
82880,
82879,
82772,
},
{ boss=61528,
82888,
82883,
82886,
},
{ boss=61463,
82878,
82885,
82884,
},
{ boss=61412,
82882,
82877,
82881,
},
}
ZygorGuidesViewer.ItemScore.Items["Classic Dungeons\\Deadmines (DM or VC)"] = {
dungeonmap=756,
dungeon=6,
{ boss=47739,
5202,
5193,
5198,
5197,
5192,
},
{ boss=47626,
872,
5196,
},
{ boss=43778,
1937,
5187,
},
{ boss=47162,
2169,
5195,
},
{ boss=47296,
5443,
5191,
5200,
5199,
},
{ quest={27790},
66019,
66028,
66037,
}
}
ZygorGuidesViewer.ItemScore.Items["Classic Dungeons\\Wailing Caverns"] = {
dungeonmap=749,
dungeon=1,
{ boss=5912,
6632,
5243,
},
{ boss=3653,
13245,
6447,
},
{ boss=3671,
5404,
10412,
6446,
},
{ boss=3669,
6465,
6460,
10410,
},
{ boss=3670,
6472,
6473,
},
{ boss=3673,
6469,
5970,
10411,
6459,
},
{ boss=3654,
6627,
6463,
6461,
},
{ boss=3674,
6448,
6449,
},
{ boss=5775,
6630,
6631,
6629,
},
{ quest=26870,
65985,
65937,
65961,
66003,
65911,
}
}
