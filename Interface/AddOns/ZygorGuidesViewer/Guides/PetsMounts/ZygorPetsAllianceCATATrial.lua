local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("PetsACATA") then return end
ZGV.CommonPets=true
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Snowshoe Rabbit",[[
description This guide will walk you through obtaining
description the Critter pet: Snowshoe Rabbit
condition end haspet(7560)
pet 72
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
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Squirrel",[[
description This guide will walk you through obtaining
description the Critter pet: Squirrel
condition end haspet(61081)
pet 379
step
goto Elwynn Forest 46.7,71.4
.' The Squirrel is level 1. Challenge one to a pet battle and capture it.
.learnpet Squirrel##61081
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Bombay Cat",[[
description This guide will walk you through obtaining
description the Beast pet: Bombay Cat
condition end haspet(7385)
pet 40
step
goto Elwynn Forest,44.2,53.2
.talk 6367
.buy 1 Cat Carrier (Bombay)##8485
'|modeldisplay 5556
step
.learnpet Bombay Cat##7385 |use Cat Carrier (Bombay)##8485
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Cornish Rex Cat",[[
description This guide will walk you through obtaining
description the Beast pet: Cornish Rex Cat
condition end haspet(7384)
pet 41
step
goto Elwynn Forest,44.2,53.2
.talk 6367
.buy 1 Cat Carrier (Cornish Rex)##8486
'|modeldisplay 5586
step
.learnpet Cornish Rex Cat##7384 |use Cat Carrier (Cornish Rex)##8486
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Orange Tabby Cat",[[
description This guide will walk you through obtaining
description the Beast pet: Orange Tabby Cat
condition end haspet(7382)
pet 43
step
goto Elwynn Forest,44.2,53.2
.talk 6367
.buy 1 Cat Carrier (Orange Tabby)##8487
'|modeldisplay 5554
step
.learnpet Orange Tabby Cat##7382 |use Cat Carrier (Orange Tabby)##8487
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Silver Tabby Cat",[[
description This guide will walk you through obtaining
description the Beast pet: Silver Tabby Cat
condition end haspet(7381)
pet 45
step
goto Elwynn Forest,44.2,53.2
.talk 6367
.buy 1 Cat Carrier (Silver Tabby)##8488
'|modeldisplay 5555
step
.learnpet Silver Tabby Cat##7381 |use Cat Carrier (Silver Tabby)##8488
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Small Frog",[[
description This guide will walk you through obtaining
description the Aquatic pet: Small Frog
condition end haspet(61071)
pet 419
step
goto Elwynn Forest 56.0,67.1
.' The Small Frog is level 1. Challenge one to a pet battle and capture it.
.learnpet Small Frog##61071
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Undercity Rat",[[
description This guide will walk you through obtaining
description the Critter pet: Undercity Rat
condition end haspet(61889)
pet 454
step
'This pet is only found inside _The Undercity_. You can attempt to capture it yourself, but it is suggested that you use a _Horde_ character to capture it.
|confirm
step
goto Undercity 70.9,35.4
.' The _Undercity Rats_ are level 2. Challenge one to a pet battle and capture it.
.learnpet Undercity Rat##61889
|modeldisplay 1141
]])
