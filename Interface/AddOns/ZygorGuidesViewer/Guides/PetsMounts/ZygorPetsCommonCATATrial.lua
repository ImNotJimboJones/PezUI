local ZygorGuidesViewer=ZygorGuidesViewer
local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if ZGV:DoMutex("PetsCCATA") then return end
if not ZGV.CommonPets then return end
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Cat",[[
description This guide will walk you through obtaining
description the Beast pet: Cat
condition end haspet(62019)
pet 459
step
goto Elwynn Forest 44.6,53.4
.' The _Cat_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Cat##62019
|modeldisplay 5585
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Chicken",[[
description This guide will walk you through obtaining
description the Flying pet: Chicken
condition end haspet(62664)
pet 646
step
goto Elwynn Forest 77.6,66.2
.' The _Chicken_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Chicken##62664
|modeldisplay 29331
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Fawn",[[
description This guide will walk you through obtaining
description the Critter pet: Fawn
condition end haspet(61165)
pet 447
step
goto Elwynn Forest 45.1,67.4
.' The _Fawn_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Fawn##61165
|modeldisplay 654
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Prairie Dog",[[
description This guide will walk you through obtaining
description the Critter pet: Prairie Dog
condition end haspet(61141)
pet 386
step
goto Mulgore 35.0,7.6
.' The _Prairie Dogs_ in this area are level 1. Challenge one to a pet battle and capture it.
.learnpet Prairie Dog##61141
|modeldisplay 1072
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Rabbit",[[
description This guide will walk you through obtaining
description the Critter pet: Rabbit
condition end haspet(61080)
pet 378
step
goto Elwynn Forest 61.2,68.1
.' The _Rabbit_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Rabbit##61080
|modeldisplay 328
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Adder",[[
description This guide will walk you through obtaining
description the Beast pet: Adder
condition end haspet(61325)
pet 635
step
goto Durotar 45.4,25.7
.' The _Adders_ in this area are level 1. Challenge one to a pet battle and capture it.
.learnpet Adder##61325
|modeldisplay 1986
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Alpine Hare",[[
description This guide will walk you through obtaining
description the Critter pet: Alpine Hare
condition end haspet(61690)
pet 441
step
goto Dun Morogh 52.6,58.2
.' The _Alpine Hare_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Alpine Hare##61690
|modeldisplay 23926
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Black Lamb",[[
description This guide will walk you through obtaining
description the Critter pet: Black Lamb
condition end haspet(60649)
pet 374
step
goto Elwynn Forest 72.4,76.4
.' The _Black Lamb_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Black Lamb##60649
|modeldisplay 42906
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Black Tabby Cat",[[
description This guide will walk you through obtaining
description the Beast pet: Black Tabby Cat
condition end haspet(7383)
pet 42
step
'Go to _Hillsbrad Foothills_ |goto Hillsbrad Foothills |noway |c
step
'_Kill_ any and all mobs in _Hillsbrad Foothills_ |tip Every mob here has a chance to drop the Black Tabby Cat's carrier
.collect 1 Cat Carrier (Black Tabby)##8491
'|modeldisplay 5448
step
.learnpet Black Tabby Cat##7383 |use Cat Carrier (Black Tabby)##8491
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Creepy Crawly",[[
description This guide will walk you through obtaining
description the Critter pet: Creepy Crawly
condition end haspet(62116)
pet 468
step
goto Durotar 50.0,29.4
.' The _Creepy Crawly_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Creepy Crawly##62116
|modeldisplay 7511
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Crested Owl",[[
description This guide will walk you through obtaining
description the Flying pet: Crested Owl
condition end haspet(62242)
pet 507
step
goto Teldrassil 45.2,64.9
.' The _Crested Owl_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Crested Owl##62242
|modeldisplay 6300
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Dung Beetle",[[
description This guide will walk you through obtaining
description the Critter pet: Dung Beetle
condition end haspet(62115)
pet 467
step
goto Orgrimmar 42.4,46.8
.' The _Dung Beetle_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Dung Beetle##62115
|modeldisplay 7511
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Gazelle Fawn",[[
description This guide will walk you through obtaining
description the Critter pet: Gazelle Fawn
condition end haspet(62176)
pet 477
step
goto Mulgore 33.8,31.5
.' The _Gazelle Fawns_ are level 1. Challenge one to a pet battle and capture it.
.learnpet Gazelle Fawn##62176
|modeldisplay 45085
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Grey Moth",[[
description This guide will walk you through obtaining
description the Flying pet: Grey Moth
condition end haspet(62050)
pet 464
step
goto Azuremyst Isle 53.1,52.5
.' The _Grey Moths_ in this area are level 1. Challenge one to a pet battle and capture it.
.learnpet Grey Moth##62050
|modeldisplay 42343
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Irradiated Roach",[[
description This guide will walk you through obtaining
description the Critter pet: Irradiated Roach
condition end haspet(61691)
pet 442
step
goto New Tinkertown 41.1,47.9
.' The _Irradiated Roaches_ are level 1. Challenge one to a pet battle and capture it.
.learnpet Irradiated Roach##61691
|modeldisplay 2177
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Lost of Lordaeron",[[
description This guide will walk you through obtaining
description the Undead pet: Lost of Lordaeron
condition end haspet(61905)
pet 458
step
goto Tirisfal Glades 79.7,55.2
.' The _Lost of Lordaeron_ is level 1. Challenge one to a pet battle and capture it.
.learnpet Lost of Lordaeron##61905
|modeldisplay 42304
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Ruby Sapling",[[
description This guide will walk you through obtaining
description the Elemental pet: Ruby Sapling
condition end haspet(62020)
pet 460
step
goto Eversong Woods 52.2,58.1
.' The _Ruby Saplings_ are level 1. Challenge one to a pet battle and capture it.
.learnpet Ruby Sapling##62020
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Snow Cub",[[
description This guide will walk you through obtaining
description the Beast pet: Snow Cub
condition end haspet(61689)
pet 440
step
goto Dun Morogh 51.1,44.6
.' The _Snow Cubs_ are level 1. Challenge one to a pet battle and capture it.
.learnpet Snow Cub##61689
|modeldisplay 42203
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Spiny Lizard",[[
description This guide will walk you through obtaining
description the Beast pet: Spiny Lizard
condition end haspet(62114)
pet 466
step
goto Durotar 45.8,20.5
.' The _Spiny Lizards_ in this area are level 1-2. Challenge one to a pet battle and capture it.
.learnpet Spiny Lizard##62114
|modeldisplay 36583
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Water Snake",[[
description This guide will walk you through obtaining
description the Beast pet: Water Snake
condition end haspet(61367)
pet 418
step
goto Durotar 44.2,33.5
.' The _Water Snakes_ in this area are level 1. Challenge one to a pet battle and capture it.
.learnpet Water Snake##61367
|modeldisplay 1986
]])
