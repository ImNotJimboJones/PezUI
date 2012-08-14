
--------------------------------------------------------------------------------------------------------
--                       BrokerWhisperWhisper Initialization                                          --
--------------------------------------------------------------------------------------------------------
Broker_WhisperWhisper = LibStub("AceAddon-3.0"):NewAddon("Broker_WhisperWhisper", "AceConsole-3.0", "AceEvent-3.0") -- Starts Global Ace ADdon
local ldb = LibStub:GetLibrary("LibDataBroker-1.1") -- Fires Lib Data Broker
local AceConfig = LibStub("AceConfig-3.0") -- For the options panel
local AceConfigDialog = LibStub("AceConfigDialog-3.0") -- Also for options panel
local AceDB = LibStub("AceDB-3.0") -- Makes saving things relaly easy
local AceDBOptions = LibStub("AceDBOptions-3.0") -- More database options
local LibQTip = LibStub('LibQTip-1.0') -- The tooltips
local LibQTipMenu = LibStub('LibQTip-1.0') -- Duplicate for 2ndary tooltip
local LSM = LibStub("LibSharedMedia-3.0")

--------------------------------------------------------------------------------------------------------
--                       WhisperWhisper Main Frame                                                    --
--------------------------------------------------------------------------------------------------------
WhisperWhisper_mainFrame = CreateFrame("Frame", "WhisperWhisper_mainFrame", UIParent); -- Creates the main frame
WhisperWhisper_mainFrame:SetHeight(18) -- Sets the height
WhisperWhisper_mainFrame:SetWidth(125) -- Sets the width
WhisperWhisper_mainFrame:EnableMouse(true) -- Makes it so our mouse can use it
WhisperWhisper_mainFrame.texture = WhisperWhisper_mainFrame:CreateTexture() -- Fires a texture for making it look movable
WhisperWhisper_mainFrame.texture:SetAllPoints(WhisperWhisper_mainFrame) -- Binds the texture
WhisperWhisper_mainFrame.texture:SetTexture(.4, .4, .4, 0) -- Sets its color to gray (with alpha=0)
local mainFontString = WhisperWhisper_mainFrame:CreateFontString(nil,"OVERLAY"); -- Fires the font string for display
mainFontString:SetPoint("CENTER",WhisperWhisper_mainFrame,"CENTER"); -- Sets it to be centered
local leftFlashFrame = CreateFrame("Frame", "leftFlashFrame", WhisperWhisper_mainFrame);
leftFlashFrame.texture = leftFlashFrame:CreateTexture()
leftFlashFrame.texture:SetAllPoints(leftFlashFrame)
leftFlashFrame.texture:SetTexture("Interface\\Addons\\WhisperWhisper\\NewFlash.tga");
leftFlashFrame:SetPoint("RIGHT", WhisperWhisper_mainFrame, "LEFT");
leftFlashFrame.texture:SetBlendMode("ADD");
leftFlashFrame.texture:SetGradient("HORIZONTAL", 1, 0, 0, 1, 0, 0);
local rightFlashFrame = CreateFrame("Frame", "rightFlashFrame", WhisperWhisper_mainFrame);
rightFlashFrame.texture = rightFlashFrame:CreateTexture()
rightFlashFrame.texture:SetAllPoints(rightFlashFrame)
rightFlashFrame.texture:SetTexture("Interface\\Addons\\WhisperWhisper\\NewFlash.tga");
rightFlashFrame.texture:SetBlendMode("ADD");
rightFlashFrame:SetPoint("LEFT", WhisperWhisper_mainFrame, "RIGHT");
local topFlashFrame = CreateFrame("Frame", "topFlashFrame", WhisperWhisper_mainFrame);
topFlashFrame.texture = topFlashFrame:CreateTexture()
topFlashFrame.texture:SetAllPoints(topFlashFrame)
topFlashFrame.texture:SetTexture("Interface\\Addons\\WhisperWhisper\\Top.tga");
topFlashFrame:SetPoint("BOTTOM", WhisperWhisper_mainFrame, "TOP");
topFlashFrame.texture:SetBlendMode("ADD");
topFlashFrame.texture:SetGradient("HORIZONTAL", 1, 0, 0, 1, 0, 0);
local botFlashFrame = CreateFrame("Frame", "botFlashFrame", WhisperWhisper_mainFrame);
botFlashFrame.texture = botFlashFrame:CreateTexture()
botFlashFrame.texture:SetTexture("Interface\\Addons\\WhisperWhisper\\Bottom.tga");
botFlashFrame.texture:SetAllPoints(botFlashFrame)
botFlashFrame:SetPoint("TOP", WhisperWhisper_mainFrame, "BOTTOM");
botFlashFrame.texture:SetBlendMode("ADD");
botFlashFrame.texture:SetGradient("HORIZONTAL", 1, 0, 0, 1, 0, 0);
leftFlashFrame:Hide()
rightFlashFrame:Hide()
topFlashFrame:Hide()
botFlashFrame:Hide()

--------------------------------------------------------------------------------------------------------
--                      Main Frame / Data Broker joint events                                         --
--------------------------------------------------------------------------------------------------------
local masterDebug = false;
local function printd(msg)
	if masterDebug then
		print(msg)
	end
end

-- FUNCTION: Broker_WhisperWhisper_ObjCreated
-- PURPOSE: Binds the mainFrame scripts to the LDB scripts.
function Broker_WhisperWhisper_ObjCreated(event, name, dataobj)
	WhisperWhisper_mainFrame:SetScript("OnEnter", Broker_WhisperWhisper_OnEnterWhisperWhisper_mainFrame)
	if frameLock then
		WhisperWhisper_mainFrame:SetScript("OnMouseUp", Broker_WhisperWhisper_OnClickWhisperWhisper_mainFrame)
	end
end

-- FUNCTION: Broker_WhisperWhisper_ObjChanged
-- PURPOSE: Function fires whenever the text of the LDB dataobj changes. Updates main frame text
function Broker_WhisperWhisper_ObjChanged(event, name, key, value, dataobj)
	mainFontString:SetText(value)
	Broker_WhisperWhisper_ResetSize()
end

-- FUNCTION: Broker_WhisperWhisper_OnEnterWhisperWhisper_mainFrame
-- PURPOSE: Function bound earlier. Just fires the formal "OnEnter" for LDB
function Broker_WhisperWhisper_OnEnterWhisperWhisper_mainFrame()
	Broker_WhisperWhisper_EndFlash()
	Broker_WhisperWhisper.obj.OnEnter(WhisperWhisper_mainFrame)
end

-- FUNCTION: Broker_WhisperWhisper_OnClickWhisperWhisper_mainFrame
-- PURPOSE: Function bound earlier. Just fires the formal "OnClick" for LDB
function Broker_WhisperWhisper_OnClickWhisperWhisper_mainFrame(self, button)
	Broker_WhisperWhisper.obj.OnClick(self, button)
end

-- Now, register the Callbacks
ldb.RegisterCallback("Broker_WhisperWhisper", "LibDataBroker_DataObjectCreated", Broker_WhisperWhisper_ObjCreated) --Created callback
ldb.RegisterCallback("Broker_WhisperWhisper", "LibDataBroker_AttributeChanged_Broker_WhisperWhisper_text", Broker_WhisperWhisper_ObjChanged) --Text Changed callback

--------------------------------------------------------------------------------------------------------
--                          Broker_WhisperWhisper variables and defaults                              --
--------------------------------------------------------------------------------------------------------
local xposBefore = 0;
local yposBefore = 0;
local relXPos = 0;
local relYPos = 0;
local combatClear = false;
local theBind = UIParent;
local flashDuration = 10;
local flashMaster = true;
local flashTop = true;
local flashBottom = true;
local flashLeft = true;
local flashRight = true;
local flashEntireFrame = true;
local whisperList = {}; -- Our semidefault whisper list
local numPlayers = 10; -- # of players to remember
local numWhispers = 10; -- # of whispers to remember
local menuWhispers = {}; -- Secondary "Menu" whispers for sanity
local inCombat = true; -- Boolean to have mouseovers while in combat (true means show the tooltip, false means hide while in combat)
local fullCombat = false; -- Boolean to show ANYTHING while in combat (true means show while in combat, false means hide while in combat)
local frameLock = false; -- Boolean for frame lock (true=locked)
local flashOffCombat = true;
local frameOpts = {}; -- Frame coordinate points.
local font = "Friz Quadrata TT" -- Default Font (TO BE IMPLEMENTED LATER)
local tipFont = "Friz Quadrata TT" -- Default Font (TO BE IMPLEMENTED LATER)
local fontSize = 12;
local tipFontSize = 12;
local initName = "WhisperWhisper"; -- Default text to be shown
local showFrame = true; -- Boolean to show the frame AT ALL (true means show, false means hide completely)
BWW_NOTIP = true; -- Basically "are we in combat"? If true, we're in combat. If false, we're not.
local LDB_ANCHOR -- Not sure what this is for. Leftover
local tooltip -- Primary tooltip
local menuTooltip -- Secondary tooltip
local showingMenu = false; -- Boolean that's probably leftover
local altView = false;
local recColorFull = "|cff66ff66"
local sendColorFull = "|cff6666ff"
local permColorFull = "|cffffffff"
local usePerm = false
local permColor = { r = 255,
				   g = 255,
				   b = 255 }
local recColor = { r = 102,
				   g = 255,
				   b = 102 }
local sendColor = { r = 102,
				    g = 102,
					b = 255 }
local profileDB -- Profile DB for Ace
local DATABASE_DEFAULTS = { -- The defaults!
	profile = {
		numPlayers = 10,
		numWhispers = 10,
		whisperList = {},
		inCombat = true,
		fullCombat = false,
		frameLock = false,
		font = "Friz Quadrata TT",
		tipFont = "Friz Quadrata TT",
		fontSize = 12,
		tipFontSize = 12,
		recColor = { r = 102,
					 g = 255,
					 b = 102,
		},
		sendColor = { r = 102,
					  g = 102,
					  b = 255,
		},
		permColor = { r = 255,
				   g = 255,
				   b = 255
		},
		showFrame = true,
		usePerm = false,
		flashDuration = 10,
		flashMaster = false,
		flashTop = false,
		flashBottom = false,
		flashLeft = false,
		flashRight = false,
		flashEntireFrame = false,
		flashOffCombat = true,
		altView = faluse,
		recColor = { r = 102,
					 g = 255,
					 b = 102,
		},
		sendColor = { r = 102,
					  g = 102,
					  b = 255,
		},
		permColor = { r = 255,
				   g = 255,
				   b = 255
		},
		frameOpts = { anchorFrom = "CENTER",
					  anchorTo = "CENTER",
					  offsetx = 0, 
					  offsety = 0,
		},
	},
}

--------------------------------------------------------------------------------------------------------
--                          Broker_WhisperWhisper Combat Switches                                     --
--------------------------------------------------------------------------------------------------------
local combatSwitchFrame = CreateFrame("Frame") -- Creates invisible frame for combat watch
combatSwitchFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Exit combat event
combatSwitchFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Enter combat event
combatSwitchFrame:SetScript("OnEvent", function(self, event, ...) -- Event handler
      if event == "PLAYER_REGEN_ENABLED" then -- Leaving combat
         BWW_NOTIP = true -- We're out of combat
         if showingFrame then -- If we're showing the frame
      	   WhisperWhisper_mainFrame:Show(); -- Then show it
      	 end
		 if combatClear and flashOffCombat then
		 	Broker_WhisperWhisper_StartFlash()
		 end
      else
         BWW_NOTIP = false -- We're in combat
         if fullCombat then -- If we hide the frame while in combat
         	WhisperWhisper_mainFrame:Hide(); -- Then hide it
         	if tooltip then -- And the tooltip
         		tooltip:Hide();
         	end
         	
         	if menuTooltip then -- And the menu tooltip
         		menuTooltip:Hide();
         	end
         elseif not inCombat then -- If we hide the tooltip while in combat
         	if tooltip then -- then hide the tooltip
         		tooltip:Hide();
         	end
         	
         	if menuTooltip then -- and the menuTooltip
         		menuTooltip:Hide();
         	end
         end
		 
		 if flashOffCombat then
		 	Broker_WhisperWhisper_EndFlash()
			combatClear = true
		 end
      end
end)


--------------------------------------------------------------------------------------------------------
--                              Broker_WhisperWhisper options panel                                   --
--------------------------------------------------------------------------------------------------------
Broker_WhisperWhisper.options = {
	type = "group",
	name = "Broker WhisperWhisper",
	args = {
		general = {
			order = 1,
			type = "group",
			name = "General Settings",
			cmdInline = true,
			args = {
				separator1 = {
					type = "header",
					name = "WhisperWhisper Options",
					order = 1,
				},
				details = {
					order = 2,
					type = "range",
					name = "Number of Players Remembered",
					desc = "If set to 10, then the most 10 recent players will be remembered",
					width = "double",
					get = function()
						return profileDB.numPlayers
					end,
					set = function(key, value)
						profileDB.numPlayers = value
						numPlayers = value;
					end,
					min=5,
					max=25,
					softMin=5,
					softMax=25,
					step=1,
				},
				details2 = {
					order = 4,
					type = "range",
					name = "Number of Whispers Remembered",
					desc = "If set to 10, then the most 10 recent whispers per conversation will be remembered",
					width = "double",
					get = function()
						return profileDB.numWhispers
					end,
					set = function(key, value)
						profileDB.numWhispers = value
						numWhispers = value;
					end,
					min=5,
					max=25,
					softMin=5,
					softMax=25,
					step=1,
				},
				details3 = {
					order = 6,
					type = "toggle",
					name = "Allow Mouseovers In Combat",
					desc = "If unchecked, mouseovers will not work while in combat",
					width = "double",
					get = function()
						return profileDB.inCombat
					end,
					set = function(key, value)
						profileDB.inCombat = value
						inCombat = value;
					end,
				},
				details4 = {
					order = 6,
					type = "toggle",
					name = "Hide Addon In Combat",
					desc = "If checked, addon will completely hide during combat",
					width = "double",
					get = function()
						return profileDB.fullCombat
					end,
					set = function(key, value)
						profileDB.fullCombat = value
						fullCombat = value;
					end,
				},
				details7 = {
					order = 7,
					type = "toggle",
					name = "Hide Frame Completely",
					desc = "If checked, addon will completely hide. Use this to only display on Panel mods (such as TitanPanel, ChocolateBar, etc.)",
					width = "double",
					get = function()
						return not profileDB.showFrame
					end,
					set = function(key, value)
						value = not value;
						profileDB.showFrame = value
						showFrame = value;
						if showFrame then
							WhisperWhisper_mainFrame:Show()
						else
							WhisperWhisper_mainFrame:Hide()
						end
					end,
				},
				details8 = {
					order = 8,
					type = "toggle",
					name = "Enable Alternate View Mode",
					desc = "If checked, hovering over the frame will display the list of wihspers rather than just the current conversation",
					width = "double",
					get = function()
						return profileDB.altView
					end,
					set = function(key, value)
						profileDB.altView = value
						altView = value;
						profileDB.altView = value
						profileDB["altView"] = value;
						value = profileDB["altView"];
					end,
				},
				details5 = {
					order = 9,
					type = "execute",
					name = "Clear All Whispers",
					desc = "Clears all Whispers",
					func = function()
						Broker_WhisperWhisper_ClearAllWhispers();
					end,
				},
				details6 = {
					order = 10,
					type = "execute",
					name = "Reset Position",
					desc = "Resets the Position of the Frame",
					func = function()
						WhisperWhisper_mainFrame:ClearAllPoints();
						WhisperWhisper_mainFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
						local opts = profileDB["frameOpts"]; -- Grab the options profile
				   		local from, _, to, x, y = WhisperWhisper_mainFrame:GetPoint() -- Get the end location and switch the variables
					    opts.anchorFrom = from
					    opts.anchorTo = to
					    opts.offsetx = x
					    opts.offsety = y
					    profileDB["frameOpts"] = opts; -- Update the profile
					end,
				},
			},
		},
		tipz = {
			order = 1,
			type = "group",
			name = "Frame Settings",
			cmdInline = true,
			args = {
				separator1 = {
					type = "header",
					name = "Font/Size Options",
					order = 1,
				},
				font = {
				     type = 'select',
				     order = 2,
				     dialogControl = 'LSM30_Font', --Select your widget here
				     name = 'Main Frame Font',
				     desc = 'Font for the main frame',
				     values = LSM:HashTable("font"), -- pull in your font list from LSM
				     get = function()
				          return font
				     end,
				     set = function(self,key)
				   			profileDB["font"] = key
				   			font = profileDB["font"];
				        	if font then
								Broker_WhisperWhisper_ResetSize()
							end
				     end,
				},
				font2 = {
				     type = 'select',
				     order = 3,
				     dialogControl = 'LSM30_Font', --Select your widget here
				     name = 'Tooltip Font',
				     desc = 'Font for all tooltips',
				     values = LSM:HashTable("font"), -- pull in your font list from LSM
				     get = function()
				          return tipFont
				     end,
				     set = function(self,key)
				   			profileDB["tipFont"] = key
				   			tipFont = profileDB["tipFont"];
				        	if tooltip then
				        		local myFont = CreateFont("tipFontTemp1");
				        		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
								tooltip:SetFont(myFont)
							end
							if menuTooltip then
								local myFont = CreateFont("tipFontTemp2");
				        		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
								menuTooltip:SetFont(myFont)
							end
				     end,
				},
				fontSize1 = {
					order = 4,
					type = "range",
					name = "Main Font Size",
					desc = "Font size of the main frame",
					get = function()
						return profileDB.fontSize
					end,
					set = function(key, value)
						profileDB.fontSize = value
						fontSize = profileDB.fontSize
						if font then
							Broker_WhisperWhisper_ResetSize()
						end
					end,
					min=6,
					max=24,
					softMin=6,
					softMax=24,
					step=1,
				},
				fontSize2 = {
					order = 5,
					type = "range",
					name = "Tooltip Font Size",
					desc = "Font size of the tooltip",
					get = function()
						return profileDB.tipFontSize
					end,
					set = function(key, value)
						profileDB.tipFontSize = value
						tipFontSize = profileDB.tipFontSize
						if tooltip then
			        		local myFont = CreateFont("tipFontTemp3");
			        		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
							tooltip:SetFont(myFont)
						end
						if menuTooltip then
							local myFont = CreateFont("tipFontTemp4");
			        		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
							menuTooltip:SetFont(myFont)
						end
					end,
					min=6,
					max=24,
					softMin=6,
					softMax=24,
					step=1,
				},
				colorFont1 = {
					order = 6,
					type = "color",
					name = "Whisper Recieved Color",
					desc = "Color of text when you recieve a whisper",
					get = function()
						return recColor.r/255, recColor.g/255, recColor.b/255, 1
					end,
					set = function(key, r, g, b, a)
						recColor.r = floor(r*255)
						recColor.g = floor(g*255)
						recColor.b = floor(b*255)
						profileDB["recColor"] = recColor;
						recColor = profileDB["recColor"];
						recColorFull = Broker_WhisperWhisper_RGBtoHex(recColor.r, recColor.g, recColor.b)
						Broker_WhisperWhisper_UpdateColors()
					end,
					hasAlpha = false,
				},
				colorFont2 = {
					order = 7,
					type = "color",
					name = "Whisper Sent Color",
					desc = "Color of text when you send a whisper",
					get = function()
						return sendColor.r/255, sendColor.g/255, sendColor.b/255, 1
					end,
					set = function(key, r, g, b, a)
						sendColor.r = floor(r*255)
						sendColor.g = floor(g*255)
						sendColor.b = floor(b*255)
						profileDB["sendColor"] = sendColor;
						sendColor = profileDB["sendColor"];
						sendColorFull = Broker_WhisperWhisper_RGBtoHex(sendColor.r, sendColor.g, sendColor.b)
						Broker_WhisperWhisper_UpdateColors()
					end,
					hasAlpha = false,
				},
				details15 = {
					order = 8,
					type = "toggle",
					name = "Use Static Player Color",
					desc = "If checked, addon will use static color for player names",
					get = function()
						return profileDB.usePerm
					end,
					set = function(key, value)
						profileDB.usePerm = value
						usePerm = profileDB.usePerm
						Broker_WhisperWhisper_UpdateColors()
					end,
				},
				colorFont3 = {
					order = 9,
					type = "color",
					name = "Static Frame Color",
					desc = "Color of players names",
					disabled = function ()
						return not usePerm
					end,
					get = function()
						return permColor.r/255, permColor.g/255, permColor.b/255, 1
					end,
					set = function(key, r, g, b, a)
						permColor.r = floor(r*255)
						permColor.g = floor(g*255)
						permColor.b = floor(b*255)
						profileDB["permColor"] = permColor;
						permColor = profileDB["permColor"];
						permColorFull = Broker_WhisperWhisper_RGBtoHex(permColor.r, permColor.g, permColor.b)
						Broker_WhisperWhisper_UpdateColors()
						
					end,
					hasAlpha = false,
				},
				details67 = {
					order = 10,
					type = "execute",
					name = "Restore Defaults",
					desc = "Restores the Default Fonts and Colors",
					func = function()
						font = "Friz Quadrata TT"
						tipFont = "Friz Quadrata TT"
						fontSize = 12
						tipFontSize = 12
						recColor = { r = 102,
									 g = 255,
									 b = 102,
									}
						sendColor = { r = 102,
									  g = 102,
									  b = 255,
						}
						permColor = { r = 255,
								   g = 255,
								   b = 255
						}
						usePerm = false
						profileDB["usePerm"] = usePerm
						profileDB["font"] = font
						profileDB["tipFont"] = tipFont
						profileDB["fontSize"] = fontSize
						profileDB["tipFontSize"] = tipFontSize
						profileDB["recColor"] = recColor
						profileDB["sendColor"] = sendColor
						profileDB["permColor"] = permColor
						Broker_WhisperWhisper_UpdateColors()
						Broker_WhisperWhisper_ResetSize()
					end,
				},
			},
		},
		flashflash = {
			order = 1,
			type = "group",
			name = "Flash/Alert Settings",
			cmdInline = true,
			args = {
				separator1 = {
					type = "header",
					name = "Flash/Alert Settings",
					order = 1,
				},
				desc2 = {
					type = "description",
					name = "These options will flash the frame whenever you recieve a new whisper. The flash |caaff8888stop|r after you reply or mouse-over the whisper.",
					fontSize = "medium",
					order = 2,
				},
				enableany = {
				     type = 'toggle',
				     order = 3,
				     name = 'Enable Flash Notifications',
				     desc = 'Check to enable flash notifications',
					 width = "double",
				     get = function()
				          return flashMaster
				     end,
				     set = function(self,key)
				   			profileDB["flashMaster"] = key
				   			flashMaster = profileDB["flashMaster"];
				        	profileDB["flashMaster"] = flashMaster
				     end,
				},
				desc4 = {
					type = "description",
					name = "",
					fontSize = "medium",
					order = 4,
				},
				enableleft = {
				     type = 'toggle',
				     order = 5,
				     name = 'Enable Left Flash',
				     desc = 'Flashes a circle-shape to the left of the frame',
					 disabled = function() return not flashMaster end,
				     get = function()
				          return flashLeft
				     end,
				     set = function(self,key)
				   			profileDB["flashLeft"] = key
				   			flashLeft = profileDB["flashLeft"];
				        	profileDB["flashLeft"] = flashLeft
				     end,
				},
				enableright = {
				     type = 'toggle',
				     order = 6,
				     name = 'Enable Right Flash',
				     desc = 'Flashes a circle-shape to the right of the frame',
					 disabled = function() return not flashMaster end,
				     get = function()
				          return flashRight
				     end,
				     set = function(self,key)
				   			profileDB["flashRight"] = key
				   			flashRight = profileDB["flashRight"];
				        	profileDB["flashRight"] = flashRight
				     end,
				},
				enabletop = {
				     type = 'toggle',
				     order = 7,
				     name = 'Enable Top Flash',
				     desc = 'Flashes an arc-shape to the top of the frame',
					 disabled = function() return not flashMaster end,
				     get = function()
				          return flashTop
				     end,
				     set = function(self,key)
				   			profileDB["flashTop"] = key
				   			flashTop = profileDB["flashTop"];
				        	profileDB["flashTop"] = flashTop
				     end,
				},
				enablebot = {
				     type = 'toggle',
				     order = 8,
				     name = 'Enable Bottom Flash',
				     desc = 'Flashes a circle-shape to the left of the frame',
					 disabled = function() return not flashMaster end,
				     get = function()
				          return flashBottom
				     end,
				     set = function(self,key)
				   			profileDB["flashBottom"] = key
				   			flashBottom = profileDB["flashBottom"];
				        	profileDB["flashBottom"] = flashBottom
				     end,
				},
				enableallframe = {
				     type = 'toggle',
				     order = 9,
				     name = 'Enable Text Flash',
				     desc = 'Flashes the text whenever you recieve a new whisper',
					 disabled = function() return not flashMaster end,
					 width = "double",
				     get = function()
				          return flashEntireFrame
				     end,
				     set = function(self,key)
				   			profileDB["flashEntireFrame"] = key
				   			flashEntireFrame = profileDB["flashEntireFrame"];
				        	profileDB["flashEntireFrame"] = flashEntireFrame
				     end,
				},
				desc3 = {
					type = "description",
					name = "",
					fontSize = "medium",
					order = 9,
				},
				flashcombat = {
				     type = 'toggle',
				     order = 10,
				     name = 'Disable Flash While In Combat',
				     desc = 'Disables Frame Flashing While In Combat',
					 disabled = function() return not flashMaster end,
					 width = "double",
				     get = function()
				          return flashOffCombat
				     end,
				     set = function(self,key)
				   			profileDB["flashOffCombat"] = key
				   			flashOffCombat = profileDB["flashOffCombat"];
				        	profileDB["flashOffCombat"] = flashOffCombat
				     end,
				},
				flashduration = {
				     type = 'select',
				     order = 11,
				     name = 'Flash Duration',
				     desc = 'Ammount of Time for Flash to Persist',
					 disabled = function() return not flashMaster end,
					 width = "double",
					 style = "radio",
					 values = function ()
					 	local t = {};
						t[2] = "Single Flash";
						t[4] = "Double Flash";
						t[10] = "10 Seconds";
						t[900] = "Indefinitely";
						return t;
					end,
				     get = function()
				          return flashDuration
				     end,
				     set = function(self,key)
				   			profileDB["flashDuration"] = key
				   			flashDuration = profileDB["flashDuration"];
				        	profileDB["flashDuration"] = flashDuration
				     end,
				},
			},
		},
	},
}

function Broker_WhisperWhisper:SetupOptions()
	Broker_WhisperWhisper.options.args.profile = AceDBOptions:GetOptionsTable(self.db)
	Broker_WhisperWhisper.options.args.profile.order = -2

	AceConfig:RegisterOptionsTable("WhisperWhisper", Broker_WhisperWhisper.options, nil)
	
	self.optionsFrames = {}
	self.optionsFrames.general = AceConfigDialog:AddToBlizOptions("WhisperWhisper", nil, nil, "general")
	self.optionsFrames.tooltip = AceConfigDialog:AddToBlizOptions("WhisperWhisper", "Frame Options", "WhisperWhisper", "tipz")
	self.optionsFrames.tooltip = AceConfigDialog:AddToBlizOptions("WhisperWhisper", "Flash Notifications", "WhisperWhisper", "flashflash")
	self.optionsFrames.profile = AceConfigDialog:AddToBlizOptions("WhisperWhisper", "Profiles", "WhisperWhisper", "profile")
end



--------------------------------------------------------------------------------------------------------
--                          Broker_WhisperWhisper Ace Core Setup                                      --
--------------------------------------------------------------------------------------------------------
function Broker_WhisperWhisper:OnInitialize()
	self.db = AceDB:New("Broker_WhisperWhisperDB", DATABASE_DEFAULTS, true) -- Start the database
	if not self.db then -- If we failed to get it, post the errror
		Print("Error: Database not loaded correctly.  Please exit out of WoW and delete BWhisperWhisper.lua found in: \\World of Warcraft\\WTF\\Account\\<Account Name>>\\SavedVariables\\")
	end
	
	-- Register profile changing callbacks
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	
	-- Get the variables right
	profileDB = self.db.profile
	Broker_WhisperWhisper:LoadProfileVars()
	frameLock = not frameLock;
	Broker_WhispersWhisper_ToggleLock();
	
	
	
	
	-- Set up otpions and bind the Whisper events
	self:SetupOptions()
	self:RegisterEvent("CHAT_MSG_WHISPER_INFORM","WhisperSent")
	self:RegisterEvent("CHAT_MSG_WHISPER","WhisperRecieved")
	self:RegisterEvent("CHAT_MSG_BN_WHISPER","WhisperRecievedBN")
	self:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM","WhisperSentBN")
end

--------------------------------------------------------------------------------------------------------
--                          Broker_WhisperWhisper LDB Core Setup                                      --
--------------------------------------------------------------------------------------------------------
Broker_WhisperWhisper.obj = ldb:NewDataObject("Broker_WhisperWhisper", {
	type = "data source",
	label = "Broker_WhisperWhisper",
	text = initName,
	icon = "Interface\\Addons\\WhisperWhisper\\iconrest.tga",
})

local dataobj = Broker_WhisperWhisper.obj; -- Get a local instance of our data object

function dataobj.OnEnter(self) -- When they enter
	LDB_ANCHOR = self -- Anchor the LDB Anchor
	showingMenu = false; -- We're NOT showing the menu (since they just entered
	
	if LibQTip:IsAcquired("WhisperWhisper") then -- If we have the tooltip
		tooltip:Clear() -- Then clear it
		local myFont = CreateFont("tipFontTemp3");
		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
		tooltip:SetFont(myFont)
		if (IsAddOnLoaded("ElvUI") or IsAddOnLoaded("Tukui")) then tooltip:SetScript("OnShow", function(self) self:SetTemplate("Transparent") end) end
	else -- Otherwise, make it
		tooltip = LibQTip:Acquire("WhisperWhisper", 1, "LEFT")
		tooltip:SetBackdropColor(0,0,0,1)
		tooltip:SmartAnchorTo(self)
		tooltip:SetAutoHideDelay(0.25, self)
		local myFont = CreateFont("tipFontTemp3");
		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
		tooltip:SetFont(myFont)
		if (IsAddOnLoaded("ElvUI") or IsAddOnLoaded("Tukui")) then tooltip:SetScript("OnShow", function(self) self:SetTemplate("Transparent") end) end
	end
	if BWW_NOTIP or inCombat then
		Broker_WhisperWhisper:WhisperHover(tooltip)
		tooltip:Show();
	else
		tooltip:Hide();
	end
end
	
function dataobj.OnLeave() 

end

function dataobj.OnClick(self, msg)
	if msg == "RightButton" then
		if tooltip and LibQTip:IsAcquired("WhisperWhisper") then
			tooltip:Clear();
		end
		Broker_WhisperWhisper:RightClickMenu(tooltip)
	else
		if IsAltKeyDown() then
			Broker_WhisperWhisper_ClearAllWhispers()
		elseif whisperList[1] then
			local theRow = whisperList[1];
			Broker_WhisperWhisper:StartWhisper(theRow[1]);
		end
	end
end
	

--------------------------------------------------------------------------------------------------------
--                               Broker_WhisperWhisper event handlers                                 --
--------------------------------------------------------------------------------------------------------
function Broker_WhisperWhisper:WhisperSent(event, msg, target)
	if usePerm then
		self.obj.text = permColorFull .. target;
		Broker_WhisperWhisper_SetFlashPerm()
	else
		self.obj.text = sendColorFull .. target;
		Broker_WhisperWhisper_SetFlashSend()
	end
	Broker_WhisperWhisper_EndFlash()
	local notFound = true;
	local index = 0;
	local sanitycheck = 0;
		while (string.find(msg, "|r", index)) and sanitycheck<5 do
			local start, finish = string.find(msg, "|r", index);
			msg = string.sub(msg, 0, finish) .. sendColorFull .. string.sub(msg, finish);
			index = finish+1;
			sanitycheck = sanitycheck+1;
	end
			
	local foundIndex = -1;
	for ci=1, #whisperList do
		local theRow = whisperList[ci];
		if theRow[1] == target then
			notFound = false;
			foundIndex = ci;
			table.insert(theRow[2], 1, sendColorFull..msg);
			theRow[3] = true;
			local removal = #theRow[2];
			while (removal>numWhispers) do
				table.remove(theRow[2], removal);
				removal = #theRow[2];
			end
			break;
		end
	end
	if notFound then
		table.insert(whisperList, 1, {target, {sendColorFull..msg}, true, false});
		local removal = #whisperList;
		while (removal>numPlayers) do
			table.remove(whisperList, removal);
			removal = #whisperList;
		end
	else
		local theRow = whisperList[foundIndex];
		for ci=0, (foundIndex-2) do
			whisperList[foundIndex-ci] = whisperList[foundIndex-ci-1];
		end
		whisperList[1] = theRow;
	end
	
	if LibQTip:IsAcquired("WhisperWhisper") then
		if not showingMenu then
			tooltip:Clear()
			local myFont = CreateFont("tipFontTemp32");
			myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
			tooltip:SetFont(myFont)
			Broker_WhisperWhisper:WhisperHover(tooltip)
		end
	end
end

function Broker_WhisperWhisper:WhisperRecieved(event, msg, source)
	if usePerm then
		self.obj.text = permColorFull .. source;
		Broker_WhisperWhisper_SetFlashPerm()
	else
		self.obj.text = recColorFull .. source;
		Broker_WhisperWhisper_SetFlashRec()
	end
	Broker_WhisperWhisper_StartFlash()
	local notFound = true;
	local foundIndex = -1;
	local index = 0;
	local sanitycheck = 0;
	while (string.find(msg, "|r", index)) and sanitycheck<5 do
		local start, finish = string.find(msg, "|r", index);
		msg = string.sub(msg, 0, finish) .. recColorFull .. string.sub(msg, finish);
		index = finish+1;
		sanitycheck = sanitycheck+1;
	end
	
	for ci=1, #whisperList do
		local theRow = whisperList[ci];
		if theRow[1] == source then
			notFound = false;
			foundIndex = ci;
			table.insert(theRow[2], 1, recColorFull..msg);
			theRow[3] = false;
			local removal = #theRow[2];
			while removal>numWhispers do
				table.remove(theRow[2], removal);
				removal = #theRow[2];
			end
			break;
		end
	end
	
	if notFound then
		table.insert(whisperList, 1, {source, {recColorFull..msg}, false, false});
		local removal = #whisperList;
		while removal>numPlayers do
			table.remove(whisperList, removal);
			removal = #whisperList;
		end
	else
		local theRow = whisperList[foundIndex];
		for ci=0, (foundIndex-2) do
			whisperList[foundIndex-ci] = whisperList[foundIndex-ci-1];
		end
		whisperList[1] = theRow;
	end
	if LibQTip:IsAcquired("WhisperWhisper") then
		if not showingMenu then
			tooltip:Clear()
			local myFont = CreateFont("tipFontTemp31");
			myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
			tooltip:SetFont(myFont)
			Broker_WhisperWhisper:WhisperHover(tooltip)
		end
	end
end

function Broker_WhisperWhisper:WhisperSentBN(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
	local msg = arg1;
	local target = arg2;
	if usePerm then
		self.obj.text = permColorFull .. target;
		Broker_WhisperWhisper_SetFlashPerm()
	else
		self.obj.text = sendColorFull .. target;
		Broker_WhisperWhisper_SetFlashSend()
	end
	Broker_WhisperWhisper_EndFlash()
	local notFound = true;
	local index = 0;
	local sanitycheck = 0;
		while (string.find(msg, "|r", index)) and sanitycheck<5 do
			local start, finish = string.find(msg, "|r", index);
			msg = string.sub(msg, 0, finish) .. sendColorFull .. string.sub(msg, finish);
			index = finish+1;
			sanitycheck = sanitycheck+1;
	end
			
	local foundIndex = -1;
	for ci=1, #whisperList do
		local theRow = whisperList[ci];
		if theRow[1] == target then
			notFound = false;
			foundIndex = ci;
			table.insert(theRow[2], 1, sendColorFull..msg);
			theRow[3] = true;
			local removal = #theRow[2];
			while (removal>numWhispers) do
				table.remove(theRow[2], removal);
				removal = #theRow[2];
			end
			break;
		end
	end
	if notFound then
		table.insert(whisperList, 1, {target, {sendColorFull..msg}, true, true});
		local removal = #whisperList;
		while (removal>numPlayers) do
			table.remove(whisperList, removal);
			removal = #whisperList;
		end
	else
		local theRow = whisperList[foundIndex];
		for ci=0, (foundIndex-2) do
			whisperList[foundIndex-ci] = whisperList[foundIndex-ci-1];
		end
		whisperList[1] = theRow;
	end
	
	if LibQTip:IsAcquired("WhisperWhisper") then
		if not showingMenu then
			tooltip:Clear()
			local myFont = CreateFont("tipFontTemp34");
			myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
			tooltip:SetFont(myFont)
			Broker_WhisperWhisper:WhisperHover(tooltip)
		end
	end
end

function Broker_WhisperWhisper:WhisperRecievedBN(event, msg, source)
	if usePerm then
		self.obj.text = permColorFull .. source;
		Broker_WhisperWhisper_SetFlashPerm()
	else
		self.obj.text = recColorFull .. source;
		Broker_WhisperWhisper_SetFlashRec()
	end
	Broker_WhisperWhisper_StartFlash()
	local notFound = true;
	local foundIndex = -1;
	local index = 0;
	local sanitycheck = 0;
	while (string.find(msg, "|r", index)) and sanitycheck<5 do
		local start, finish = string.find(msg, "|r", index);
		msg = string.sub(msg, 0, finish) .. recColorFull .. string.sub(msg, finish);
		index = finish+1;
		sanitycheck = sanitycheck+1;
	end
	
	for ci=1, #whisperList do
		local theRow = whisperList[ci];
		if theRow[1] == source then
			notFound = false;
			foundIndex = ci;
			table.insert(theRow[2], 1, recColorFull..msg);
			theRow[3] = false;
			local removal = #theRow[2];
			while removal>numWhispers do
				table.remove(theRow[2], removal);
				removal = #theRow[2];
			end
			break;
		end
	end
	
	if notFound then
		table.insert(whisperList, 1, {source, {recColorFull..msg}, false, true});
		local removal = #whisperList;
		while removal>numPlayers do
			table.remove(whisperList, removal);
			removal = #whisperList;
		end
	else
		local theRow = whisperList[foundIndex];
		for ci=0, (foundIndex-2) do
			whisperList[foundIndex-ci] = whisperList[foundIndex-ci-1];
		end
		whisperList[1] = theRow;
	end
	if LibQTip:IsAcquired("WhisperWhisper") then
		if not showingMenu then
			tooltip:Clear()
			local myFont = CreateFont("tipFontTemp35");
			myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
			tooltip:SetFont(myFont)
			Broker_WhisperWhisper:WhisperHover(tooltip)
		end
	end
end




--------------------------------------------------------------------------------------------------------
--                                   Broker_WhisperWhisper functions                                  --
--------------------------------------------------------------------------------------------------------

-- Called after profile changed
function Broker_WhisperWhisper:OnProfileChanged(event, database, newProfileKey)
	profileDB = database.profile
	Broker_WhisperWhisper:LoadProfileVars()
end

function Broker_WhisperWhisper:LoadProfileVars()
	whisperList = profileDB["whisperList"];
	numPlayers = profileDB["numPlayers"];
	numWhispers = profileDB["numWhispers"];
	inCombat = profileDB["inCombat"];
	fullCombat = profileDB["fullCombat"];
	frameLock = profileDB["frameLock"];
	frameOpts = profileDB["frameOpts"];
	font = profileDB["font"];
	tipFont = profileDB["tipFont"];
	fontSize = profileDB["fontSize"];
	tipFontSize = profileDB["tipFontSize"];
	showFrame = profileDB["showFrame"];
	recColor = profileDB["recColor"];
	sendColor = profileDB["sendColor"];
	permColor = profileDB["permColor"];
	usePerm = profileDB["usePerm"];
	flashDuration = profileDB["flashDuration"];
	flashMaster = profileDB["flashMaster"];
	flashTop = profileDB["flashTop"];
	flashBottom = profileDB["flashBottom"];
	flashLeft = profileDB["flashLeft"];
	flashRight = profileDB["flashRight"];
	flashEntireFrame = profileDB["flashEntireFrame"];
	flashOffCombat = profileDB["flashOffCombat"];
	altView = profileDB["altView"];
	
	local fullLen = #whisperList;
	for ci=1,#whisperList do
		local theRow = whisperList[fullLen-ci+1]
		if theRow and theRow[4] then
			table.remove(whisperList, fullLen-ci+1)
		end
	end
	
	if font then
		mainFontString:SetFont(LSM:Fetch("font",font), fontSize);
		local file, height, flags = mainFontString:GetFont()
		WhisperWhisper_mainFrame:SetHeight(height)
	end
	Broker_WhisperWhisper_UpdateColors()
	
	
	WhisperWhisper_mainFrame:ClearAllPoints()
	WhisperWhisper_mainFrame:SetPoint(frameOpts.anchorFrom, UIParent, frameOpts.anchorTo, frameOpts.offsetx, frameOpts.offsety); -- Correct frame position
	if showFrame then -- Show/Hide based on user indication
		WhisperWhisper_mainFrame:Show()
	else
		WhisperWhisper_mainFrame:Hide()
	end
	
	
	if whisperList[1] then -- If they had whispers
		local theRow = whisperList[1]; -- Then get the author
		if usePerm then 
			initName = permColorFull..theRow[1];
			Broker_WhisperWhisper_SetFlashPerm()
		else 
			if theRow[3] then
				initName = sendColorFull..theRow[1]; -- Color based on last whisper
				Broker_WhisperWhisper_SetFlashSend()
			else
				initName = recColorFull..theRow[1];
				Broker_WhisperWhisper_SetFlashRec()
			end
		end
		
		Broker_WhisperWhisper_EndFlash()
		if Broker_WhisperWhisper.obj then -- If we've made the LDB object by this point
			Broker_WhisperWhisper.obj.text = initName; -- Then update its text
		end
		mainFontString:SetText(initName); -- And our basic thing
	else
		mainFontString:SetText("WhisperWhisper");
	end
end

-- Open config window
function Broker_WhisperWhisper:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.profile)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.general)
end

function Broker_WhisperWhisper:StartWhisper(player)
	SetItemRef("player:"..player, "|Hplayer:"..player.."|h["..player.."]|h", "LeftButton")
end

function Broker_WhisperWhisper_StartWhisperFromMenu(cell,player)
	SetItemRef("player:"..player, "|Hplayer:"..player.."|h["..player.."]|h", "LeftButton")
end

function Broker_WhisperWhisper:InitBasicTooltip()

end

function Broker_WhisperWhisper:WhisperHover(tooltip)
	if altView then
		if tooltip and LibQTip:IsAcquired("WhisperWhisper") then
			tooltip:Clear();
		end
		Broker_WhisperWhisper:RightClickMenu(tooltip)
	else
		if LibQTip:IsAcquired("WhisperWhisper") then -- If we have the tooltip
			tooltip:Clear() -- Then clear it
			local myFont = CreateFont("tipFontTemp3");
			myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
			tooltip:SetFont(myFont)
		else -- Otherwise, make it
			tooltip = LibQTip:Acquire("WhisperWhisper", 1, "LEFT")
			tooltip:SetBackdropColor(0,0,0,1)
			tooltip:SmartAnchorTo(self)
			tooltip:SetAutoHideDelay(0.25, self)
			local myFont = CreateFont("tipFontTemp3");
			myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
			tooltip:SetFont(myFont)
		end
		if whisperList[1] then
			local theRow = whisperList[1];
			local allWhispers = theRow[2];
			tooltip:AddLine("|cffffffff" .. theRow[1]);
			tooltip:AddSeparator(2);
			for ci = 1, #allWhispers do
				tooltip:AddLine();
				tooltip:SetCell(ci+2,1,""..allWhispers[#allWhispers-ci+1],nil,nil,nil,nil,nil,nil,475,150);
			end
			tooltip:AddSeparator(15,0,0,0);
		end
		tooltip:AddSeparator(2)
		tooltip:AddLine("Hint:")
		tooltip:AddLine("|cfffeb105Click|r |cfffcff26to reply to this person|r")
		tooltip:AddLine("|cfffeb105Right-Click|r |cfffcff26to open all conversations|r")
		tooltip:AddLine("|cfffeb105Alt-Click|r |cfffcff26to clear all conversations|r")
		tooltip:AddSeparator(2)
		tooltip:AddLine("Broker_WhisperWhisper "..GetAddOnMetadata("WhisperWhisper", "Version"))
	end
end

function Broker_WhisperWhisper:RightClickMenu(tooltip)
	showingMenu = true
	menuWhispers = whisperList;
	if LibQTip:IsAcquired("WhisperWhisper") then -- If we have the tooltip
		tooltip:Clear() -- Then clear it
		local myFont = CreateFont("tipFontTemp3");
		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
		tooltip:SetFont(myFont)
	else -- Otherwise, make it
		tooltip = LibQTip:Acquire("WhisperWhisper", 1, "LEFT")
		tooltip:SetBackdropColor(0,0,0,1)
		tooltip:SmartAnchorTo(self)
		tooltip:SetAutoHideDelay(0.25, self)
		local myFont = CreateFont("tipFontTemp3");
		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
		tooltip:SetFont(myFont)
	end
	tooltip:SetColumnLayout(1, "LEFT");
	for ci=1,#menuWhispers do
		local theRow = menuWhispers[ci];
		local name = theRow[1];
		if theRow[3] then
			tooltip:AddLine(sendColorFull .. theRow[1]);
		else
			tooltip:AddLine(recColorFull .. theRow[1]);
		end
		tooltip:SetCellScript(ci,1,"OnEnter",Broker_WhisperWhisper_ShowFullConvoNew, ci);
		tooltip:SetCellScript(ci,1,"OnLeave",Broker_WhisperWhisper_HideFull, ci);
		tooltip:SetCellScript(ci,1,"OnMouseUp",Broker_WhisperWhisper_StartWhisperFromMenu, theRow[1]);
	end
	tooltip:AddSeparator(2);
	tooltip:AddLine("|cffffffffOptions|r");
	tooltip:SetCellScript((#menuWhispers+2),1,"OnMouseUp",Broker_WhispersWhisper_OpenOptions);
	tooltip:AddSeparator(2);
	tooltip:AddLine("|cffffffffToggle Lock|r");
	tooltip:SetCellScript((#menuWhispers+4),1,"OnMouseUp",Broker_WhispersWhisper_ToggleLock);
	tooltip:AddSeparator(2);
	tooltip:AddLine("|cffffffffClear All Whispers|r")
	tooltip:SetCellScript((#menuWhispers+6),1,"OnMouseUp",Broker_WhisperWhisper_ClearAllWhispers);
end

function Broker_WhisperWhisper_ShowFullConvoNew(cell, index)
	local theRow = menuWhispers[index];
	local theWhispers = theRow[2];
	
	if LibQTipMenu:IsAcquired("WhisperWhisperMenu") then
		menuTooltip:Clear()
		local myFont = CreateFont("tipFontTemp36");
		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
		menuTooltip:SetFont(myFont)
	else
		menuTooltip = LibQTipMenu:Acquire("WhisperWhisperMenu", 1, "LEFT")

		menuTooltip:SetBackdropColor(0,0,0,1)
		local myFont = CreateFont("tipFontTemp36");
		myFont:SetFont(LSM:Fetch("font",tipFont), tipFontSize)
		menuTooltip:SetFont(myFont)

		--menuTooltip:SmartAnchorTo(cell)
	end
	menuTooltip:ClearAllPoints();
	menuTooltip:SetPoint("TOPLEFT", cell, "RIGHT", 6, 0)
	for ci=1,#theWhispers do
		menuTooltip:AddLine();
		menuTooltip:SetCell(ci,1,""..theWhispers[#theWhispers-ci+1],nil,nil,nil,nil,nil,nil,475,150);
	end
	menuTooltip:Show();
	if menuTooltip:GetRight() > Broker_WhisperWhisper:GetScreenWidth() then
		menuTooltip:ClearAllPoints();
		if menuTooltip:GetBottom() < 0 then
			menuTooltip:SetPoint("BOTTOMRIGHT", cell, "LEFT", -6, 0);
		else
			menuTooltip:SetPoint("TOPRIGHT", cell, "LEFT", -6, 0);
		end
	else
		if menuTooltip:GetBottom() < 0 then
			menuTooltip:ClearAllPoints();
			menuTooltip:SetPoint("BOTTOMLEFT", cell, "RIGHT", 6, 0);
		end
	end
	
end

function Broker_WhisperWhisper_HideFull(cell, index)
	if menuTooltip then
		menuTooltip:Hide();
	end
end

function Broker_WhispersWhisper_OpenOptions()
	if menuTooltip then
		menuTooltip:Hide();
	end
	if tooltip then
		tooltip:Hide();
	end
	InterfaceOptionsFrame_OpenToCategory("WhisperWhisper")
end

function Broker_WhisperWhisper:GetScreenWidth()
	local width, height = strsplit("x", GetCVar("gxResolution"))
	return tonumber(width)
end

function Broker_WhisperWhisper:GetScreenHeight()
	local width, height = strsplit("x", GetCVar("gxResolution"))
	return tonumber(height)
end

function Broker_WhispersWhisper_ToggleLock()
	if frameLock then
		frameLock = false
		profileDB["frameLock"] = false
	else
		frameLock = true
		profileDB["frameLock"] = true
	end
	
	if not frameLock then
		WhisperWhisper_mainFrame:SetMovable(true)
		WhisperWhisper_mainFrame:RegisterForDrag("LeftButton")
		WhisperWhisper_mainFrame:SetScript("OnMouseDown", 
			function(self, button) 
				 if button == "LeftButton" and not self.isMoving then	
					local from, to;
					from, theBind, to, xposBefore, yposBefore = self:GetPoint() 

					self:StartMoving();
					self.isMoving = true;
					from, _, to, relXPos, relYPos = self:GetPoint()
				end
			end
		)
		WhisperWhisper_mainFrame:SetScript("OnMouseUp",
			function(self, button)
				printd("fired");
				if button == "LeftButton" and IsAltKeyDown() and not self.isMoving then
					Broker_WhisperWhisper_ClearAllWhispers()
				end
				if button == "LeftButton" and self.isMoving then
					printd("fired");
					local from, _, to, rel2x, rel2y = WhisperWhisper_mainFrame:GetPoint();
					
				    self:StopMovingOrSizing()
					self.isMoving = false
					local newxpos = xposBefore + rel2x - relXPos;
					local newypos = yposBefore + rel2y - relYPos;
					
					self:ClearAllPoints()
					self:SetPoint("CENTER", theBind, "CENTER", newxpos, newypos);

				    local opts = profileDB["frameOpts"];
				    opts.anchorFrom = "CENTER"
				    opts.anchorTo = "CENTER"
				    opts.offsetx = newxpos
				    opts.offsety = newypos
					profileDB["frameOpts"] = opts
					local from, _, to, rel2x, rel2y = self:GetPoint();
			    end
				
				if button == "RightButton" then
					if tooltip and LibQTip:IsAcquired("WhisperWhisper") then
						tooltip:Clear();
					end
					Broker_WhisperWhisper:RightClickMenu(tooltip)
				end
			end
		)
		WhisperWhisper_mainFrame.texture:SetTexture(.4, .4, .4, .5)
	else
		WhisperWhisper_mainFrame:SetScript("OnMouseUp", Broker_WhisperWhisper_OnClickWhisperWhisper_mainFrame)
		WhisperWhisper_mainFrame:SetScript("OnMouseDown", nil)
		WhisperWhisper_mainFrame:SetMovable(false)
		WhisperWhisper_mainFrame.texture:SetTexture(.4, .4, .4, 0)
	end
end

function Broker_WhisperWhisper_RGBtoHex(R,G,B)
	return "|cff" .. Broker_WhisperWhisper_toHex( R) .. Broker_WhisperWhisper_toHex(G) .. Broker_WhisperWhisper_toHex(B)
	
end

function Broker_WhisperWhisper_toHex(N)
	local temphexStr = "0123456789abcdef"
	return string.sub(temphexStr,((N-mod(N,16))/16)+1,((N-mod(N,16))/16)+1) .. string.sub(temphexStr,mod(N,16)+1, mod(N,16)+1)
end

function Broker_WhisperWhisper_UpdateColors()
	recColorFull = Broker_WhisperWhisper_RGBtoHex(recColor.r, recColor.g, recColor.b)
	sendColorFull = Broker_WhisperWhisper_RGBtoHex(sendColor.r, sendColor.g, sendColor.b)
	permColorFull = Broker_WhisperWhisper_RGBtoHex(permColor.r, permColor.g, permColor.b)
	
	if whisperList[1] then -- If they had whispers
		local theRow = whisperList[1]; -- Then get the author
		if usePerm then
			Broker_WhisperWhisper.obj.text = permColorFull .. theRow[1];
			Broker_WhisperWhisper_SetFlashPerm()
		else
			if theRow and theRow[3] then
				Broker_WhisperWhisper.obj.text = sendColorFull .. theRow[1];
				Broker_WhisperWhisper_SetFlashSend()
			else
				Broker_WhisperWhisper.obj.text = recColorFull .. theRow[1];
				Broker_WhisperWhisper_SetFlashRec()
			end
		end
	end
end

function Broker_WhisperWhisper_ClearAllWhispers()
	profileDB.whisperList = {}
	whisperList = {}
	if tooltip then
		tooltip:Hide()
	end
	
	if menuTooltip then
		menuTooltip:Hide()
	end
	
	if usePerm then
		Broker_WhisperWhisper.obj.text = permColorFull.."WhisperWhisper"
	else
		Broker_WhisperWhisper.obj.text = "WhisperWhisper"
	end
	whisperList = profileDB["whisperList"]
end
	
function Broker_WhisperWhisper_ResetSize()
	mainFontString:SetFont(LSM:Fetch("font",font), fontSize);
	local file, height, flags = mainFontString:GetFont()
	local width = floor(mainFontString:GetStringWidth()) + 5;
	WhisperWhisper_mainFrame:SetWidth(floor(mainFontString:GetStringWidth()) + 5);
	WhisperWhisper_mainFrame:SetHeight(height+2)
	leftFlashFrame:SetHeight((height+2)*.85)
	leftFlashFrame:SetWidth((height+2)*.85)
	rightFlashFrame:SetHeight((height+2)*.85)
	rightFlashFrame:SetWidth((height+2)*.85)
	botFlashFrame:SetHeight(height*.85)
	botFlashFrame:SetWidth(width+(height+2)*.9)
	topFlashFrame:SetHeight(height*.85)
	topFlashFrame:SetWidth(width+(height+2)*.9)
end

function Broker_WhisperWhisper_SetFlashSend()
	leftFlashFrame.texture:SetGradient("HORIZONTAL", sendColor.r/255, sendColor.g/255, sendColor.b/255, sendColor.r/255, sendColor.g/255, sendColor.b/255);
	rightFlashFrame.texture:SetGradient("HORIZONTAL", sendColor.r/255, sendColor.g/255, sendColor.b/255, sendColor.r/255, sendColor.g/255, sendColor.b/255);
	botFlashFrame.texture:SetGradient("HORIZONTAL", sendColor.r/255, sendColor.g/255, sendColor.b/255, sendColor.r/255, sendColor.g/255, sendColor.b/255);
	topFlashFrame.texture:SetGradient("HORIZONTAL", sendColor.r/255, sendColor.g/255, sendColor.b/255, sendColor.r/255, sendColor.g/255, sendColor.b/255);
end

function Broker_WhisperWhisper_SetFlashRec()
	leftFlashFrame.texture:SetGradient("HORIZONTAL", recColor.r/255, recColor.g/255, recColor.b/255, recColor.r/255, recColor.g/255, recColor.b/255);
	rightFlashFrame.texture:SetGradient("HORIZONTAL", recColor.r/255, recColor.g/255, recColor.b/255, recColor.r/255, recColor.g/255, recColor.b/255);
	topFlashFrame.texture:SetGradient("HORIZONTAL", recColor.r/255, recColor.g/255, recColor.b/255, recColor.r/255, recColor.g/255, recColor.b/255);
	botFlashFrame.texture:SetGradient("HORIZONTAL", recColor.r/255, recColor.g/255, recColor.b/255, recColor.r/255, recColor.g/255, recColor.b/255);
end

function Broker_WhisperWhisper_SetFlashPerm()
	leftFlashFrame.texture:SetGradient("HORIZONTAL", permColor.r/255, permColor.g/255, permColor.b/255, permColor.r/255, permColor.g/255, permColor.b/255);
	rightFlashFrame.texture:SetGradient("HORIZONTAL", permColor.r/255, permColor.g/255, permColor.b/255, permColor.r/255, permColor.g/255, permColor.b/255);
	botFlashFrame.texture:SetGradient("HORIZONTAL", permColor.r/255, permColor.g/255, permColor.b/255, permColor.r/255, permColor.g/255, permColor.b/255);
	topFlashFrame.texture:SetGradient("HORIZONTAL", permColor.r/255, permColor.g/255, permColor.b/255, permColor.r/255, permColor.g/255, permColor.b/255);
end

function Broker_WhisperWhisper_StartFlash()
	if showFrame then
		combatClear = true;
		if UIFrameIsFlashing(leftFlashFrame) then
			UIFrameFlashStop(leftFlashFrame)
		end
		if UIFrameIsFlashing(rightFlashFrame) then
			UIFrameFlashStop(rightFlashFrame)
		end
		if UIFrameIsFlashing(WhisperWhisper_mainFrame) then
			UIFrameFlashStop(WhisperWhisper_mainFrame)
		end
		if UIFrameIsFlashing(topFlashFrame) then
			UIFrameFlashStop(topFlashFrame)
		end
		if UIFrameIsFlashing(botFlashFrame) then
			UIFrameFlashStop(botFlashFrame)
		end
		if flashMaster then
			if BWW_NOTIP or (not flashOffCombat) then
				if flashLeft then
					UIFrameFlash(leftFlashFrame, .9, .75, flashDuration, false, .35, 0)
				end
				
				if flashRight then
					UIFrameFlash(rightFlashFrame, .9, .75, flashDuration, false, .35, 0)
				end
				
				if flashTop then
					UIFrameFlash(topFlashFrame, .9, .75, flashDuration, false, .35, 0)
				end
				
				if flashBottom then
					UIFrameFlash(botFlashFrame, .9, .75, flashDuration, false, .35, 0)
				end
				
				if flashEntireFrame then
					UIFrameFlash(WhisperWhisper_mainFrame, .9, .75, flashDuration, true, .35, 0)
				end
			end
		end
	end
end

function Broker_WhisperWhisper_EndFlash()
	combatClear = false;
	if UIFrameIsFlashing(leftFlashFrame) then
		UIFrameFlashStop(leftFlashFrame)
	end
	if UIFrameIsFlashing(rightFlashFrame) then
		UIFrameFlashStop(rightFlashFrame)
	end
	if UIFrameIsFlashing(topFlashFrame) then
		UIFrameFlashStop(topFlashFrame)
	end
	if UIFrameIsFlashing(botFlashFrame) then
		UIFrameFlashStop(botFlashFrame)
	end
	if UIFrameIsFlashing(WhisperWhisper_mainFrame) then
		UIFrameFlashStop(WhisperWhisper_mainFrame)
	end
	rightFlashFrame:Hide();
	leftFlashFrame:Hide();
	botFlashFrame:Hide();
	topFlashFrame:Hide();
end

