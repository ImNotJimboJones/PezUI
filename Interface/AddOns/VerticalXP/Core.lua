-----------------------------------------
--             VerticalXP              --  
--         Created by: Ifandbut        --
-----------------------------------------
--Uses Ace3 and AceGUI-3.0-SharedMediaWidgets
--Extra textures taken from SharedMedia

--Version History
	--V 1.0 11/04/2010
		--Added XP Bubbles
		--Added % of level for rest xp
		--Added Clamp to screen toggle
		--Changed color selector names in config menu
		--Fixed bug: Rest XP bar not sizeing correctly when earning rest xp after running out of rest xp (Shiznicle)
		--General code cleanup
	--V 0.5 10/29/2010
		--Vertical XP now hides the Blizzard XP bar
		--Added XP Bar Textures
		--Added Background Textures
		--Added Edge Textures
		--Added /vxp to open the config menu
		--Added tooltip displaying XP values
		--Fixed bug: colors not updating properply upon resting (Shiznicle)
		--Organized config menu (/vxp config menu is still a mess)
		--Updated the description you see on the WoW Addons menu.
	--V 0.4 10/28/2010
		--Initial Release

VerticalXP = LibStub("AceAddon-3.0"):NewAddon("VerticalXP", "AceConsole-3.0", "AceEvent-3.0")

local versionText = "Version 1.0 (11/04/2010)" --Version information to be displayed in the config menu
local self = VerticalXP
local rotate_90 = math.pi / 2

local LSM3 = LibStub("LibSharedMedia-3.0")
local LibQTip = LibStub('LibQTip-1.0')

--Register additional Textures
LSM3:Register("border", "RothSquare", "Interface\\Addons\\VerticalXP\\textures\\border\\roth")
LSM3:Register("statusbar", "Aluminium",	"Interface\\Addons\\VerticalXP\\textures\\statusbar\\Aluminium")
LSM3:Register("statusbar", "Armory", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Armory")
LSM3:Register("statusbar", "BantoBar", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\BantoBar")
LSM3:Register("statusbar", "Charcoal", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Charcoal")
LSM3:Register("statusbar", "Cilo", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Cilo")
LSM3:Register("statusbar", "Cloud",	"Interface\\Addons\\VerticalXP\\textures\\statusbar\\Cloud")
LSM3:Register("statusbar", "Comet",	"Interface\\Addons\\VerticalXP\\textures\\statusbar\\Comet")
LSM3:Register("statusbar", "Dabs", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Dabs")
LSM3:Register("statusbar", "DarkBottom", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\DarkBottom")
LSM3:Register("statusbar", "Diagonal", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Diagonal")
LSM3:Register("statusbar", "Falumn", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Falumn")
LSM3:Register("statusbar", "Flat", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Flat")
LSM3:Register("statusbar", "Glass",	"Interface\\Addons\\VerticalXP\\textures\\statusbar\\Glass")
LSM3:Register("statusbar", "Glaze",	"Interface\\Addons\\VerticalXP\\textures\\statusbar\\Glaze")
LSM3:Register("statusbar", "Gloss",	"Interface\\Addons\\VerticalXP\\textures\\statusbar\\Gloss")
LSM3:Register("statusbar", "Graphite", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Graphite")
LSM3:Register("statusbar", "Melli", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Melli")
LSM3:Register("statusbar", "Melli Dark", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\MelliDark")
LSM3:Register("statusbar", "Minimalist", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Minimalist")
LSM3:Register("statusbar", "Otravi", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Otravi")
LSM3:Register("statusbar", "Smooth", "Interface\\Addons\\VerticalXP\\textures\\statusbar\\Smooth")
LSM3:Register("statusbar", "Smooth v2",	"Interface\\Addons\\VerticalXP\\textures\\statusbar\\Smoothv2")
LSM3:Register("statusbar", "Wisps",	"Interface\\Addons\\VerticalXP\\textures\\statusbar\\Wisps")

--Saved Variables Defaults
local defaults = {
	profile = {
		enabled = true, 
		border = true, 
		bubbles = true,
		clamp = true,
		height = 500, --Base frame 
		width = 20, --Base frame 
		XPColor = { r = 0, g = 255/255, b = 64/255, a = 1 }, 
		RestedColor = { r = 99/255, g = 17/255, b = 198/255, a = 1}, 
		RestXPColor = { r = 27/255, g = 90/255, b = 209/255, a = 1}, 
		positionX = 300, --offset from left of screen to left of frame
		positionY = 200, --offset from bottom of screen to bottom of frame
		barTexture = "Blizzard",
		borderTexture = "Blizzard Dialog",
		backgroundTexture = "Blizzard Dialog Background"
	}
}

--Options Table
function VerticalXP_Options(uiTypes, uiName, appName)
	local options = {
		type = "group",
		name = "Vertical XP Bar Options",
		args = {
			version = {
				name = versionText,
				type = "header",
				order = 0,
				width = "full"
			},
			enable = {
				name = "Enable",
				desc = "Enable Vertical XP Bar",
				type = "toggle",
				order = 100,
				width = "full",
				set = function(info, value)
					self.db.profile.enabled = value;
					self:ToggleXPBar();
				end,
				get = function(info) return self.db.profile.enabled end
			},
			locked = {
				name = "Locked",
				desc = "Disable to drag the XP bar",
				type = "toggle",
				order = 200,
				set = function(info, value)
					self.locked = value;
				end,
				get = function(info) return self.locked end
			},
			clamp = {
				name = "Clamp",
				desc = "Clamp to screen",
				type = "toggle",
				order = 225,
				set = function(info,value)
					self.db.profile.clamp = value;
					self:UpdateClamp();
				end,
				get = function(info) return self.db.profile.clamp end
			},
			bubbles = {
				name = "Bubbles",
				desc = "Turn XP bubbles on and off",
				type = "toggle",
				order = 250,
				set = function(info, value)
					self.db.profile.bubbles = value;
					self:UpdateBubbles();
				end,
				get = function(info) return self.db.profile.bubbles end
			},
			verticalSize = {
				name = "Vertical Size",
				desc = "Adjust the height of the XP bar",
				type = "range",
				order = 400,
				min = 200,
				max = 2000,
				step = 5,
				set = function(info, value)
					self.db.profile.height = value;
					self:UpdateHeight();
				end,
				get = function(info) return self.db.profile.height end
			},
			horizontalSize = {
				name = "Horizontal Size",
				desc = "Adjust the width of the XP bar",
				type = "range",
				order = 500,
				min = 15,
				max = 100,
				step = 1,
				set = function(info,value)
					self.db.profile.width = value;
					self:UpdateWidth();
				end,
				get = function(info) return self.db.profile.width end
			},
			border = {
				name = "Border",
				desc = "Toggle the border",
				type = "toggle",
				order = 300,
				set = function(info, value)
					self.db.profile.border = value;
					self:UpdateBorder();
				end,
				get = function(info) return self.db.profile.border end
			},
			xpColor = {
				name = "XP Earned",
				desc = "Set the color of the XP bar",
				type = "color",
				order = 1000,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.XPColor.r, self.db.profile.XPColor.g, self.db.profile.XPColor.b, self.db.profile.XPColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.XPColor.r, self.db.profile.XPColor.g, self.db.profile.XPColor.b, self.db.profile.XPColor.a end
			},
			restedColor = {
				name = "Rested XP",
				desc = "Set the color of the XP bar when rested",
				type = "color",
				order = 1100,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.RestedColor.r, self.db.profile.RestedColor.g, self.db.profile.RestedColor.b, self.db.profile.RestedColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.RestedColor.r, self.db.profile.RestedColor.g, self.db.profile.RestedColor.b, self.db.profile.RestedColor.a end
			},
			restXPColor = {
				name = "Remaining Rest XP",
				desc = "Set the color of the Rest XP bar",
				type = "color",
				order = 1200,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.RestXPColor.r, self.db.profile.RestXPColor.g, self.db.profile.RestXPColor.b, self.db.profile.RestXPColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.RestXPColor.r, self.db.profile.RestXPColor.g, self.db.profile.RestXPColor.b, self.db.profile.RestXPColor.a end
			},
			barTexture = {
				order = 600,
				width = "double",
				type = 'select',
				dialogControl = 'LSM30_Statusbar',
				name = 'XP Bar Texture',
				desc = 'Select the texture of the XP bar.',
				values = AceGUIWidgetLSMlists.statusbar,
				set = function(info,value)
					self.db.profile.barTexture = value;
					self:UpdateTexture(value);
				end,
				get = function(info) return self.db.profile.barTexture end
			},
			borderTexture = {
				order = 700,
				width = "double",
				type = 'select',
				dialogControl = 'LSM30_Border',
				name = 'XP Bar Border',
				desc = 'Select the border of the XP bar.',
				values = AceGUIWidgetLSMlists.border,
				set = function(info,value)
					self.db.profile.borderTexture = value;
					self:UpdateBaseFrame();
				end,
				get = function(info) return self.db.profile.borderTexture end
			},
			backgroundTexture = {
				order = 900,
				width = "double",
				type = 'select',
				dialogControl = 'LSM30_Background',
				name = 'Background Texture',
				values = AceGUIWidgetLSMlists.background,
				set = function(info, value)
					self.db.profile.backgroundTexture = value;
					self:UpdateBaseFrame();
				end,
				get = function(info) return self.db.profile.backgroundTexture end
			}
		}
	}
	return options;
end

--Runs on load or reload ui
function VerticalXP:OnInitialize()
	--Force the user to unlock the bar
	self.locked = true;
	--Register Events
	self:RegisterEvent("PLAYER_XP_UPDATE", "UpdateXPBar");
	self:RegisterEvent("UPDATE_EXHAUSTION", "UpdateRestXP");
	self:RegisterEvent("PLAYER_LEVEL_UP", "UpdateLevelUp");
	self:RegisterChatCommand("vxp", "HandleSlashCommand");
	--Setup Options 
	LibStub("AceConfig-3.0"):RegisterOptionsTable("VerticalXP", VerticalXP_Options);
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("VerticalXP", "Vertical XP Bar");
	self.db = LibStub("AceDB-3.0"):New("VerticalXPDB", defaults, true);
end

--Runs when addon is enabled by user
function VerticalXP:OnEnable()
	self:CreateXPFrames();
	
	--Runthrough config options
	self:UpdateTexture(self.db.profile.barTexture);
	self:UpdateBaseFrame();
	self:UpdateClamp();
	self:UpdateBubbles();
	self:UpdateBorder();
	self:UpdateWidth();
	self:UpdateHeight();
	self:UpdateRestXP();
	self:ToggleXPBar();
	self:Print("VerticalXP Enabled");
end

--Runs when addon is disabled by user
function VerticalXP:OnDisable()
	--No clue what I should do here
end

--Render the frames
function VerticalXP:CreateXPFrames()

	--Background Frame
	self.frame = CreateFrame("Frame", "VerticalXPFrame", UIParent);
	self.frame:SetMovable(false);
	self.frame:EnableMouse(false);
	self.frame:SetFrameStrata("BACKGROUND");
	self.frame:SetScale(1);
	self.frame:SetFrameLevel(1);
	self.frame:ClearAllPoints();
	self.frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", self.db.profile.positionX, self.db.profile.positionY);
	self.frame:SetMovable(true);
	self.frame:EnableMouse(true);
	--Workaround to let the bar be movable and still show tooltip
	--With this, cannot click through to rotate camera however
	self.frame:SetScript("OnDragStart", function()
		if not self.locked then
			self.frame:StartMoving();
		end
	end);
	self.frame:SetScript("OnDragStop", function() 
		self.frame:StopMovingOrSizing();
		self.db.profile.positionX = self.frame:GetLeft();
		self.db.profile.positionY = self.frame:GetBottom();
	end);
	
	self.frame:SetScript("OnEnter", self.MouseEnter);
	self.frame:SetScript("OnLeave", self.MouseLeave);
	self.frame:RegisterForDrag("LeftButton");
	
	--Rest XP Bar
	self.frame.RestXP = CreateFrame("StatusBar", "RestXP", VerticalXPFrame);
	self.frame.RestXP:SetScale(1);
	self.frame.RestXP:SetFrameLevel(2);
	self.frame.RestXP:ClearAllPoints();
	self.frame.RestXP:SetPoint("Center", VerticalXPFrame, "Center", 0, 0);
	self.frame.RestXP:SetOrientation("VERTICAL");
	
	--The actual XP bar
	self.frame.XPBar = CreateFrame("StatusBar", "VerticalXPBar", VerticalXPFrame);
	self.frame.XPBar:SetScale(1);
	self.frame.XPBar:SetFrameLevel(3);
	self.frame.XPBar:ClearAllPoints();
	self.frame.XPBar:SetPoint("Center", VerticalXPFrame, "Center", 0, 0);
	self.frame.XPBar:SetOrientation("VERTICAL");
	
	--The XP Bubbles
	self.frame.Bubbles = CreateFrame("StatusBar", "Bubbles", VerticalXPFrame);
	self.frame.Bubbles:SetScale(1);
	self.frame.Bubbles:SetFrameLevel(4);
	self.frame.Bubbles:ClearAllPoints();
	self.frame.Bubbles:SetPoint("Center", VerticalXPFrame, "Center", 0, 0);
	self.frame.Bubbles:SetOrientation("VERTICAL");
	self.frame.Bubbles:SetStatusBarTexture("Interface\\Addons\\VerticalXP\\textures\\Bubbles");
end


----------------------------
--Configuration Functions
----------------------------

--Clamp to screen
function VerticalXP:UpdateClamp()
	if self.db.profile.clamp then
		self.frame:SetClampedToScreen(true);
	else
		self.frame:SetClampedToScreen(false);
	end
end

--Bubbles
function VerticalXP:UpdateBubbles()
	if self.db.profile.bubbles then
		self.frame.Bubbles:Show();
	else
		self.frame.Bubbles:Hide();
	end
end

--Update the background and border textures
function VerticalXP:UpdateBaseFrame()
	local frameTexture = LSM3:Fetch("border", self.db.profile.borderTexture);
	local bgTexture = LSM3:Fetch("background", self.db.profile.backgroundTexture);
	self.frame:SetBackdrop({
		bgFile = bgTexture,
		edgeFile = frameTexture,
		tile = false,
		tileSize = 32,
		edgeSize = 12,
		insets = { left = 1, right = 1, top = 1, bottom = 1, },
	});
end

--Update and Rotate bar textures
function VerticalXP:UpdateTexture(texture)
	local textureFile = LSM3:Fetch("statusbar", texture);
	self.frame.RestXP:SetStatusBarTexture(textureFile);
	self.frame.RestXP:GetStatusBarTexture():SetRotation(rotate_90);
	self.frame.XPBar:SetStatusBarTexture(textureFile);
	self.frame.XPBar:GetStatusBarTexture():SetRotation(rotate_90);
end

--General color handler function
function VerticalXP:UpdateColors()
	if GetXPExhaustion() then
		self.frame.XPBar:SetStatusBarColor(self.db.profile.RestedColor.r, self.db.profile.RestedColor.g, self.db.profile.RestedColor.b, self.db.profile.RestedColor.a);
	else
		self.frame.XPBar:SetStatusBarColor(self.db.profile.XPColor.r, self.db.profile.XPColor.g, self.db.profile.XPColor.b, self.db.profile.XPColor.a);
	end
	self.frame.RestXP:SetStatusBarColor(self.db.profile.RestXPColor.r, self.db.profile.RestXPColor.g, self.db.profile.RestXPColor.b, self.db.profile.RestXPColor.a);
end

--Includes code to hide Blizzard XP bar
function VerticalXP:ToggleXPBar()
	if self.db.profile.enabled then
		self.frame:Show();
		MainMenuExpBar:HookScript("OnEvent", function(self) self:Hide() end)
		MainMenuExpBar:HookScript("OnShow", function(self) self:Hide() end)
		MainMenuExpBar:Hide()
	else
		self.frame:Hide();
		MainMenuExpBar:HookScript("OnEvent", function(self) self:Show() end)
		MainMenuExpBar:HookScript("OnShow", function(self) self:Show() end)
		MainMenuExpBar:Show()
	end
end

--Called from config
function VerticalXP:UpdateBorder()
	if self.db.profile.border then
		self.frame:SetBackdropBorderColor(1, 1, 1, 1);
	else
		self.frame:SetBackdropBorderColor(1, 1, 1, 0);
	end
end
	
--Height resize function, called from config	
function VerticalXP:UpdateHeight()
	self.frame:SetHeight(self.db.profile.height);
	self.frame.XPBar:SetHeight(self.db.profile.height - 8);
	self.frame.RestXP:SetHeight(self.db.profile.height - 8);
	self.frame.Bubbles:SetHeight(self.db.profile.height - 8);
	self.frame.XPBar:SetValue(0);
	self.frame.RestXP:SetValue(0);
	self:UpdateXPBar();
end

--Width Resize function, called from config
function VerticalXP:UpdateWidth()
	self.frame:SetWidth(self.db.profile.width);
	self.frame.XPBar:SetWidth(self.db.profile.width - 10);
	self.frame.RestXP:SetWidth(self.db.profile.width - 10);
	self.frame.Bubbles:SetWidth(self.db.profile.width - 10);
end

----------------------------------------------------
--Events Section
----------------------------------------------------

--General Update when XP changes
function VerticalXP:UpdateXPBar()
	self.frame.XPBar:SetMinMaxValues(0, UnitXPMax("player"));
	self.frame.XPBar:SetValue(UnitXP("player"));
	--Hide the RestXP bar if there is no Rest XP
	if not GetXPExhaustion() then
		self.frame.RestXP:Hide();
	else
		self.frame.RestXP:SetMinMaxValues(0, UnitXPMax("player"));
		self.frame.RestXP:SetValue(GetXPExhaustion() + UnitXP("player"));
	end
	--Change XPBar color if currently rested
	self:UpdateColors();
end

--Called when rested xp ammount changes
function VerticalXP:UpdateRestXP()
	if not GetXPExhaustion() then
		self.frame.RestXP:Hide();
	else
		if not self.frame.RestXP:IsShown() then
			self.frame.RestXP:Show()
		end
		self.frame.RestXP:SetMinMaxValues(0, UnitXPMax("player"));
		self.frame.RestXP:SetValue(GetXPExhaustion() + UnitXP("player"));
	end
	self:UpdateColors();
end

--Reset the Max and Min values after a level up
function VerticalXP:UpdateLevelUp()
	self.frame.XPBar:SetMinMaxValues(0, UnitXPMax("player"));
	self.frame.RestXP:SetMinMaxValues(0, UnitXPMax("player"));
end

--Display the config window on /vxp
function VerticalXP:HandleSlashCommand(input)
	LibStub("AceConfigDialog-3.0"):Open("VerticalXP");
end

---------------------------
--Tooltip scripts
function VerticalXP:MouseEnter()
	local tooltip = LibQTip:Acquire("VerticalXPToolTip", 5, "LEFT", "RIGHT","LEFT","LEFT", "LEFT");
	local mult = 10^(1); -- 10^(x) x=Number of desimal places to round to
	local percentOfLevel = math.floor((UnitXP("player") / UnitXPMax("player") * 100) * mult + 0.5) / mult;
	local toLevel = UnitXPMax("player") - UnitXP("player");
	self.tooltip = tooltip
	tooltip:AddHeader('Experience', 'Values', nil, nil, nil);
	tooltip:AddLine('Total XP:', UnitXP("player"), '/', UnitXPMax("player"));
	tooltip:AddLine('XP to level:', toLevel, nil, percentOfLevel, '%');
	
	if GetXPExhaustion() then
	local restPercent = math.floor((GetXPExhaustion() / UnitXPMax("player") * 100) * mult + 0.5) / mult;
	tooltip:AddLine('Rest XP:', GetXPExhaustion(), nil, restPercent, '%');
	end
	
	tooltip:SmartAnchorTo(self);
	tooltip:Show();
end

function VerticalXP:MouseLeave()
	LibQTip:Release(self.tooltip);
	self.tooltip = nil;
end