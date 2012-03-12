-- 																		Explaination 
-- 														How to create your own custom sound pack
--													-----------------------------------------------
--
--	local color = "|cff0066ff"	-- Place the color of the title text (e.g. "Sound Pack 1.1 (Mortal Kombat)") here. 
--								-- (Format is rr gg bb, e.g. |cff0000ff = Blue, |cff00ff00 = Green, |cffff0000 = Red)
--	
--	PowerAuras_SoundPack<MainID>_<SubID>_SoundInfo = {	-- This is a unique array that stores the sound data, 
--														-- <MainID> can be a number between 1-20
--														-- (This is usually the number assosciated with the sound pack, i.e. Sound Pack 1 will use 1, Sound Pack 2 will use 2, etc...)
--														-- <SubID> can be a number between 1-10
--														-- (This is to create multiple categories in the sound pack, i.e. pack 1.1, 1.2, 1.3... or "Pinkie Pack", "Fluttershy Pack", "Dash Pack"...)
--		["Name"] = color .. "<NAME>",	-- The name of the pack, <NAME> can be whatever you choose (e.g. "Sound Pack 1.1 (Mortal Kombat)" or "Crazy Super Awesome Pack")
--		["Path"] = "<PATH>",	-- The path to the files stored in this pack, be sure to use "\\" instead of "\" and put a "\\" at the end
								-- e.g. "Interface\\AddOns\\PowerAuras_SoundPack1\\Sounds\\1\\"
--		{	-- This is ID #1 in the Array
--			["Name"] = "<FILENAME>",	-- This is the name that the user will see, FILENAME can be anything (e.g. "Animality", "Crazy Boop", "Dancing Bear 2")
--			["File"] = "<FILE>.ogg",	-- This is the file name that the computer will use (e.g. "Animality.ogg", "MyAwesomeSong.ogg", "72Bottles.mp3")
										-- (Note: You can only use .ogg and .mp3 files in WoW, I recommend .ogg files)
--		},
--		{	-- This is ID #2 in the Array
--			["Name"] = "<FILENAME>",
--			["File"] = "<FILE>.ogg",
--		},

local color = "|cff0066ff"	-- medium blue

PowerAuras_SoundPack1_1_SoundInfo = {
	["Name"] = color .. "Sound Pack 1.1 (Mortal Kombat)",
	["Path"] = "Interface\\AddOns\\PowerAuras_SoundPack1\\Sounds\\1\\",
	{
		["Name"] = "1",
		["File"] = "1.ogg",
	},
	{
		["Name"] = "2",
		["File"] = "2.ogg",
	},
	{
		["Name"] = "3",
		["File"] = "3.ogg",
	},
	{
		["Name"] = "4",
		["File"] = "4.ogg",
	},
	{
		["Name"] = "Animality",
		["File"] = "Animality.ogg",
	},
	{
		["Name"] = "Babality",
		["File"] = "Babality.ogg",
	},
	{
		["Name"] = "Baby Crying",
		["File"] = "BabyCry.ogg",
	},
	{
		["Name"] = "Ball Warp",
		["File"] = "Ball.ogg",
	},
	{
		["Name"] = "Bite",
		["File"] = "Bite.ogg",
	},
	{
		["Name"] = "Blade",
		["File"] = "Blade.ogg",
	},
	{
		["Name"] = "Bong",
		["File"] = "Bong.ogg",
	},
	{
		["Name"] = "Charge",
		["File"] = "Charge.ogg",
	},
	{
		["Name"] = "Character Select",
		["File"] = "CharSelect.ogg",
	},
	{
		["Name"] = "Choose Your Destiny",
		["File"] = "Choose.ogg",
	},
	{
		["Name"] = "Continue",
		["File"] = "Continue.ogg",
	},
	{
		["Name"] = "Crispy",
		["File"] = "Crispy.ogg",
	},
	{
		["Name"] = "Crowd (Aah)",
		["File"] = "CrowdAah.ogg",
	},
	{
		["Name"] = "Crowd (Cheer)",
		["File"] = "CrowdCheer.ogg",
	},
	{
		["Name"] = "Crowd (Gasp)",
		["File"] = "CrowdGasp.ogg",
	},
	{
		["Name"] = "Crunch 1",
		["File"] = "Crunch1.ogg",
	},
	{
		["Name"] = "Crunch 2",
		["File"] = "Crunch2.ogg",
	},
	{
		["Name"] = "Danger",
		["File"] = "Danger.ogg",
	},
	{
		["Name"] = "Dog",
		["File"] = "Dog.ogg",
	},
	{
		["Name"] = "Dont make me Laugh",
		["File"] = "DontMakeMeLaugh.ogg",
	},
	{
		["Name"] = "Eerie music",
		["File"] = "Eerie.ogg",
	},
	{
		["Name"] = "Excellent",
		["File"] = "Excellent.ogg",
	},
	{
		["Name"] = "Explode",
		["File"] = "Explode.ogg",
	},
	{
		["Name"] = "Fatality",
		["File"] = "Fatal.ogg",
	},
	{
		["Name"] = "Fatality (Music)",
		["File"] = "FatalityMusic.ogg",
	},
}

PowerAuras_SoundPack1_2_SoundInfo = {
	["Name"] = color .. "Sound Pack 1.2 (Mortal Kombat)",
	["Path"] = "Interface\\AddOns\\PowerAuras_SoundPack1\\Sounds\\2\\",
	{
		["Name"] = "Fight",
		["File"] = "Fight.ogg",
	},
	{
		["Name"] = "Fight 2",
		["File"] = "Fight2.ogg",
	},
	{
		["Name"] = "Finish Him",
		["File"] = "FinishHim.ogg",
	},
	{
		["Name"] = "Fire",
		["File"] = "Fire.ogg",
	},
	{
		["Name"] = "Flawless Victory",
		["File"] = "Flawless.ogg",
	},
	{
		["Name"] = "Friendship",
		["File"] = "Friendship.ogg",
	},
	{
		["Name"] = "Friendship (Music)",
		["File"] = "FriendshipMusic.ogg",
	},
	{
		["Name"] = "Frosty",
		["File"] = "Frosty.ogg",
	},
	{
		["Name"] = "Gong",
		["File"] = "Gong.ogg",
	},
	{
		["Name"] = "Gotcha",
		["File"] = "Gotcha.ogg",
	},
	{
		["Name"] = "Hahahaaa",
		["File"] = "Hahahaaa.ogg",
	},
	{
		["Name"] = "Ignite",
		["File"] = "Ignite.ogg",
	},
	{
		["Name"] = "Kano Ball",
		["File"] = "KanoBall.ogg",
	},
	{
		["Name"] = "Kid Thunder",
		["File"] = "KidThunder.ogg",
	},
	{
		["Name"] = "Kiss",
		["File"] = "Kiss.ogg",
	},
	{
		["Name"] = "Knife",
		["File"] = "Knife.ogg",
	},
	{
		["Name"] = "Lightning",
		["File"] = "Lightning.ogg",
	},
	{
		["Name"] = "Liu1",
		["File"] = "Liu1.ogg",
	},
	{
		["Name"] = "Liu2",
		["File"] = "Liu2.ogg",
	},
	{
		["Name"] = "Liu3",
		["File"] = "Liu3.ogg",
	},
	{
		["Name"] = "Liu4",
		["File"] = "Liu4.ogg",
	},
	{
		["Name"] = "Mercy",
		["File"] = "Mercy.ogg",
	},
	{
		["Name"] = "Morph",
		["File"] = "Morph.ogg",
	},
	{
		["Name"] = "Outstanding",
		["File"] = "Outstanding.ogg",
	},
	{
		["Name"] = "Punch",
		["File"] = "Punch.ogg",
	},
	{
		["Name"] = "Roar 1",
		["File"] = "Roar1.ogg",
	},
	{
		["Name"] = "Roar 2",
		["File"] = "Roar2.ogg",
	},
	{
		["Name"] = "Scorpion (Come Here)",
		["File"] = "ScorpionCome.ogg",
	},
	{
		["Name"] = "Scorpion (Get Over Here)",
		["File"] = "ScorpionGet.ogg",
	},
}

PowerAuras_SoundPack1_3_SoundInfo = {
	["Name"] = color .. "Sound Pack 1.3 (Mortal Kombat)",
	["Path"] = "Interface\\AddOns\\PowerAuras_SoundPack1\\Sounds\\3\\",
	{
		["Name"] = "Shao (Is that your Best)",
		["File"] = "ShaoBest.ogg",
	},
	{
		["Name"] = "Shao (Bow to ME)",
		["File"] = "ShaoBow.ogg",
	},
	{
		["Name"] = "Shao (I Win)",
		["File"] = "ShaoIWin.ogg",
	},
	{
		["Name"] = "Shao (Dont Make Me Laugh)",
		["File"] = "ShaoMake.ogg",
	},
	{
		["Name"] = "Shao (You Will NEVER Win)",
		["File"] = "ShaoNever.ogg",
	},
	{
		["Name"] = "Shao (You Are Nothing)",
		["File"] = "ShaoNothing.ogg",
	},
	{
		["Name"] = "Shao (That was Pathetic)",
		["File"] = "ShaoPathetic.ogg",
	},
	{
		["Name"] = "Shao (Prepare To Die)",
		["File"] = "ShaoPrepare.ogg",
	},
	{
		["Name"] = "Sheepality",
		["File"] = "Sheepality.ogg",
	},
	{
		["Name"] = "Slip 1",
		["File"] = "Slip.ogg",
	},
	{
		["Name"] = "Slip 2",
		["File"] = "Slip2.ogg",
	},
	{
		["Name"] = "Splash",
		["File"] = "Splash.ogg",
	},
	{
		["Name"] = "Ice 1",
		["File"] = "SubIce1.ogg",
	},
	{
		["Name"] = "Ice 2",
		["File"] = "SubIce2.ogg",
	},
	{
		["Name"] = "Superb",
		["File"] = "Superb2.ogg",
	},
	{
		["Name"] = "Teleport",
		["File"] = "Teleport.ogg",
	},
	{
		["Name"] = "Thunder",
		["File"] = "thunder.ogg",
	},
	{
		["Name"] = "Test Your Might",
		["File"] = "TYM.ogg",
	},
	{
		["Name"] = "Vs Screen",
		["File"] = "vscreen.ogg",
	},
	{
		["Name"] = "Well Done",
		["File"] = "Well2.ogg",
	},
	{
		["Name"] = "Whistle",
		["File"] = "Whistle.ogg",
	},
	{
		["Name"] = "Woosh 1",
		["File"] = "Woosh1.ogg",
	},
	{
		["Name"] = "Woosh 2",
		["File"] = "Woosh2.ogg",
	},
	{
		["Name"] = "Woosh 3",
		["File"] = "Woosh3.ogg",
	},
	{
		["Name"] = "You Suck",
		["File"] = "YouSuck.ogg",
	},
	{
		["Name"] = "Zap",
		["File"] = "Zap.ogg",
	},
}