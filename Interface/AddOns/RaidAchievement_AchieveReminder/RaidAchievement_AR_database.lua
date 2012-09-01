﻿function ralldatabase()


--locations
ralllocations={604,604,543,543,529,529,535,535,527,527,718,718,532,532,531,531,609,609,522,533,521,542,534,530,603,602,601,520,528,536,525,526,523,524,756,764,767,753,768,769,757,759,747,752,754,758,773,781,793,800,820,819,816,824,443,461,401,482,512,540,736,626,871,874,898,876,867,885,877,875,887,897,896,886,878,999,884,999,999,999,882}

ralllocationnamesdef={"Icecrown Citadel","Icecrown Citadel","Trial of the Crusader", "Trial of the Crusader", "Ulduar", "Ulduar", "Naxxramas","Naxxramas","The Eye of Eternity","The Eye of Eternity","Onyxia's Lair","Onyxia's Lair","Vault of Archavon","Vault of Archavon","The Obsidian Sanctum","The Obsidian Sanctum","The Ruby Sanctum","The Ruby Sanctum","Ahn'kahet: The Old Kingdom","Azjol-Nerub","The Culling of Stratholme","Trial of the Champion","Drak'Tharon Keep","Gundrak","Halls of Reflection","Pit of Saron","The Forge of Souls","The Nexus","The Oculus","The Violet Hold","Halls of Lightning","Halls of Stone","Utgarde Keep","Utgarde Pinnacle", "The Deadmines","Shadowfang Keep","Throne of the Tides","Blackrock Caverns","The Stonecore","The Vortex Pinnacle","Grim Batol","Halls of Origination","Lost City of the Tol'vir","Baradin Hold","Blackwing Descent","The Bastion of Twilight","Throne of the Four Winds","Zul'Aman","Zul'Gurub", "Firelands","End Time","Hour of Twilight","Well of Eternity","Dragon Soul","Warsong Gulch","Arathi Basin","Alterac Valley","Eye of the Storm","Strand of the Ancients","Isle of Conquest","The Battle for Gilneas","Twin Peaks","Scarlet Halls","Scarlet Monastery","Scholomance","Stormstout Brewery","Temple of the Jade Serpent","Mogu'shan Palace","Shado-Pan Monastery","Gate of the Setting Sun","Siege of Niuzao Temple","Heart of Fear","Mogu'shan Vaults","Terrace of Endless Spring","A Brewing Storm", "Arena of Annihilation","Brewmoon Festval","Crypt of Forgotten Kings","Greenstone Village","Theramore's Fall","Unga Ingoo"}
rallcontent={2,2,2,2,2,2,2,2,2,2, 2,2,2,2,2,2,2,2,2,2, 2,2,2,2,2,2,2,2,2,2, 2,2,2,2,3,3,3,3,3,3, 3,3,3,3,3,3,3,3,3,3, 3,3,3,3,1,1,1,1,1,1,1,1,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}

ralltip={"10","25","10","25","10","25","10","25","10","25","10","25","10","25","10","25","10","25","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5",ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifraid,ralldifraid,ralldifraid,ralldifraid,ralldifparty,ralldifparty,ralldifraid,ralldifparty,ralldifparty,ralldifparty,ralldifraid,ramainbattleground,ramainbattleground,ramainbattleground,ramainbattleground,ramainbattleground,ramainbattleground,ramainbattleground,ramainbattleground,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifparty,ralldifraid,ralldifraid,ralldifraid,ralldifscenario,ralldifscenario,ralldifscenario,ralldifscenario,ralldifscenario,ralldifscenario,ralldifscenario}

rallachieve={
{4534,4535,4536,4537,4577,4538,4578,4582,4539,4579,4580,4601,4581,4531,4628,4528,4629,4529,4630,4527,4631,4530,4583,4532,4636},--icc10
{4610,4611,4612,4613,4615,4614,4616,4617,4618,4619,4620,4621,4622,4604,4632,4605,4633,4606,4634,4607,4635,4597,4584,4608,4637},--icc25
{3797,3936,3996,3798,3799,3800,3917,3918}, --toc10
{3813,3937,3997,3815,3816,3916,3812}, --toc25
{3097,2907,2905,2909,2911,2913,2914,2915,3056,2927,2925,2930,2923,2919,2934,2931,2933,2937,3058,2886,2947,2940,2941,2939,2945,2955,2959,2953,2951,3006,3076,2888,2969,2963,2961,2967,3182,2971,2973,2975,2977,3176,2979,2980,2985,2982,3177,3178,3179,2989,3138,3180,2890,2996,3181,3014,3009,3015,3008,3012,3157,3141,3158,3159,2892,2894,3003,3036},
{3098,2908,2906,2910,2912,2918,2916,2917,3057,2928,2926,2929,2924,2921,2936,2932,2935,2938,3059,2887,2948,2943,2944,2942,2946,2956,2960,2954,2952,3007,3077,2889,2970,2965,2962,2968,3184,2972,2974,2976,2978,3183,3118,2981,2984,2983,3185,3186,3187,3237,2995,3189,2891,2997,3188,3017,3011,3016,3010,3013,3161,3162,3163,3164,2893,2895,3002,3037},
{1858,1997,562,1996,2182,566,2176,568,1856,2178,2180,564,2146,572,2184,574,576,578},--naxx10
{1859,2140,563,2139,2183,567,2177,569,1857,2179,2181,565,2147,573,2185,575,577,579},--naxx25
{2148,622,1869,1874},--malygos10
{2149,623,1870,1875},--malygos25
{4402,4404,4403,4396},--onyxia10
{4405,4407,4406,4397},--onyxia25
{4016},--arka10
{4017},--arka25
{2047,1876,624,2049,2050,2051},--sart10
{2048,625,1877,2052,2053,2054},--sart25
{4817,4818},--halion10
{4815,4816},--halion25
{2038,2056,1862,492},--ankahet
{1296,1297,1860,491},--azjol
{1872,1817,500},--strat
{3802,3803,3804},--colis5
{2151,2057,2039,493},--draktaron
{2058,2040,1864,2152,495},--gundrak
{4526,4521},--reflect
{4524,4525,4520},--PitOfSaron
{4522,4523,4519},--ForgeOfSouls
{2150,2037,2036,490},--nexus
{2044,2045,2046,1871,1868,498},--oculus
{2153,2041,1816,494,1865},--VioletHold
{1834,2042,1867,497},--HallsOfLighting
{2154,1866,2155,496},--HallsOfStone
{1919,489},--utgard5
{2043,1873,2156,2157,499},--utgard5
{5366,5367,5368,5369,5370,5371,5083},--The Deadmines
{5503,5504,5505,5093},--Shadowfang Keep
{5285,5286,5061},--Throne of the Tides
{5281,5282,5283,5284,5060},--Blackrock Caverns
{5287,5063},--The Stonecore
{5289,5288,5064},--The Vortex Pinnacle
{5297,5298,5062},--Grim Batol
{5293,5294,5296,5295,5065},--Halls of Origination
{5291,5290,5292,5066},--Lost City of the Tol'vir
{5416,6045,6108},--Baradin Hold
{5306,5307,5310,5308,5309,4849,4842,5094,5107,5108,5109,5115,5116},--Blackwing Descent
{5300,4852,5311,5312,5313,4850,5118,5117,5119,5120,5121},--The Bastion of Twilight
{5304,5305,4851,5122,5123},--Throne of the Four Winds
{5761,5750,5858,5760,5769},--Zul'Aman
{5743,5762,5765,5759,5744,5768},--Zul'Gurub
{5821,5810,5813,5829,5830,5799,5855,5807,5808,5809,5806,5805,5804,5803,5802},--Firelands
{6130,5995,6117},--End Time
{6132,6119},--Hour of Twilight
{6127,6070,6118},--Well of Eternity
{6174,6128,6129,6175,6084,6105,6133,6180,6106,6107,6177,6109,6110,6111,6112,6113,6114,6115,6116},--Dragon Soul
{199,872,204,1251,200,1259,1502,207,712,1252,201,168,167,166,1173}, --warsong
{583,584,165,155,154,73,710,159,158,1153,161,156,157,162,1170},--arathi
{221,582,219,218,1164,706,873,708,224,226,223,1166,222,1168},--alterac
{233,216,784,209,208,214,212,211,213,587,1258,783,1171},--Eye of the Storm
{2191,1766,2189,1763,2200,2190,1764,2193,2192,1765,1310,1309,1761,1308,2195},--Strand of the Ancients
{3848,3849,3853,3854,3852,4256,3847,3855,3845,3777,3776,4177,3850,4176,3957},--Isle of Conquest
{5256,5257,5247,5246,5245,5248,5252,5262,5253,5255,5254,5251,5249,5250,5258},--The Battle for Gilneas
{5227,5552,5228,5222,5220,5216,5214,5211,5230,5215,5209,5210,5208,5259},--Twin Peaks
{6684,6427,6760},--Scarlet Halls
{6946,6928,6929,6761},--Scarlet Monastery
{6531,6394,6396,6821,6762},--Scholomance
{6402,6420,6400,6089,6456},--Stormstout Brewery
{6460,6671,6475,6758},--Temple of the Jade Serpent
{6713,6478,6736,6756},--Mogu'shan Palace
{6477,6472,6471,6470},--Shado-Pan Monastery
{6476,6479,6945,6759},--Gate of the Setting Sun
{6688,6485,6822,6763},--Siege of Niuzao Temple
{6937,6936,6553,6683,6518,6922,6718,6845,6725,6726,6727,6728,6729,6730},--Heart of Fear 
{6823,6674,7056,6687,6686,6455,6458,6844,6719,6720,6721,6722,6723,6724},--Mogu'shan Vaults
{6717,6933,6824,6825,6689,6731,6732,6733,6734},--Terrace of Endless Spring
{7261,7258,7257,7252},--A Brewing Storm
{},--Arena of Annihilation
{6931,6930,6923},--Brewmoon Festval
{},--Crypt of Forgotten Kings
{},--Greenstone Village
{},--Theramore's Fall
{7231,7232,7248,7249},--Unga Ingoo
}


if UnitFactionGroup("player")=="Alliance" then
--aliance
rallachieve[55]={199,872,204,203,200,1259,202,207,713,206,201,168,167,166,1172}
rallachieve[56]={583,584,165,155,154,73,711,159,158,1153,161,156,157,162,1169}
rallachieve[57]={221,582,219,218,225,707,220,709,1151,226,223,1166,222,1167}
--no difference for eye
rallachieve[59]={2191,1766,2189,1763,1757,2190,1764,2193,1762,1765,1310,1309,1761,1308,2194}
rallachieve[60]={3848,3849,3853,3854,3852,3856,3847,3855,3845,3777,3776,3851,3850,3846,3857}
--no difference for gilneas
rallachieve[62]={5226,5231,5229,5221,5219,5216,5213,5211,5230,5215,5209,5210,5208,5223}
end


rallboss={
{{36612},{36855},{0},{37813},{36626},{36627},{36678},{37970,37972,37973},{37955},{36789},{36853},{36597},{36597},{36612,36855,37813},{36612,36855,37813},{36626,36627,36678},{36626,36627,36678},{37970,37972,37973,37955},{37970,37972,37973,37955},{36789,36853},{36789,36853},{36597},{36597},{36612,36855,37813,36626,36627,36678,37970,37972,37973,37955,36789,36853,36597},{36612,36855,37813,36626,36627,36678,37970,37972,37973,37955,36789,36853,36597}},--icc10
{{36612},{36855},{0},{37813},{36626},{36627},{36678},{37970,37972,37973},{37955},{36789},{36853},{36597},{36597},{36612,36855,37813},{36612,36855,37813},{36626,36627,36678},{36626,36627,36678},{37970,37972,37973,37955},{37970,37972,37973,37955},{36789,36853},{36789,36853},{36597},{36597},{36612,36855,37813,36626,36627,36678,37970,37972,37973,37955,36789,36853,36597},{36612,36855,37813,36626,36627,36678,37970,37972,37973,37955,36789,36853,36597}},--icc25
{{34796},{35144,34799},{34780},{34458,34451,34459,34448,34449,34445,34456,34447,34441,34454,34455,34444,34450,34453,34461,34460,34465,34466,34467,34468,34469,34471,34472,34473,34463,34470,34474,34475},{34496,34497},{34564},{34796,34780,34497,34496,34564},{34796,34780,34497,34496,34564}}, --toc10
{{34796},{35144,34799},{34780},{34496,34497},{34564},{34796,34780,34497,34496,34564},{34796,34780,34497,34496,34564}}, --toc25
{{0},{33113},{33113},{33113},{33113},{33113},{33113},{33113},{33113},{33118},{33118},{33118},{33186},{33186},{33293},{33293},{33293},{33293},{33293},{33113,33118,33186,33293},{32867,32927,32857},{32867,32927,32857},{32867,32927,32857},{32867,32927,32857},{32867,32927,32857},{32930},{32930},{32930},{32930},{33515},{33515},{32867,32927,32857,32930,33515},{32845},{32845},{32845},{32845},{32845},{32865},{32865},{32865},{32865},{32865},{32915,32913,32914},{0},{32906},{32906},{32906},{32906},{32906},{33350,33432},{33350,33432},{33350,33432},{32845,32865,32906,33350,33432},{33271},{33271},{33134},{33134},{33134},{33134},{33134},{33134},{33134},{33134},{33134},{33271,33134},{33113,33118,33186,33293,32867,32927,32857,32930,33515,32845,32865,32906,33350,33432,33271,33134},{32871},{32871}},
{{0},{33113},{33113},{33113},{33113},{33113},{33113},{33113},{33113},{33118},{33118},{33118},{33186},{33186},{33293},{33293},{33293},{33293},{33293},{33113,33118,33186,33293},{32867,32927,32857},{32867,32927,32857},{32867,32927,32857},{32867,32927,32857},{32867,32927,32857},{32930},{32930},{32930},{32930},{33515},{33515},{32867,32927,32857,32930,33515},{32845},{32845},{32845},{32845},{32845},{32865},{32865},{32865},{32865},{32865},{32915,32913,32914},{0},{32906},{32906},{32906},{32906},{32906},{33350,33432},{33350,33432},{33350,33432},{32845,32865,32906,33350,33432},{33271},{33271},{33134},{33134},{33134},{33134},{33134},{33134},{33134},{33134},{33134},{33271,33134},{33113,33118,33186,33293,32867,32927,32857,32930,33515,32845,32865,32906,33350,33432,33271,33134},{32871},{32871}},
{{15956,15953,15952},{15956},{15956,15953,15952},{15936},{16011},{15954,15936,16011},{16064,16065,30549,16063},{16061,16060,16064,16065,30549,16063},{16028},{15929,15930},{15929,15930},{16028,15931,15932,15929,15930},{15989},{15989},{16428,15990},{15990},{15956,15953,15952,15954,15936,16011,16061,16060,16064,16065,30549,16063,16028,15931,15932,15929,15930,15989,15990},{15956,15953,15952,15954,15936,16011,16061,16060,16064,16065,30549,16063,16028,15931,15932,15929,15930,15989,15990}},--naxx10
{{15956,15953,15952},{15956},{15956,15953,15952},{15936},{16011},{15954,15936,16011},{16064,16065,30549,16063},{16061,16060,16064,16065,30549,16063},{16028},{15929,15930},{15929,15930},{16028,15931,15932,15929,15930},{15989},{15989},{16428,15990},{15990},{15956,15953,15952,15954,15936,16011,16061,16060,16064,16065,30549,16063,16028,15931,15932,15929,15930,15989,15990},{15956,15953,15952,15954,15936,16011,16061,16060,16064,16065,30549,16063,16028,15931,15932,15929,15930,15989,15990}},--naxx25
{{28859},{28859},{28859},{28859}},--malygos10
{{28859},{28859},{28859},{28859}},--malygos25
{{10184},{10184},{10184},{10184}},--onyxia10
{{10184},{10184},{10184},{10184}},--onyxia25
{{31125,33993,35013}},--arka10
{{31125,33993,35013}},--arka25
{{28860},{28860},{28860},{28860},{28860},{28860}},--sart10
{{28860},{28860},{28860},{28860},{28860},{28860}},--sart25
{{39863},{39863}},--halion10
{{39863},{39863}},--halion25
{{29309},{29310},{29311},{29309,29310,29311,29308,30258}},--ankahet
{{28684,28730,28729,28731},{28921},{29120},{28684,28921,29120}},--azjol
{{0},{0},{26529,26530,26532,26533}},--strat
{{34928},{35119},{35451}},--colis5
{{26630},{26631},{27483},{26630,26631,27483,26632}},--draktaron
{{29304},{29305},{29306,29932},{29306},{29304,29305,29306,29932,29307}},--gundrak
{{37226},{37226,38112,38113}},--reflect
{{36494},{0},{36494,36476,36658}},--PitOfSaron
{{36497},{36502},{36497,36502}},--ForgeOfSouls
{{26731},{26763},{26723},{26731,26763,26723,26794}},--nexus
{{27656},{27656},{27656},{27656},{0},{27656,27654,27447,27655}},--oculus
{{29314},{29313},{0},{31134},{29314,29313,29266,29315,29312,29316}},--VioletHold
{{28586},{28587},{28923},{28586,28587,28923,28546}},--HallsOfLighting
{{28070},{27975},{27978},{28070,27975,27978,27977}},--HallsOfStone
{{23953},{23953,24201,24200,23954}},--utgard5
{{26668},{26693},{26693},{26861},{26668,26693,26861,26687}},--utgard5
{{47162},{47296,47297},{49208,43778},{47626},{4739},{49541},{49541}},--The Deadmines
{{46962},{4278},{46964},{46964}},--Shadowfang Keep
{{40586},{44648,40792},{40792,44566}},--Throne of the Tides
{{39665},{39679},{39698},{39705},{39705}},--Blackrock Caverns
{{42333},{42333}},--The Stonecore
{{0,51157},{43875},{43875}},--The Vortex Pinnacle
{{39625},{40484},{40484}},--Grim Batol
{{39425},{39443,39428},{39908,39788},{39378},{39378}},--Halls of Origination
{{43614},{43612,43934},{44819},{44819}},--Lost City of the Tol'vir
{{47120},{52363},{55869}},--Baradin Hold
{{41570},{42178,42166,42179,42180},{41378},{41442},{43296},{41376},{41570,42178,42166,42179,42180,41378,41442,43296,41376},{41570},{42178,42166,42179,42180},{41378},{41442},{43296},{41376}},--Blackwing Descent
{{44600},{45992,45993},{43735,43686,43687,43688,43689},{43324},{45213},{44600,45992,45993,43735,43686,43687,43688,43689,43324},{44600},{45992,45993},{43735,43686,43687,43688,43689},{43324},{45213}},--The Bastion of Twilight
{{45871,45870,45872},{46753},{45871,45870,45872,46753},{45871,45870,45872},{46753}},--Throne of the Four Winds
{{0,24396},{23577},{0},{23863},{23863}}, --Zul'Aman
{{52155},{52151},{52059},{52148},{0,52440,52422,52442,52392,52438,52405,52418,52414},{52148}}, --Zul'Gurub
{{52498},{52558,53087,52577},{52530},{53691},{53494},{0,53619},{52409},{52498},{52558},{52530},{53691},{53494},{52571},{52409},{52498,52558,52530,53691,53494,52571,52409}},--Firelands
{{54123},{0,54544},{54432}},--End Time
{{54938},{54938}},--Hour of Twilight
{{55085},{54969},{54969}},--Well of Eternity
{{55265},{55308},{55312},{55689},{55294},{56427,55870,55891},{53879},{53879},{55265,55308,55312,55689},{55294,56427,53879,53879},{53879},{55265},{55308},{55312},{55689},{55294},{56427},{53879},{53879}},--Dragon Soul
{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}}, --Warsong Gulch
{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}},--arathi
{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}},--alterac
{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}},--Eye of the Storm
{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}},--Strand of the Ancients
{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}},--Isle of Conquest
{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}},--The Battle for Gilneas
{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}},--Twin Peaks
{{59303},{58632},{59150}},--Scarlet Halls
{{59789},{59223},{3977},{3977}},--Scarlet Monastery
{{10503},{59153},{59368},{1853,59100},{1853}},--Scholomance
{{0},{0},{0},{56637},{59479}},--Stormstout Brewery
{{56787},{56439},{56439},{56439}},--Temple of the Jade Serpent
{{0},{61243},{61398},{61398}},--Mogu'shan Palace
{{0,65407,56395},{56719},{56884},{56884}},--Shado-Pan Monastery
{{0},{56906},{56877},{56877}},--Gate of the Setting Sun
{{61634},{61485},{62205},{62205}},--Siege of Niuzao Temple
{{63554},{62543},{62164},{65501},{62511},{62837},{63554,62543,62164},{65501,62511,62837},{63554},{62543},{62164},{65501},{62511},{62837}},--Heart of Fear
{{60051,60043,59915,60047},{60009},{60143},{60701,60708,60709,60710},{60410},{60399,60400},{60051,60043,59915,60047,60009,60143},{60701,60708,60709,60710,60399,60400},{60051,60043,59915,60047,60410},{60009},{60143},{60701,60708,60709,60710},{60410},{60399,60400}},--Mogu'shan Vaults
{{60583},{62442},{63099},{60999},{60583,62442,63099,60999},{60583},{62442},{63099},{60999}},--Terrace of Endless Spring
{{0},{0,64381,59779},{58739},{58739}},--A Brewing Storm
{},--Arena of Annihilation
{{0},{0},{63528}},--Brewmoon Festval
{},--Crypt of Forgotten Kings
{},--Greenstone Village
{},--Theramore's Fall
{{0},{0},{0},{62465}},--Unga Ingoo
}


ralltrack  ={
{1,0,0,1,1,1,1,1,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0},--icc10
{1,0,0,1,1,1,1,1,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0},--icc25
{0,0,0,0,0,0,0,0}, --toc10
{0,0,0,0,0,0,0}, --toc25
{0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,1,1,0,0,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0},
{0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,1,1,0,0,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0},
{1,1,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0},--naxx10
{1,1,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0},--naxx25
{0,0,0,0},--malygos10
{0,0,0,0},--malygos25
{0,1,0,0},--onyxia10
{0,1,0,0},--onyxia25
{0},--arka10
{0},--arka25
{1,0,0,0,0,0},--sart10
{1,0,0,0,0,0},--sart25
{0,0},--halion10
{0,0},--halion25
{1,1,0,0},--ankahet
{0,1,0,0},--azjol
{0,0,0},--strat
{0,0,1},--colis5
{1,0,1,0},--draktaron
{1,1,0,1,0},--gundrak
{0,0},--reflect
{1,1,0},--PitOfSaron
{1,1,0},--ForgeOfSouls
{0,1,1,0},--nexus
{0,0,0,0,0,0},--oculus
{1,0,0,0,0},--VioletHold
{0,1,0,0},--HallsOfLighting
{1,0,1,0},--HallsOfStone
{0,0},--utgard5
{0,0,0,1,0},--utgard5
{1,0,1,0,1,1,0},--The Deadmines
{1,1,1,0},--Shadowfang Keep
{0,0,0},--Throne of the Tides
{1,1,1,1,0},--Blackrock Caverns
{0,0},--The Stonecore
{0,1,0},--The Vortex Pinnacle
{1,0,0},--Grim Batol
{1,0,1,1,0},--Halls of Origination
{0,0,1,0},--Lost City of the Tol'vir
{0,0,0},--Baradin Hold
{1,1,0,1,1,0,0,0,0,0,0,0,0},--Blackwing Descent
{0,0,0,1,0,0,0,0,0,0,0},--The Bastion of Twilight
{0,0,0,0,0},--Throne of the Four Winds
{0,1,0,0,0},--Zul'Aman
{1,1,1,0,0,0},--Gul'Gurub
{0,1,1,0,1,1,1,0,0,0,0,0,0,0,0},--Firelands
{1,0,0},--End Time
{1,0},--Hour of Twilight
{1,1,0},--Well of Eternity
{1,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0},--Dragon Soul
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, --Warsong Gulch
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},--arathi
{0,0,0,0,0,0,0,0,0,0,0,0,0,0},--alterac
{0,0,0,0,0,0,0,0,0,0,0,0,0},--Eye of the Storm
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},--Strand of the Ancients
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},--Isle of Conquest
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},--The Battle for Gilneas
{0,0,0,0,0,0,0,0,0,0,0,0,0,0},--Twin Peaks
{1,1,0},--Scarlet Halls
{1,1,1,0},--Scarlet Monastery
{0,1,1,0,0},--Scholomance
{0,0,0,1,0},--Stormstout Brewery
{1,0,0,0},--Temple of the Jade Serpent
{0,0,0,0},--Mogu'shan Palace
{0,0,1,0},--Shado-Pan Monastery
{0,0,1,0},--Gate of the Setting Sun
{1,1,0,0},--Siege of Niuzao Temple
{},--Heart of Fear 
{},--Mogu'shan Vaults
{},--Terrace of Endless Spring
{},--A Brewing Storm
{},--Arena of Annihilation
{},--Brewmoon Festval
{},--Crypt of Forgotten Kings
{},--Greenstone Village
{},--Theramore's Fall
{},--Unga Ingoo
}--1 если трекерится


rallmeta   ={
{1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0},--icc10
{1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0},--icc25
{0,0,0,0,0,0,0,0}, --toc10
{0,0,0,0,0,0,0}, --toc25
{0,0,0,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,1,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0},
{0,0,0,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,1,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0},
{1,1,0,1,0,0,0,0,1,1,1,0,1,0,1,0,0,1},--naxx10
{1,1,0,1,0,0,0,0,1,1,1,0,1,0,1,0,0,1},--naxx25
{1,0,1,1},--malygos10
{1,0,1,1},--malygos25
{0,0,0,0},--onyxia10
{0,0,0,0},--onyxia25
{0},--arka10
{0},--arka25
{1,0,0,0,0,1},--sart10
{1,0,0,0,0,1},--sart25
{0,0},--halion10
{0,0},--halion25
{1,1,1,0},--ankahet
{1,1,1,0},--azjol
{1,1,0},--strat
{0,0,0},--colis5
{1,1,1,0},--draktaron
{1,1,1,1,0},--gundrak
{0,0},--reflect
{0,0,0},--PitOfSaron
{0,0,0},--ForgeOfSouls
{1,1,1,0},--nexus
{1,1,1,1,1,0},--oculus
{1,1,1,0,1},--VioletHold
{1,1,1,0},--HallsOfLighting
{1,1,1,0},--HallsOfStone
{1,0},--utgard5
{1,1,1,1,0},--utgard5
{1,1,1,1,1,1,0},--The Deadmines
{1,1,1,0},--Shadowfang Keep
{1,1,0},--Throne of the Tides
{1,1,1,1,0},--Blackrock Caverns
{1,0},--The Stonecore
{1,1,0},--The Vortex Pinnacle
{1,1,0},--Grim Batol
{1,1,1,1,0},--Halls of Origination
{1,1,1,0},--Lost City of the Tol'vir
{0,0,0},--Baradin Hold
{1,1,1,1,1,1,0,1,1,1,1,1,1},--Blackwing Descent
{1,1,1,1,0,0,1,1,1,1,0},--The Bastion of Twilight
{1,1,0,1,1},--Throne of the Four Winds
{0,0,0,0,0},--Zul'Aman
{0,0,0,0,0,0},--Zul'Gurub
{1,1,1,1,1,1,0,1,1,1,1,1,1,0,0},--Firelands
{0,0,0},--End Time
{0,0},--Hour of Twilight
{0,0,0},--Well of Eternity
{1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1},--Dragon Soul
{1,1,1,1,1,0,1,1,0,1,1,1,1,0,0}, --Warsong Gulch
{1,1,1,1,0,1,0,1,1,1,1,1,1,1,0},--arathi
{1,1,1,0,1,1,1,0,1,1,1,1,1,0},--alterac
{1,1,1,1,0,1,1,0,1,0,0,1,0},--Eye of the Storm
{1,1,1,1,1,1,1,1,1,1,1,1,1,0,0},--Strand of the Ancients
{1,1,1,1,1,1,1,1,0,1,0,1,1,0,0},--Isle of Conquest
{1,1,1,1,0,1,1,1,1,1,1,1,1,1,0},--The Battle for Gilneas
{1,1,1,1,1,1,1,1,1,1,1,1,0,0},--Twin Peaks
{1,1,0},--Scarlet Halls
{1,1,1,0},--Scarlet Monastery
{1,1,1,1,0},--Scholomance
{0,0,0,0,0},--Stormstout Brewery
{1,1,1,0},--Temple of the Jade Serpent
{1,1,1,0},--Mogu'shan Palace
{1,1,1,0},--Shado-Pan Monastery
{1,1,1,0},--Gate of the Setting Sun
{1,1,1,0},--Siege of Niuzao Temple
{1,1,1,1,1,1,0,0,1,1,1,1,1,1},--Heart of Fear 
{1,1,1,1,1,1,0,0,1,1,1,1,1,1},--Mogu'shan Vaults
{1,1,1,1,0,1,1,1,1},--Terrace of Endless Spring
{1,1,1,0},--A Brewing Storm
{},--Arena of Annihilation
{1,1,0},--Brewmoon Festval
{},--Crypt of Forgotten Kings
{},--Greenstone Village
{},--Theramore's Fall
{1,1,1,0},--Unga Ingoo
}--1 если на мету


rallfullver={
{0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},--icc10
{0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},--icc25
{0,0,0,0,0,0,1,1}, --toc10
{0,0,0,0,0,1,1}, --toc25
{0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,0,0,1,1,0,1},
{0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,0,0,1,1,0,1},
{0,0,1,0,0,1,0,1,0,0,0,1,0,1,0,1,1,0},--naxx10
{0,0,1,0,0,1,0,1,0,0,0,1,0,1,0,1,1,0},--naxx25
{0,1,0,0},--malygos10
{0,1,0,0},--malygos25
{0,0,0,1},--onyxia10
{0,0,0,1},--onyxia25
{0},--arka10
{0},--arka25
{0,1,0,1,1,0},--sart10
{0,1,0,1,1,0},--sart25
{1,1},--halion10
{1,1},--halion25
{0,0,0,1},--ankahet
{0,0,0,1},--azjol
{0,0,1},--strat
{0,0,0},--colis5
{0,0,0,1},--draktaron
{0,0,0,0,1},--gundrak
{0,1},--reflect
{0,0,1},--PitOfSaron
{0,0,1},--ForgeOfSouls
{0,0,0,1},--nexus
{0,0,0,0,0,1},--oculus
{0,0,0,1,0},--VioletHold
{0,0,0,1},--HallsOfLighting
{0,0,0,1},--HallsOfStone
{0,1},--utgard5
{0,0,0,0,1},--utgard5
{0,0,0,0,0,0,1},--The Deadmines
{0,0,0,1},--Shadowfang Keep
{0,0,1},--Throne of the Tides
{0,0,0,0,1},--Blackrock Caverns
{0,1},--The Stonecore
{0,0,1},--The Vortex Pinnacle
{0,0,1},--Grim Batol
{0,0,0,0,1},--Halls of Origination
{0,0,0,1},--Lost City of the Tol'vir
{1,1,1},--Baradin Hold
{0,0,0,0,0,0,1,1,1,1,1,1,1},--Blackwing Descent
{0,0,0,0,0,1,1,1,1,1,1},--The Bastion of Twilight
{0,0,1,1,1},--Throne of the Four Winds
{0,0,0,0,1},--Zul'Aman
{0,0,0,0,0,1},--Zul'Gurub
{0,0,0,0,0,0,0,1,1,1,1,1,1,1,1},--Firelands
{0,0,1},--End Time
{0,1},--Hour of Twilight
{0,0,1},--Well of Eternity
{0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1},--Dragon Soul
{0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},--Warsong Gulch
{0,0,0,0,1,0,0,0,0,0,0,0,0,0,1},--arathi
{0,0,0,1,0,0,0,0,0,0,0,0,0,1},--alterac
{0,0,0,0,1,0,0,0,0,0,0,0,1},--Eye of the Storm
{0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},--Strand of the Ancients
{0,0,0,0,0,0,0,0,0,0,1,0,0,0,1},--Isle of Conquest
{0,0,0,0,1,0,0,0,0,0,0,0,0,0,1},--The Battle for Gilneas
{0,0,0,0,0,0,0,0,0,0,0,0,1,1},--Twin Peaks
{0,0,1},--Scarlet Halls
{0,0,0,1},--Scarlet Monastery
{0,0,0,0,1},--Scholomance
{0,0,0,0,1},--Stormstout Brewery
{0,0,0,1},--Temple of the Jade Serpent
{0,0,0,1},--Mogu'shan Palace
{0,0,0,1},--Shado-Pan Monastery
{0,0,0,1},--Gate of the Setting Sun
{0,0,0,1},--Siege of Niuzao Temple
{0,0,0,0,0,0,1,1,1,1,1,1,1,1},--Heart of Fear 
{0,0,0,0,0,0,1,1,1,1,1,1,1,1},--Mogu'shan Vaults
{0,0,0,0,1,1,1,1,1},--Terrace of Endless Spring
{0,0,0,1},--A Brewing Storm
{},--Arena of Annihilation
{0,0,1},--Brewmoon Festval
{},--Crypt of Forgotten Kings
{},--Greenstone Village
{},--Theramore's Fall
{0,0,0,1},--Unga Ingoo
}--1 это только для фулл версии ачивка


end