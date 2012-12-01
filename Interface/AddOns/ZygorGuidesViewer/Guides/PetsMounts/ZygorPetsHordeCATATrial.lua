local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("PetsHCATA") then return end
ZGV.CommonPets=true
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Snowshoe Rabbit",[[
description This guide will walk you through obtaining
description the Critter pet: Snowshoe Rabbit
condition end haspet(7560)
pet 72
step
'You will have to buy these from a _neutral Auction House_, as they are _not_ available to _Horde characters_
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
'You will have to buy these from a _neutral Auction House_, as they are _not_ available to _Horde characters_
.buy 1 Cat Carrier (Bombay)##8485
'|modeldisplay 5556
step
.learnpet Bombay Cat##7385  |use Cat Carrier (Bombay)##8485
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Cornish Rex Cat",[[
description This guide will walk you through obtaining
description the Beast pet: Cornish Rex Cat
condition end haspet(7384)
pet 41
step
'You will have to buy these from a _neutral Auction House_, as they are _not_ available to _Horde characters_
.buy 1 Cat Carrier (Cornish Rex)##8486
'|modeldisplay 5586
step
.learnpet Cornish Rex Cat##7384 |use Cat Carrier (Cornish Rex)##8486
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Hare",[[
description This guide will walk you through obtaining
description the Critter pet: Hare
condition end haspet(61751)
pet 448
step
goto Durotar 47.3,30.5
.' The _Hares_ around this area are level 1. Challenge one to a pet battle and capture it.
.learnpet Hare##61751
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Orange Tabby Cat",[[
description This guide will walk you through obtaining
description the Beast pet: Orange Tabby Cat
condition end haspet(7382)
pet 43
step
'You will have to buy these from a _neutral Auction House_, as they are _not_ available to _Horde characters_
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
'You will have to buy these from a _neutral Auction House_, as they are _not_ available to _Horde characters_
.buy 1 Cat Carrier (Silver Tabby)##8488
'|modeldisplay 5555
step
.learnpet Silver Tabby Cat##7381 |use Cat Carrier (Silver Tabby)##8488
]])
