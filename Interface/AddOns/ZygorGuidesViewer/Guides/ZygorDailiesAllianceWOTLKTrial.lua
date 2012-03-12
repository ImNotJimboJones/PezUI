local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("DailiesAWOTLK") then return end
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Grizzly Hills Pre-Quests",[[
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
.' Capture a Live Ice Troll|q 11984/1
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
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Blackriver Logging Camp Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quest in the Blackriver Logging Camp region of Grizzly Hills.
description There are no pre-quests needed to unlock the daily quest offered in this guide section.
daily
step
goto Grizzly Hills,30.0,59.8
.talk 27783
..accept 12444
step
goto 28.3,63.4
.' Kill Horde Players or Conquest Hold Raiders in the Blackriver Logging Camp
.' Kill 10 Horde in Blackriver|goal 10 Horde in Blackriver slain|q 12444/1
step
goto 30.0,59.8
.talk 27783
..turnin 12444
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Blue Sky Logging Grounds Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quests in the Blue Sky Logging Grounds region of Grizzly Hills.
description There are no pre-quests needed to unlock the daily quests offered in this guide section.
daily
step
goto Grizzly Hills,39.3,43.9
.talk 27468
..accept 12289|daily
step
goto 39.5,43.6
.talk 27371
..accept 12244|daily
step
goto 39.6,43.4
.talk 27416
..accept 12268|daily
step
goto 40.5,42.7
.talk 27484
..accept 12296|daily
step
goto 34.9,39.8
.' Use Renewing Bandages on Wounded Wesfall Infantry|use Renewing Bandage##37576
.' Heal 10 Westfall Infantry|goal 10 Westfall Infantry Healed|q 12296/1
.' Click Grooved Cogs, Notched Sprockets, and High Tension Springs on the ground of the Blue Sky Logging Grounds
..get 4 Grooved Cogs##37412|q 12268/1
..get 3 Notched Sprockets##37413|q 12268/2
..get 2 High Tension Springs##37416|q 12268/3
step
goto 33.4,35.7
.' Kill Horde Players or Wounded Skirmishers in the area
.' Eliminate 15 Horde units|goal 15 Horde units eliminated|q 12289/1
step
goto 34.9,39.8
.' Find the Broken-down Shredder that spawns. Blizzards quest helper will mark it on your map for you.
.' Click the Broken-down Shredder to get inside it
.' Use your abilities on your hot bar to return the shredder to Synipus|goto Grizzly Hills,39.5,43.6
.' Deliver 3 Shredders|goal 3 Shredder Delievered|q 12244/1
step
goto 39.3,43.9
.talk 27468
..turnin 12289
step
goto 39.5,43.6
.talk 27371
..turnin 12244
step
goto 39.6,43.4
.talk 27416
..turnin 12268
step
goto 40.5,42.7
.talk 27484
..turnin 12296
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Granite Springs Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quest in the Granite Springs region of Grizzly Hills.
daily
step
goto Grizzly Hills,16.7,48.3
.talk 26604
..accept 12038
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
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Dailies Guides\\Northrend (70 - 80)\\Grizzly Hills\\Venture Bay Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quests in the Venture Bay region of Grizzly Hills.
description There are no pre-quests needed to unlock the daily quests offered in this guide section.
daily
step
goto Grizzly Hills,14.8,86.6
.talk 27759
..accept 12437
.' If he's not there, then you have to take control of Venture Bay for the Alliance
..' To take control of Venture Bay for the Alliance, go to 15.1,88.0|tip Hide behind the lighthouse in between the 2 big brown rocks. Flag yourself for PvP and a bar will appear under your minimap. Sit here until the bar marker is all the way to the left, this will make Commander Howser spawn.
step
goto 22.1,81.2
.talk 27602
..accept 12323
step
goto 22.1,81.2
.talk 27562
..accept 12316
step
goto 22.2,81.2
.talk 27520
..accept 12314
step
goto 18.0,79.6
.' Toss the Smoke Bomb into the buildings to smoke out Venture Co. Stragglers|use Smoke Bomb##37621
.' Building one can be found at [18.0,79.6]
.' Building two can be found at [16.4,76.6]
.' Building three can be found at [14.6,76.7]
.' Smoke out 20 Venture Company Stragglers|goal 20 Venture Company Stragglers smoked out|q 12323/1
step
goto 19.9,76.4
.' Kill Horde Players or Conquest Hold Berserker in Venture Bay
.' Kill 10 Horde in Venture Bay|goal 10 Horde killed in Venture Bay|q 12316/1
step
goto 13.3,80.2
..kill Captain Zorna##27511|q 12314/1
step
goto 16.4,80.3
.' Click the Element 115 in the back room of the ship|tip It looks like a red canister with a handle on the top
..collect Element 115##37664|q 12437
step
goto 9.6,79.2
.' On the next step you will guide a rocket into this Horde Lumberboat
.' Your target will be the wooden X on the back
.' Go to 13.6,88.9|goto Grizzly Hills,13.6,88.9,0.5
.' You will want to use your keys, not your mouse, to guide the rocket
.' Avoid icebergs or the rocket will explode and you will have to start over
.' Click a red rocket to take control of one|invehicle|c|q 12437
step
goto 9.6,79.1
.' Hit the wooden X on the back of the Horde Lumberboat
.' Destroy the Horde Lumberboat|goal Horde Lumberboat destroyed|q 12437/1
step
goto 14.8,86.6
.talk 27759
..turnin 12437
step
goto 22.1,81.2
.talk 27562
..turnin 12316
step
goto 22.1,81.2
.talk 27520
..turnin 12314
step
goto 22.1,81.2
.talk 27602
..turnin 12323
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Events Guides\\Lunar Festival (January 22nd - February 12th)\\Lunar Festival Main Questline",[[
author support@zygorguides.com
description This guide section will walk you through completing the main questline for the Lunar Festival event.
step
#include "Lunar Festival Main Quest"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Events Guides\\Lunar Festival (January 22nd - February 12th\\Lunar Festival Optimized Elders Path",[[
author support@zygorguides.com
description This guide section will walk you through an optimized path for honoring the elders
description that are spread out all over Azeroth for the Lunar Festival event.
description The 13 elders that are inside instances are not included in this guide section.
description Using this guide section, you will collect 62 of the total 75 Coins of Ancestry.
step
#include "Lunar Festival Elder Path"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Events Guides\\Lunar Festival (January 22nd - February 12th)\\Lunar Festival Achievements",[[
description
step
#include "Lunar Festival Achievement"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Events Guides\\Love is in the Air (February 6th - 20th)\\Love is in the Air Main Questline",[[
author support@zygorguides.com
description This guide section will walk you through completing the main questline for the Love is in the Air event.
step
#include "Love is in the Air Main Quest"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Events Guides\\Love is in the Air (February 6th - 20th)\\Love is in the Air Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the Love is in the Air even daily quests.
daily
step
#include "Love is in the Air Daillies"
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Events Guides\\Love is in the Air (February 6th - 20th)\\Love is in the Air Achievements",[[
author support@zygorguides.com
description This guide section will walk you through completing the Love is in the Air event achievements.
step
#include "Love is in the Air Achievement"
]])
