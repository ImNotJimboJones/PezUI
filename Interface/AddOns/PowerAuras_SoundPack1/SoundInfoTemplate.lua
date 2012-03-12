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

PowerAuras_SoundPack2_1_SoundInfo = {
	["Name"] = color .. "<Sound Pack Name Here>",
	["Path"] = "Interface\\AddOns\\<Addon Path Here>",
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
}

PowerAuras_SoundPack2_2_SoundInfo = {
	["Name"] = color .. "<Sound Pack Name Here>",
	["Path"] = "Interface\\AddOns\\<Addon Path Here>",
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
}

PowerAuras_SoundPack2_3_SoundInfo = {
	["Name"] = color .. "<Sound Pack Name Here>",
	["Path"] = "Interface\\AddOns\\<Addon Path Here>",
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
	{
		["Name"] = "<Displayed Name>",
		["File"] = "<FileName>.ogg",
	},
}