local addonName, addon = ...;

addon.L = {};
local L = addon.L;

L.slashCmdTag = "farm";
L.slashCmdShow = "show";
L.growCheckTitle = "Grow Check";
L.growCheckDescription = "This button will target any plant needing attention.";
L.dropToolsTitle = "Drop All Tools";
L.dropToolsDescription = "This button will drop all farm tools in your inventory.";
L.farmWindowLabelText = "Farming Tool Panel";
L.farmWindowForecastLabel = "Forecast";
L.farmWindowForecastChange = "(Update in %d:%02d)"; -- %d = hours, %02d = minutes
L.forecastSeedButtonTooltip = "If you plant this seed today, you will get extra crops tomorrow";
L.forecastSeedNoInfoTooltip = "No forecast information available for today's seed. Talk to Jogu the Drunk to learn about tomorrow's crops";
L.forecastCropButtonTooltip = "If you harvest this crop today, you will get more than usual";
L.forecastCropNoInfoTooltip = "No forecast information available for today's crop. You should have talked to Jogu yesterday!";
L.farmWindowShowInCombatError = "Sorry, can't do that in combat. Try again later!";
L.portalButtonNoFactionText = "Sorry, you can't get off the Wandering Isle that easily!";

L.pluginName = "Farm";
L.pluginDescription = "Adds a button panel for farming tasks.\n\nThis config panel can be accessed directly by typing /ThnanMod farm.\nThe tool panel can be shown at any time by typing /ThnanMod farm show.";
L.visibilityLabelText = "Visibility Options";
L.dropLabelText = "Tool Drop Options";
L.showAutomaticallyCheckBoxLabel = "Show farm window on farm";
L.showAutomaticallyCheckBoxTooltip = "This option will cause the farm tool panel to appear when entering Sunsong Ranch and disappear when leaving.";
L.hideInCombatCheckBoxLabel = "Hide in combat";
L.hideInCombatCheckBoxTooltip = "This option will cause the farm tool panel to hide when entering combat and reappear when leaving combat.";
L.hideWhenEmptyCheckBoxLabel = "Hide when you don't have seeds/tools";
L.hideWhenEmptyCheckBoxTooltip = "This option will cause the farm tool panel to hide when you don't have seeds or tools in your inventory and reappear when you acquire a seed or tool.";
L.hideInVehicleCheckBoxLabel = "Hide in \"vehicle\" plants";
L.hideInVehicleCheckBoxTooltip = "This option will cause the farm tool panel to hide when entering plant \"vehicles\" and reappear when leaving.";
L.hideWhenMountedCheckBoxLabel = "Hide When Mounted";
L.hideWhenMountedCheckBoxTooltip = "This option will cause the farm tool panel to hide when you are mounted and reappear when you dismount.";
L.dropOnRightClickCheckBoxLabel = "Drop tool on right click";
L.dropOnRightClickCheckBoxTooltip = "This option will make right clicking a tool button drop that tool."
L.dropOnLeavingFarmCheckBoxLabel = "Drop tools when leaving farm";
L.dropOnLeavingFarmCheckBoxTooltip = "This option will make you drop all the farm tools when you leave the farm.";


L.sunsongRanchName = "Sunsong Ranch";
L.joguPredictsGreenCabbage = "Oooh... ooooh! My shenses are tingling! I see... huge Green Cabbages in your future.";
L.joguPredictsScallion = "Have I ever told you that I hate Scallions? Hate 'em!\n\n<Jogu lets out a loud belch.>\n\nUnfortunately for me, they're going to be in high season tomorrow.";
L.joguPredictsRedBlossomLeek = "Shpring for a leek, and you might get two.";
L.joguPredictsWhiteTurnip = "Fields of white turnips. Raw and shpicy!"; -- unconfirmed
L.joguPredictsWitchberry = "Which berries should you plant? Witchberries, of course!";
L.joguPredictsJuicycrunchCarrot = "You ever heard of a juishycrunch carrot? They'll never be juisher than tomorrow.";
L.joguPredictsMoguPumpkin = "Pumpkins! It'sh gonna be huge, gigantic pumpkins!";
L.joguPredictsPinkTurnip = "I'm seeing Pink Turnipsh in your future.";
L.joguPredictsJadeSquash = "Jade Squash grow the color of milky jade. Conditionsh will be perfect tomorrow for growing thish vegetable... I think.";
L.joguPredictsStripedMelon = "Striped melons are quite juishy this time of year! Put some sheeds in the ground, and you will reap the harvest on the morrow.";

--[[ Template for other localizations ]]--

local locale = GetLocale();

--[[

if (locale == "<locale code>") then
	L.slashCmdTag = "farm";
	L.slashCmdShow = "show";
	L.growCheckTitle = "Grow Check";
	L.growCheckDescription = "This button will target any plant needing attention.";
	L.dropToolsTitle = "Drop All Tools";
	L.dropToolsDescription = "This button will drop all farm tools in your inventory.";
	L.farmWindowLabelText = "Farming Tool Panel";
	L.farmWindowForecastLabel = "Forecast";
	L.farmWindowForecastChange = "(Update in %d:%02d)"; -- %d = hours, %02d = minutes
	L.forecastSeedButtonTooltip = "If you plant this seed today, you will get extra crops tomorrow";
	L.forecastSeedNoInfoTooltip = "No forecast information available for today's seed. Talk to Jogu the Drunk to learn about tomorrow's crops";
	L.forecastCropButtonTooltip = "If you harvest this crop today, you will get more than usual";
	L.forecastCropNoInfoTooltip = "No forecast information available for today's crop. You should have talked to Jogu yesterday!";
	L.farmWindowShowInCombatError = "Sorry, can't do that in combat. Try again later!";
	
	L.pluginName = "Farm";
	L.pluginDescription = "Adds a button panel for farming tasks.\n\nThis config panel can be accessed directly by typing /ThnanMod farm.\nThe tool panel can be shown at any time by typing /ThnanMod farm show.";
	L.visibilityLabelText = "Visibility Options";
	L.dropLabelText = "Tool Drop Options";
	L.showAutomaticallyCheckBoxLabel = "Show farm window on farm";
	L.showAutomaticallyCheckBoxTooltip = "This option will cause the farm tool panel to appear when entering Sunsong Ranch and disappear when leaving.";
	L.hideInCombatCheckBoxLabel = "Hide in combat";
	L.hideInCombatCheckBoxTooltip = "This option will cause the farm tool panel to hide when entering combat and reappear when leaving combat.";
	L.hideWhenEmptyCheckBoxLabel = "Hide when you don't have seeds/tools";
	L.hideWhenEmptyCheckBoxTooltip = "This option will cause the farm tool panel to hide when you don't have seeds or tools in your inventory and reappear when you acquire a seed or tool.";
	L.hideInVehicleCheckBoxLabel = "Hide in \"vehicle\" plants";
	L.hideInVehicleCheckBoxTooltip = "This option will cause the farm tool panel to hide when entering plant \"vehicles\" and reappear when leaving.";
	L.dropOnRightClickCheckBoxLabel = "Drop tool on right click";
	L.dropOnRightClickCheckBoxTooltip = "This option will make right clicking a tool button drop that tool."
	L.dropOnLeavingFarmCheckBoxLabel = "Drop tools when leaving farm";
	L.dropOnLeavingFarmCheckBoxTooltip = "This option will make you drop all the farm tools when you leave the farm.";
end

--]]

if (locale == "ptBR" or locale == "ptPT") then
	L.sunsongRanchName = "Fazenda Sol Cantante";
	L.joguPredictsGreenCabbage = "Ooooh... oooooh! Meush sentidosh estão formigando! Eu vejo... um Grande Repolho no seu futuro.";
	L.joguPredictsScallion = "Eu já te falei alguma vez que odeio shebolinhas? Eu ODEIO!\n\n<Be Bum arrota bem alto.>\n\nMas infelizmente elash vão estar na alta temporada amanhã.";
	L.joguPredictsRedBlossomLeek = "Alho-poró, piriri-pororó.";
	L.joguPredictsWhiteTurnip = "Camposh de nabosh brancosh! Crush e picantesh!";
	L.joguPredictsWitchberry = "Puxa que puxa, vai lá plantar Uvas-de-bruxa!";
	L.joguPredictsJuicycrunchCarrot = "Você já ouviu falar dash chenouras moderlíchia? Amanhã elas vão eshtar no ponto!";
	L.joguPredictsMoguPumpkin = "Abróbas! Vai ser uma abrobona gigante!";
	L.joguPredictsPinkTurnip = "Eu tô vendo Nabosh Rosa no teu futuro.";
	L.joguPredictsJadeSquash = "Abóborash de Jade ficam da cor de jade leitoso. Ash condichões eshtarão perfeitash amanhã para plantar esshe vegetal... Eu acho.";
	L.joguPredictsStripedMelon = "Melõesh lishtrados shão bem shuculentosh nesha eshtachão! Plante umash shementes e vochê terá shua colheita amanhã.";
end

if (locale == "frFR") then
	L.sunsongRanchName = "Ferme Chant du Soleil";
	L.joguPredictsGreenCabbage = "Oooh… Ooooh ! J’ai l’ravioli en fusion ! J’vois… J’vois d’énormes choux verts dans votre avenir.";
	L.joguPredictsScallion = "Je vous ai déjà dit que j’ai horreur des échalotes ? J’déteshte ça !\n\n<Jogu laisse échapper un rot sonore.>\n\nMalheureusement pour moi, à partir de demain, on shera en plein dans la saison.";
	L.joguPredictsRedBlossomLeek = "Pas besoin de poireauter pour avoir des poireaux.";
	L.joguPredictsWhiteTurnip = "Des champs de navets blancs, crus et goûtus.";
	L.joguPredictsWitchberry = "Rien de mieux que de bonne sorcielles rafraîchissantes !";
	L.joguPredictsJuicycrunchCarrot = "Vous avez déjà entendu parler des carottes croquejuteuses ? Elles ne sheront jamais aussi juteuses que demain.";
	L.joguPredictsMoguPumpkin = "Des chitrouilles ! Y aura pleins de chitrouilles gigantasmatiques !";
	L.joguPredictsPinkTurnip = "J’vois des navets roses dans votre avenir.";
	L.joguPredictsJadeSquash = "Les melons de jade prennent la couleur du jade laiteux. Demain, toutes les conditions seront réunish pour faire pousser ce fruish… je crois.";
	L.joguPredictsStripedMelon = "Les melons à rayures shont très shavoureux en cette shaison ! Mettez quelques graines en terre et vous pourrez moisshonner dès le lendemain.";
end

if (locale == "deDE") then
	L.sunsongRanchName = "Gehöft Sonnensang";
	L.joguPredictsGreenCabbage = "Oooh.. ooooh! Ich spüre etwas! Ich schehe... riesigen Grünkohl in Eurer Zukunft.";
	L.joguPredictsScallion = "Hab ich Euch schon gesagt, dass ich Frühlingszwiebeln hasse? Ich hasse sie!\n\n<Jogu rülpst laut.>\n\nDummerweise haben sie morgen Hochsaison.";
	L.joguPredictsRedBlossomLeek = "Baut eine Stange Lauch an und vielleicht werden zwei darausch.";
	L.joguPredictsWhiteTurnip = "Felder weischer Rüben. Roh und scharf!";
	L.joguPredictsWitchberry = "Welche Beeren wachsen wie verhext? Hexenbeeren natürlich!";
	L.joguPredictsJuicycrunchCarrot = "Kennt Ihr schaftigleckere Karotten? Morgen werden sie am allerschaftigsten sein.";
	L.joguPredictsMoguPumpkin = "Mogukürbische! Rieschige, gigantische Mogukürbische!";
	L.joguPredictsPinkTurnip = "Ich sehe roscha Rüben in Eurer Zukunft.";
	L.joguPredictsJadeSquash = "Jadekürbische haben die Farbe milchiger Jade. Morgen werden die Bedingungen für den Anbau dieschesch Gewächsch perfekt schein... glaube ich.";
	L.joguPredictsStripedMelon = "In dieser Zeit des Jahres schind Streifenmelonen schön süsch! Pflanzt einige Samen und Ihr werdet schon Morgen die Ernte einholen können.";
end

if (locale == "itIT") then
	L.sunsongRanchName = "Tenuta Cantasole";
	L.joguPredictsGreenCabbage = "Oooh... ooooh! I miei shenshi pizzicano! Vedo... enormi Cavoli Verdi nel tuo futuro.";
	L.joguPredictsScallion = "Ti ho mai detto che odio lo Shcalogno? Lo odio!\n\n<Jogu si lascia andare in un poderoso rutto.>\n\nPer mia shfortuna, domani inizierà la shua shtagione.";
	L.joguPredictsRedBlossomLeek = "Pianta un porro e ben preshto ne avrai due.";
	L.joguPredictsWhiteTurnip = "Campi di Rape Bianche. Freshche e shaporite!";
	L.joguPredictsWitchberry = "Che bacche dovreshti piantare? Ma le Shtregobacche, naturalmente!";
	L.joguPredictsJuicycrunchCarrot = "Lo shapevi che le carote del vicino shono shempre più croccanti?";
	L.joguPredictsMoguPumpkin = "Zucche! Vedo grosshe, gigantesche zucche!";
	L.joguPredictsPinkTurnip = "Nel tuo futuro vedo Rape Rosha.";
	L.joguPredictsJadeSquash = "Gli Zucchini di Giada hanno il colore caratterishtico della giada. Domani avremo le condizioni perfette per far creshcere queshto vegetale... credo.";
	L.joguPredictsStripedMelon = "I Meloni Shtriati shono perfetti per queshto periodo dell'anno! Pianta qualche sheme e in breve tempo avrai un intero raccolto.";
end

if (locale == "koKR") then
	L.sunsongRanchName = "태양노래 농장";
	L.joguPredictsGreenCabbage = "오!... 오오오! 느낌이 팍팍 옵니다! 당신 미래에... 거대한 녹색 양배추가 보입니다.";
	L.joguPredictsScallion = "제가 파를 싫어한다고 말씀드린 적 있습니까? 전 진짜 싫어합니다!\n\n<우렁차게 트림하는 조구>\n\n제게는 안 좋은 일이지만, 내일쯤이면 파가 아주 잘 익었을 겁니다.";
	L.joguPredictsRedBlossomLeek = "부추 하나에 뛰어들어도 두 개를 뽑겠군요.";
	L.joguPredictsWhiteTurnip = "하얀색 순무 밭입니다. 싱싱하고 매콤하군요!";
	L.joguPredictsWitchberry = "어떤 딸기를 심어야 하느냐고요? 물론 요술딸기를 심으셔야죠!";
	L.joguPredictsJuicycrunchCarrot = "츄릅아삭 당근이라고 들어보셨습니까? 내일이 가장 츄릅아삭할 겁니다.";
	L.joguPredictsMoguPumpkin = "호박입니다! 아주 거대하고, 웅장한 호박이 될 겁니다!";
	L.joguPredictsPinkTurnip = "당신 미래에 분홍색 순무가 보입니다.";
	L.joguPredictsJadeSquash = "비취 박의 색깔이 우윳빛 옥색으로 물드는군요. 내일이 이 채소를 기르기에 완벽한 날이 되겠군요...";
	L.joguPredictsStripedMelon = "일 년 중 이맘때는 줄무늬 멜론이 아주 달콤하죠! 줄무늬 멜론 씨앗을 심으십시오. 그러면 다음 날 수확할 수 있을 겁니다.";
end

if (locale == "esES" or locale == "esMX") then
	L.sunsongRanchName = "Rancho Cantosol";
	L.joguPredictsGreenCabbage = "¡Uuu... uuu! ¡Me eshtá entrando un coshquilleo! Veo... enormesh repollosh verdesh en tu futuro.";
	L.joguPredictsScallion = "¿Te he dicho alguna vez que odio lash cebolletash? ¡Lash odio!\n\n<Jogu eructa sonoramente.>\n\nPor deshgracia para mí, mañana eshtarán en temporada alta.";
	L.joguPredictsRedBlossomLeek = "Planta un puerro y a lo mejor conshiguesh dosh.";
	L.joguPredictsWhiteTurnip = "Camposh de nabash blancash. ¡Crudash y picantesh!";
	L.joguPredictsWitchberry = "¿Que qué bayash hay que plantar? ¡Morujash, evidentemente!";
	L.joguPredictsJuicycrunchCarrot = "¿Shabesh lo que esh una zanahoria Jugoasaz? Mañana estarán másh jugoshash que nunca.";
	L.joguPredictsMoguPumpkin = "¡Calabazash! ¡Sherán calabazash enormesh, giganteshcash!";
	L.joguPredictsPinkTurnip = "Veo nabash roshash en tu futuro.";
	L.joguPredictsJadeSquash = "Losh calabacinesh de jade son del color del jade claro. Mañana lash condicionesh para cultivarlosh serán perfectash... en mi opinión.";
	L.joguPredictsStripedMelon = "¡Losh melonesh a rayash eshtán muy jugoshosh en eshta época del año! Planta semillash en la tierra y mañana tendrásh la cosecha.";
end

if (locale == "ruRU") then
	L.sunsongRanchName = "Ферма Солнечной Песни";
	L.joguPredictsGreenCabbage = "Ой... Ой! Вижу, вижу! Я вижу... твое будущее... в нем много капусты.";
	L.joguPredictsScallion = "Я тебе говорил, что ненавижу лук-шалот? Ненавижу!<Йогу издает громкую отрыжку.>\n\nК моему сожалению, завтра ты сможешь собрать большой урожай этого лука.";
	L.joguPredictsRedBlossomLeek = "Посади один лук-шалот – получишь два!";
	L.joguPredictsWhiteTurnip = "Целые поля белой репы! Свежей и ароматной!";
	L.joguPredictsWitchberry = "Какие ягоды ты собираешься сажать? Конечно же, ведьмины ягоды!";
	L.joguPredictsJuicycrunchCarrot = "Приходилось когда-нибудь слышать о хруштящей моркови? Так вот, такой хруштящей, как завтра, она не будет никогда!";
	L.joguPredictsMoguPumpkin = "Тыквы! Это будут огромные, гигантские тыквы!";
	L.joguPredictsPinkTurnip = "В будущем тебя ждет много розовой репы.";
	L.joguPredictsJadeSquash = "Нефритовые кабачки по цвету как молочный нефрит. Жавтра будут идеальные условия для их выращивания... я думаю.";
	L.joguPredictsStripedMelon = "Полосатые дыни невероятно сочные в это время года! Пашди в землю шемена – через день шоберешь отличный урожай.";
end

if (locale == "zhCN") then
	L.sunsongRanchName = "日歌农场";
--	L.joguPredictsGreenCabbage = "";
--	L.joguPredictsScallion = "";
--	L.joguPredictsRedBlossomLeek = "";
--	L.joguPredictsWhiteTurnip = "";
--	L.joguPredictsWitchberry = "";
--	L.joguPredictsJuicycrunchCarrot = "";
--	L.joguPredictsMoguPumpkin = "";
--	L.joguPredictsPinkTurnip = "";
--	L.joguPredictsJadeSquash = "";
--	L.joguPredictsStripedMelon = "";
end

if (locale == "zhTW") then
	L.sunsongRanchName = "日歌農莊";
	L.joguPredictsGreenCabbage = "喔喔喔...喔喔喔喔!我感覺到刺刺的!我在你的未來看見...巨大的綠色捲心菜。";
	L.joguPredictsScallion = "我有告訴過你我討厭青蔥嗎?討厭死了!\n\n<酒骨大聲地打了個嗝。>\n\n對我來說很不幸的是，它們明天開始就進入旺季。";
	L.joguPredictsRedBlossomLeek = "買個紅花蔥，你也許會有額外收穫。";
	L.joguPredictsWhiteTurnip = "滿滿的白菜頭。生鮮且辛辣!";
	L.joguPredictsWitchberry = "你該種哪種莓?當然是巫莓啊!";
	L.joguPredictsJuicycrunchCarrot = "你有聽過脆嫩多汁胡蘿蔔嗎?明天將是它們最多汁的時候。";
	L.joguPredictsMoguPumpkin = "南瓜!那將會是個龐大、巨大的南瓜!";
	L.joguPredictsPinkTurnip = "我在你的未來中看到許多粉紅色菜頭。";
	L.joguPredictsJadeSquash = "翠玉瓜有著乳白翠玉的顏色。明天將會有種植這種蔬菜的完美條件...我覺得啦。";
	L.joguPredictsStripedMelon = "條紋甜瓜在每年這時節都相當多汁!把一些種子投入土裡，你隔天就會有收穫。";
end