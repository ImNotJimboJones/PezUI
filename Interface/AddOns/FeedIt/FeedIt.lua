-------------------------------------------------------------------------------
-- Upvalues
-------------------------------------------------------------------------------

local button
local setupEvent = 'PLAYER_ENTERING_WORLD'

-------------------------------------------------------------------------------
-- Setup
-------------------------------------------------------------------------------

local function Setup()
	button:UnregisterEvent(setupEvent)
	button:SetScript('OnEvent', nil)

	local function Print(msg, ...)
		print('|cffffff78FeedIt:|r '..msg)
	end
	
	local function Feedback(msg, ...)
		UIErrorsFrame:AddMessage('|cffffff78[FeedIt]|r |cffffCC00'..msg:format(...)..'|r')
	end

	-- Localization
	local NOT_AN_HUNTER = 'You are not an hunter. FeedIt is disabled.'
	local FEED_PET_UNKNOWN = 'You do not know the Feed Pet spell. FeedIt is disabled.'
	local DEAD_PET = '%s is dead.'
	local PET_IS_HAPPY = '%s is already happy.'
	local PET_IS_EATING = '%s is already eating.'
	local NO_SUITABLE_FOOD = 'Could not find suitable food for %s.'
	local FEEDING_PET_WITH = 'Feeding %s with %s.'
	local TRADE_GOODS = "Trade Goods"
	local BREAD, CHEESE, FISH, FRUIT, FUNGUS, MEAT
				
	local locale = GetLocale()
	if locale == 'enUS' or locale == 'enGB' then
		BREAD, CHEESE, FISH, FRUIT, FUNGUS, MEAT = 'Bread', 'Cheese', 'Fish', 'Fruit', 'Fungus', 'Meat'

	elseif locale == 'frFR' then
		BREAD, CHEESE, FISH, FRUIT, FUNGUS, MEAT = 'Pain', 'Fromage', 'Poisson', 'Fruit', 'Champignon', 'Viande'
		NOT_AN_HUNTER = "Vous n'êtes pas un chasseur. FeedIt désactivé."
		FEED_PET_UNKNOWN = "Vous ne connaissez pas Nourrir le familier. FeedIt désactivé."
		DEAD_PET = '%s est mort.'
		PET_IS_HAPPY = '%s est déjà heureux.'
		PET_IS_EATING = '%s est en train de manger.'
		NO_SUITABLE_FOOD = 'Pas de nourriture adaptée pour %s.'
		FEEDING_PET_WITH = '%s mange %s.'
		TRADE_GOODS = "Artisanat"
	
	elseif locale == 'deDE' then
		BREAD, CHEESE, FISH, FRUIT, FUNGUS, MEAT = 'Brot', 'Käse', 'Fisch', 'Frucht', 'Pilz', 'Fleisch'
		NOT_AN_HUNTER = 'Du bist kein Jaeger. FeedIt ist deaktiviert.'
		FEED_PET_UNKNOWN = 'Du hast noch nicht gelernt dein Tier zu fuettern. FeedIt ist deaktivert.'
		DEAD_PET = '%s ist tot.'
		PET_IS_HAPPY = '%s braucht momentan kein Futter.'
		PET_IS_EATING = '%s frisst doch schon.'
		NO_SUITABLE_FOOD = 'Finde kein brauchbares Futter im Inventar für %s.'
		TRADE_GOODS = "Handwerkswaren"

	elseif locale == 'koKR' then
		BREAD, CHEESE, FISH, FRUIT, FUNGUS, MEAT = '빵', '치즈', '물고기', '과일', '곰팡이류', '고기'
		-- NOT_AN_HUNTER = 'You are not an hunter. FeedIt is disabled.'
		-- FEED_PET_UNKNOWN = 'You do not know the Feed Pet spell. FeedIt is disabled.'
		-- DEAD_PET = '%s is dead.'
		-- PET_IS_HAPPY = '%s is already happy.'
		-- PET_IS_EATING = '%s is already eating.'
		-- NO_SUITABLE_FOOD = 'Could not find suitable food for %s.'
		TRADE_GOODS = "직업 용품"
		
	elseif locale == 'zhCN' then
		BREAD, CHEESE, FISH, FRUIT, FUNGUS, MEAT = '面包', '奶酪', '鱼类', '水果', '蘑菇', '肉类'
		-- NOT_AN_HUNTER = 'You are not an hunter. FeedIt is disabled.'
		-- FEED_PET_UNKNOWN = 'You do not know the Feed Pet spell. FeedIt is disabled.'
		-- DEAD_PET = '%s is dead.'
		-- PET_IS_HAPPY = '%s is already happy.'
		-- PET_IS_EATING = '%s is already eating.'
		-- NO_SUITABLE_FOOD = 'Could not find suitable food for %s.'
		TRADE_GOODS = "商品"
		
	elseif locale == 'zhTW' then
		BREAD, CHEESE, FISH, FRUIT, FUNGUS, MEAT = '麵包', '乳酪', '魚類', '水果', '菌類', '肉類'
		NOT_AN_HUNTER = '你不是一個獵人。 FeedIt 停用。'
		FEED_PET_UNKNOWN = '你尚未習得 餵養寵物。 FeedIt 停用。'
		DEAD_PET = '%s 死亡。'
		PET_IS_HAPPY = '%s 感到高興。'
		PET_IS_EATING = '%s 進食中。'
		NO_SUITABLE_FOOD = '未發現適合 %s 的食物。'
		TRADE_GOODS = "商品"
		
	elseif locale == 'esES' then
		BREAD, CHEESE, FISH, FRUIT, FUNGUS, MEAT = 'Pan', 'Queso', 'Pescado', 'Fruta', 'Hongo', 'Carne'
		-- NOT_AN_HUNTER = 'You are not an hunter. FeedIt is disabled.'
		-- FEED_PET_UNKNOWN = 'You do not know the Feed Pet spell. FeedIt is disabled.'
		-- DEAD_PET = '%s is dead.'
		-- PET_IS_HAPPY = '%s is already happy.'
		-- PET_IS_EATING = '%s is already eating.'
		-- NO_SUITABLE_FOOD = 'Could not find suitable food for %s.'
		TRADE_GOODS = "Objeto comerciable"
		
	--[=[
	elseif locale == 'ruRU' then
		BREAD, CHEESE, FISH, FRUIT, FUNGUS, MEAT = 'Pan', 'Queso', 'Pescado', 'Fruta', 'Hongo', 'Carne'
		-- NOT_AN_HUNTER = 'You are not an hunter. FeedIt is disabled.'
		-- FEED_PET_UNKNOWN = 'You do not know the Feed Pet spell. FeedIt is disabled.'
		-- DEAD_PET = '%s is dead.'
		-- PET_IS_HAPPY = '%s is already happy.'
		-- PET_IS_EATING = '%s is already eating.'
		-- NO_SUITABLE_FOOD = 'Could not find suitable food for %s.'
		TRADE_GOODS  = "Хозяйственные товары"
	--]=]
	else
		Print('FeedIt has not support for your locale ('..locale..'). It is disabled.')
		return
	end
	
	-- Disable if not an hunter
	if select(2, UnitClass('player')) ~= 'HUNTER' then
		Print(NOT_AN_HUNTER)
		return
	end

	-- Check Feed Pet spell
	local feedPetSpell = GetSpellInfo(GetSpellInfo(6991))
	if not feedPetSpell then
		Print(FEED_PET_UNKNOWN)
		return
	end
	local feedPetEffect = GetSpellInfo(1539)

	-- Create our food sets
	local foodSets = {	
		conjured = {}, -- special case
	}
	do
		-- Data ripped from LibPeriodicTable-3.1
		local sourceSets = {
			[BREAD] = {
				["Consumable.Food.Edible.Bread.Basic"] = "19696:50,20857:61,4540:61,4541:243,4542:552,4544:874,16169:874,4601:1392,8950:2148,23160:2148,29394:7500,27855:4320,28486:4320,24072:243,30816:61,29449:7500,42432:13200,42428:13200,42433:13200,42778:15000,33449:13200,42431:15000,42430:13200,44609:13200,42434:15000,42429:15000,35950:15000,58260:67500,58261:96000",
				["Consumable.Food.Edible.Combo.Conjured"] = "65500:1494,65515:1992,65516:2934,65517:4200,34062:7200,43518:12840,43523:19200,65499:19200",
				["Consumable.Food.Edible.Bread.Combo.Non-Conjured"] = "13724:2148,19301:4410,34780:7500",
			},
			[CHEESE] = {
				["Consumable.Food.Edible.Cheese.Basic"] = "2070:61,414:243,17406:243,422:552,1707:874,3927:1392,8932:2148,27857:4320,29448:7500,30458:4320,44607:15000,35952:15000,44608:13200,44749:13200,33443:13200,58258:67500,58259:96000",
			},
			[FISH] = {
				["Consumable.Food.Edible.Fish.Basic"] = "19996:50,1326:243,6316:243,21552:1392,16766:1392,2682:294,4592:243,4593:552,4594:874,5095:243,6290:61,6887:1392,787:61,8364:874,8957:2148,8959:1392,13546:1392,13930:1392,13935:2148,27661:4320,27858:4320,12238:243,13933:2148,29452:7500,33048:7500,35285:7500,43646:7500,33451:13200,43571:13200,44049:15000,35951:15000,44071:15000,62677:96000,58262:67500,58263:96000,58277:22500,56165:22500",
	["Consumable.Food.Edible.Fish.Combo"] = "21071:155,2682:294,21153:567,33004:2148,33053:7500,34760:15000,34761:15000,34759:15000,45932:15000,62651:67500,62652:67500,62654:67500,62655:67500,62656:67500,62657:67500,62659:67500,62660:67500,62661:96000,62663:96000,62666:96000,62667:96000,62668:96000,62669:96000,62671:96000",
				["Consumable.Food.Inedible.Fish"] = "2675,4603:874,4655,5468,5503,5504,6289:61,6291:30,6303:30,6308:243,6317:61,6361:61,6362:552,7974,8365:552,12206,13754:874,13755:874,13756:874,13758:874,13759:874,13760:874,13889:1392,13893:1392,15924,13890,13888:1392,27422,27435,27437,27438,27439,27429,27425,24477,2674,27515,27516,33823,33824,41812,41808,41805,41800,41807,41810,41809,41814,41802,41801,41806,41813,41803,36782,12207,43501,3685,6889,53062,53063,53064,53066,53067,53068,53070,53071,53072,62791",
			},
			[FRUIT] = {
				["Consumable.Food.Edible.Fruit.Basic"] = "29450:7500,19994:50,22324:2148,4536:61,4537:243,4538:552,4539:874,4602:1392,8953:2148,16168:1392,21033:2148,21031:2148,21030:1392,29393:4320,27856:4320,43087:15000,37252:13200,40356:13200,35948:15000,35949:13200,58264:67500,58265:96000,58278:22500,60267:61.2",
				["Consumable.Food.Edible.Fruit.Combo"] = "28112:4410,20031:2550",
			},
			[FUNGUS] = {
				["Consumable.Food.Edible.Fungus.Basic"] = "4604:61,4605:243,4606:552,4607:874,4608:1392,8948:2148,27859:4320,30355:7500,29453:7500,41751:4320,33452:13200,35947:15000,58266:67500,58267:96000,59228:67500,58279:22500",
				["Consumable.Food.Edible.Fungus.Combo"] = "3448:294",
				["Consumable.Food.Inedible.Fungus"] = "27676",
			},
			[MEAT] = {
				["Consumable.Food.Edible.Meat.Basic"] = "7097:61,21235:50,19995:50,2679:61,17407:874,6807:874,19224:874,19223:61,117:61,2287:243,19304:243,2681:61,2685:552,3770:552,3771:874,19305:552,4599:1392,5478:552,6890:243,19306:1392,9681:1392,9681:61,8952:2148,11444:2148,30610:4320,27854:4320,38427:4320,23495:61,17119:243,11444:2148,29451:7500,32685:7500,32686:7500,33254:7500,38428:7500,40359:13200,35953:15000,40358:13200,44072:15000,33454:13200,40202:15000,34747:15000,41729:15000,57544:61.2,58268:67500,58269:96000,58280:22500,59231:22500,59232:67500,60268:61.2,60377:61.2,62676:67500,62909:243.6,62910:552,65730:552,65731:552,67230:243.6,67270:2148,67271:2148,67272:2148,67273:2148",
				["Consumable.Food.Edible.Meat.Combo"]= " 62653:67500,62658:67500,62662:96000,62664:96000,62665:96000,62670:96000",
				["Consumable.Food.Inedible.Meat"] = "729,20424,769,1015,1081,2672,2673,2677,2924,3173,3404,3667,3712,3730,3731,4739,5051,5465,5467,5469,5470,5471,12037,12184,12202,12203,12204,12205,12208,12223,27669,27671,27677,27678,22644,27668,23676,31670,27674,31671,27682,27681,35562,1080,21024,2886,723,43011,43010,43009,33120,35794,43012,43013,34736,62779,62778,62780,62781,62782,62783,62784,62785,67229",
			},
		}

		-- Some items that pets do not like
		local blacklist = { [6807] = true }

		local PT3 = LibStub and LibStub('LibPeriodicTable-3.1', true)
		for foodType,sets in pairs(sourceSets) do
			local curSet = {}
			foodSets[foodType] =  curSet
			for name, setString in pairs(sets) do
				local pt3SetString = PT3 and PT3:GetSetString(name)
				if pt3SetString then
					setString = setString .. ',' .. pt3SetString
				end
				for item in setString:gmatch('[^,%s]+') do
					local id, value = strmatch(item, '(%d+):([%d%.]+)')
					id = id and tonumber(id) or tonumber(item)
					if not id then
						geterrorhandler()(format("Invalid item data:"..tostring(item)))
					elseif not blacklist[id] then
						curSet[id] = value and tonumber(value) or true
					end
				end
				if name:match('%.Conjured$') then
					for id in pairs(curSet) do
						foodSets.conjured[id] = true
					end
				end
			end
		end
	end

	local GetFoodSets
	do
		local tmp = {}
		function GetFoodSets(...)
			local n = select('#', ...)
			for i = 1, n do
				tmp[i] = foodSets[select(i, ...)]
			end
			for i = n+1,#tmp do
				tmp[i] = nil
			end
			return #tmp > 0 and tmp or nil
		end
	end

	local function GetBestPetFood()
		local petFoods = GetFoodSets(GetPetFoodTypes())
		if not petFoods then
			return
		end
		local requiredFoodLevel = UnitLevel('pet') - 15
		local playerHealth = UnitHealthMax('player')

		local bestFood, bestScore = nil, 0
		local includeTradeGoods = IsModifierKeyDown()

		-- Check every items of the sets
		for i,set in ipairs(petFoods) do
			for id,value in pairs(set) do
				local count = GetItemCount(id)
				if count > 0 then
					local name, _, _, level, reqLevel, category = GetItemInfo(id)
					if level >= requiredFoodLevel and (includeTradeGoods or category ~= TRADE_GOODS) then
						-- Fuzzy scoring
						local score = 0
						if type(value) == 'number' then
							-- Edible food, try to give lower level food first
							score = score + 100 * (playerHealth - value) / playerHealth
						else
							-- Unedible food always scores 100
							score = score + 100
						end
						-- Try to get rid of smaller piles first
						score = score - 2 * count
						-- Conjured items get an additionnal score boost
						if foodSets.conjured[id] then
							score = score + 50
						end
						--[===[@debug@
						print(name, category, score)
						--@end-debug@]===]

						if not bestFood or score > bestScore then
							bestFood, bestScore = name, score
						end
					end
				end
			end
		end
		return bestFood
	end
	--[===[@debug@
	_G.FI_GetBestPetFood = GetBestPetFood
	--@end-debug@]===]

	-------------------------------------------------------------------------------
	-- Button setup
	-------------------------------------------------------------------------------

	local function SetFood(item)
		if item then
			button:SetAttribute('type', 'spell')
			button:SetAttribute('spell', feedPetSpell)
			button:SetAttribute('target-item', item)
		elseif button:GetAttribute('spell') then
			button:SetAttribute('type', ATTRIBUTE_NOOP)
			button:SetAttribute('spell', nil)
			button:SetAttribute('target-item', nil)
		end
	end

	local function IsPetEating()
		local expirationTime = select(7, UnitBuff('pet', feedPetEffect))
		return expirationTime, expirationTime
	end

	local cooldown = 0
	local function OnPreClick()
		if InCombatLockdown() or cooldown >= GetTime() or not UnitExists('pet') then return end
		cooldown = GetTime() + 1.5
		local petName = UnitName('pet')
		if UnitIsDeadOrGhost('pet') then
			return Feedback(DEAD_PET, petName)
		end
		local happiness = GetPetHappiness()
		if happiness and happiness >= 3 then
			return Feedback(PET_IS_HAPPY, petName)
		end
		local isEating, expirationTime = IsPetEating()
		if isEating then
			cooldown = expirationTime
			return Feedback(PET_IS_EATING, petName)
		else
			local food = GetBestPetFood()
			if food then
				SetFood(food)
				Feedback(FEEDING_PET_WITH, petName, food)
			else
				return Feedback(NO_SUITABLE_FOOD, petName)
			end
		end
	end

	local function OnPostClick()
		if InCombatLockdown() then return end
		SetFood(nil)
	end

	-------------------------------------------------------------------------------
	-- Create the button and go
	-------------------------------------------------------------------------------

	button:SetScript("PreClick", OnPreClick)
	button:SetScript("PostClick", OnPostClick)
end

-------------------------------------------------------------------------------
-- Bootstrap
-------------------------------------------------------------------------------

button = CreateFrame('Button', 'FeedItButton', UIParent, "SecureActionButtonTemplate")
if IsLoggedIn() then
	Setup()
else
	button:RegisterEvent(setupEvent)
	button:SetScript('OnEvent', Setup)
end

-------------------------------------------------------------------------------
-- Binding localization
-------------------------------------------------------------------------------

_G['BINDING_HEADER_FEEDIT'] = select(2, GetAddOnInfo("FeedIt"))
_G['BINDING_NAME_CLICK FeedItButton:LeftButton'] = GetSpellInfo(6991)
