local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("DailiesHCATA") then return end
ZygorGuidesViewer:RegisterInclude("rideto_borean",[[
goto Orgrimmar,44.7,62.4 |n
.' Ride the zeppelin to Borean Tundra |goto Borean Tundra |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_tirisfal",[[
goto Orgrimmar,50.8,55.8 |n
.' Ride the zeppelin to Tirisfal Glades |goto Tirisfal Glades |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_stranglethorn",[[
goto Orgrimmar,52.5,53.2 |n
.' Ride the zeppelin to Stranglethorn Vale |goto Northern Stranglethorn |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_howlingfjord",[[
goto Orgrimmar,50.8,55.8 |n
.' Ride the zeppelin to Tirisfal Glades |goto Tirisfal Glades |noway |c
step
goto Tirisfal Glades,59.1,59.0 |n
.' Ride the zeppelin to Howling Fjord |goto Howling Fjord |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_org",[[
.' Go to Tirisfal |goto Tirisfal Glades |noway |c
step
goto Tirisfal Glades,60.7,58.8 |n
.' Ride the Zeppelin to Orgrimmar |goto Orgrimmar |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_tirisfal_strangle",[[
goto Northern Stranglethorn,37.5,50.9 |n
.' Ride the zepplin to Undercity |goto Tirisfal Glades |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_strangle_tirisfal",[[
goto Tirisfal Glades,61.9,59.1 |n
.' Ride the Zeplin to Northern Stranglethorn |goto Northern Stranglethorn |noway |c
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Grizzly Hills Pre-Quests",[[
author support@zygorguides.com
description This guide section contains the pre-quests to unlock the daily quest in the Granite Springs region of Grizzly Hills.
description The Blackriver Logging Camp, Blue Sky Logging Grounds, and Venture Bay regions of Grizzly Hills
description do not have any pre-quests to unlock the daily quests that are available in those regions.
step
goto Grizzly Hills,16.2,47.6
.talk 26424
..accept 11984
step
goto 16.4,48.3
.talk 26429
..'Tell him it's time to play with the ice trolls|havebuff Budd's Attention Span|q 11984
step
goto 13.2,60.5
.' Use Budd's pet bar skill Tag Troll to have him stun a troll|petaction Tag Troll
.' Use your Bounty Hunter's Cage on the stunned troll|use Bounty Hunter's Cage##35736
.' Capture a Live Ice Troll|goal Captured Live Ice Troll|q 11984/1
step
goto 16.2,47.6
.talk 26424
..turnin 11984
step
goto 16.4,47.8
.talk 26423
..accept 11989
step
goto 16.5,47.8
.' Click the Dull Carving Knife|tip It's a knife stuck in the side of this tree trunk.
.collect 1 Dull Carving Knife##38083|q 11989
step
goto 16.4,47.8
.' Use your Dull Carving Knife next to the yellow cage|use Dull Carving Knife##38083
.talk 26423
..'Shake his hand
..'Make a Blood Pact With Drakuru|goal Blood Pact With Drakuru|q 11989/1
step
goto 16.4,47.8
.talk 26423
..turnin 11989
..accept 11990
step
goto 16,47.8
.talk 26474
..buy 1 Imbued Vial|q 11990/1
step
goto 14.6,45.3
.' Click the Hazewood Bushes|tip They look like small flower bushes on the ground around this area.
.get 3 Haze Leaf|q 11990/2
step
goto 15.2,40.3
.' Click a Waterweed|tip They look like big green bushes underwater around this area.
.get Waterweed Frond|q 11990/3
step
goto 16.4,47.8
.talk 26423
..turnin 11990
step
goto 15.7,46.7
.talk 26519
..accept 12484
step
goto 15.7,46.9
.' Click a Scourged Troll Mummy on the ground next to you
.collect 1 Scourged Troll Mummy##38149|q 12484
step
goto 16.9,48.3
.' Use your Scourged Troll Mummy next to the burning pile of mummies|use Scourged Troll Mummy##38149
.' Burn a Mummified Carcass|goal Mummified Carcass Burned|q 12484/1
step
goto 16.7,48.3
.talk 26604
..turnin 12484
..accept 12029
step
goto 16,29.9
.' Jump on the big rock and stand on it
.' Use Mack's Dark Grog and throw it at the trolls running around to the north|use Mack's Dark Grog##35908
.' Burn 20 Scourge Trolls|goal 20 Scourge Trolls Burned |q 12029/1
step
goto 16.7,48.3
.talk 26604
..turnin 12029
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Blackriver Logging Camp Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quest in the Blackriver Logging Camp region of Grizzly Hills.
description There are no pre-quests needed to unlock the daily quest offered in this guide section.
daily
step
goto Grizzly Hills,26.4,65.8
.talk 27120
..accept 12170 |daily
step
goto 27.3,64.7
.' Kill Alliance Players or Amberpine Scouts in the Blackriver Logging Camp
.' Kill 10 Alliance in Blackriver|goal 15 Alliance in Blackriver slain|q 12170/1
step
goto 26.4,65.8
.talk 27120
..turnin 12170
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Blue Sky Logging Grounds Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quests in the Blue Sky Logging Grounds region of Grizzly Hills.
description There are no pre-quests needed to unlock the daily quests offered in this guide section.
daily
step
goto Grizzly Hills,33.8,32.7
.talk 27464
..accept 12288 |daily
step
goto 34.4,32.6
.talk 27422
..accept 12280 |daily
step
goto 34.5,32.5
.talk 27423
..accept 12270 |daily
step
goto 34.5,33.0
.talk 27451
..accept 12284 |daily
step
goto 35.2,39.3
.' Kill Alliance Players or Wounded Westfall Infantry around the area
.' Use Renewing Tourniquet on Wounded Skirmishers|use Renewing Tourniquet##37568
.' Heal 10 Wounded Skirmishers|goal 10 Wounded Skirmishers Healed|q 12288/1
.' Click Grooved Cogs, Notched Sprockets, and High Tension Springs on the ground of the Blue Sky Logging Grounds
..get 4 Grooved Cogs##37412|q 12280/1
..get 3 Notched Sprockets##37413|q 12280/2
..get 2 High Tension Springs##37416|q 12280/3
step
goto 33.4,35.7
.' Kill Alliance Players or Wounded Westfall Infantry around the area
.' Eliminate 15 Horde units|goal 15 Horde units eliminated|q 12284/1
step
goto 32.8,40.5
.' Find a Broken-down Shredder that spawns around this area
.' Click the Broken-down Shredder to get inside it
.' Use your abilities on your hot bar to return the shredder to Grekk at [34.5,32.5]
.' Deliver 3 Shredders|goal 3 Shredder Delivered|q 12270/1
step
goto 34.5,32.5
.talk 27423
..turnin 12270
step
goto 34.4,32.6
.talk 27422
..turnin 12280
step
goto 34.5,33.0
.talk 27451
..turnin 12284
step
goto 33.8,32.7
.talk 27464
..turnin 12288
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Granite Springs Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quest in the Granite Springs region of Grizzly Hills.
daily
step
goto Grizzly Hills,16.7,48.3
.talk 26604
..accept 12038 |daily
step
goto 16,29.9
.' Jump on the big rock and stand on it
.' Use Mack's Dark Grog and throw it at the trolls running around to the north|use Mack's Dark Grog##35908
.' Burn 30 Scourge Trolls|goal 30 Scourge Trolls Burned |q 12038/1
step
goto Grizzly Hills,16.7,48.3
.talk 26604
..turnin 12038
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Venture Bay Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quests in the Venture Bay region of Grizzly Hills.
description There are no pre-quests needed to unlock the daily quests offered in this guide section.
daily
step
goto Grizzly Hills,14.8,86.6
.talk 27708
..accept 12432 |daily
.' If he's not there, then you have to take control of Venture Bay for the Horde
..' To take control of Venture Bay for the Horde, go to 15.1,88.0|tip Hide behind the lighthouse in between the 2 big brown rocks.  Flag yourself for PvP and a bar will appear under your minimap.  Sit here until the bar marker is all the way to the right, this will make General Gorlok spawn.
step
goto 11.4,76.7
.talk 27606
..accept 12324 |daily
step
goto 10.1,77.3
.talk 27563
..accept 12317 |daily
step
goto 10.1,77.2
.talk 27532
..accept 12315 |daily
step
goto 18.0,79.6
.' Toss the Smoke Bomb into the buildings to smoke out Venture Co. Stragglers|use Smoke Bomb##37621
.' Building one can be found at [18.0,79.6]
.' Building two can be found at [16.4,76.6]
.' Building three can be found at [14.6,76.7]
.' Smoke out 20 Venture Company Stragglers|goal 20 Venture Company Stragglers smoked out|q 12324/1
step
goto 14.8,77.8
.' Kill Alliance Players or Westfall Brigade Marine in Venture Bay
.' Kill 10 Alliance in Venture Bay|goal 10 Alliance killed in Venture Bay|q 12317/1
step
goto 17.0,81.6
.kill Captain Brightwater##27509|q 12315/1
step
goto 16.4,80.3
.' Click the Element 115 in the back room of the ship|tip It looks like a red canister with a handle on the top
..collect Element 115##37664|q 12432
step
  goto 21.4,84.5
.' On the next step you will guide a rocket into this Alliance lumber boat
.' Your target will be the wooden X on the side
.' Go to 13.6,88.9
.' You will want to use your keys, not your mouse, to guide the rocket
.' Avoid icebergs or the rocket will explode and you will have to start over
.' Click a red rocket to take control of one|invehicle|c|q 12432	
step
goto 9.6,79.1
.' Hit the wooden X on the back of the Alliance Lumber boat
.' Destroy the Alliance Lumber boat|goal Destroyed Alliance Lumber Shipment|q 12432/1
step
goto 14.8,86.6
.talk 27708
..turnin 12432
.' If he's not there, then you have to take control of Venture Bay for the Horde
..' To take control of Venture Bay for the Horde, go to 15.1,88.0|tip Hide behind the lighthouse in between the 2 big brown rocks.  Flag yourself for PvP and a bar will appear under your minimap.  Sit here until the bar marker is all the way to the right, this will make General Gorlok spawn.
step
goto 11.4,76.7
.talk 27606
..turnin 12324
step
goto 10.1,77.3
.talk 27563
..turnin 12317
step
goto 10.1,77.2
.talk 27532
..turnin 12315
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Events Guides\\Brewfest (September 20th - October 6th)\\Brewfest Quests",[[
author support@zygorguides.com
description This guide section will walk you through completing the quests for the Brewfest event.
condition suggested isevent('Brewfest')
step
#include "H_Brewfest_Quests"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Events Guides\\Brewfest (September 20th - October 6th)\\Brewfest Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quests for the Brewfest event.
condition suggested isevent('Brewfest')
step
#include "H_Brewfest_Dailies"	
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Events Guides\\Brewfest (September 20th - October 6th)\\Brewfest Achievements",[[
author support@zygorguides.com
description This guide section will walk you through completing the achievements for the Brewfest event.
condition suggested isevent('Brewfest')
step
#include "H_Brewfest_Achievements"
]])
