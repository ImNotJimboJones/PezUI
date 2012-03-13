-----------------------------------------
--             VerticalRep             --  
--         Created by: Ifandbut        --
-----------------------------------------
--Uses Ace3 and AceGUI-3.0-SharedMediaWidgets
--Extra textures taken from SharedMedia

--Version History
	--V 1.0 11/12/2010
		--Initial Release

VerticalRep = LibStub("AceAddon-3.0"):NewAddon("VerticalRep", "AceConsole-3.0", "AceEvent-3.0")

local versionText = "Version 1.0 ()" --Version information to be displayed in the config menu
local self = VerticalRep
local rotate_90 = math.pi / 2
local currentRep, reltiveMaxRep, repName, repLevel
local cRepColor = {r = 0, g = 0, b = 0, a = 0}


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
		ExaltedColor = { r = 0, g = 1, b = 1, a = 1},
		ReveredColor = { r = 0, g = 1, b = 204/255, a = 1},
		HonoredColor = { r = 0, g = 1, b = 136/255, a = 1},
		FriendlyColor = { r = 0, g = 1, b = 0, a = 1},
		NeturalColor = { r = 1, g = 1, b = 0, a = 1},
		UnfriendlyColor = { r = 238/255, g = 102/255, b = 34/255, a = 1},
		HostileColor = { r = 1, g = 0, b = 0, a = 1},
		HatedColor = { r = 204/255, g = 34/255, b = 34/255, a = 1},
		positionX = 400, --offset from left of screen to left of frame
		positionY = 300, --offset from bottom of screen to bottom of frame
		barTexture = "Blizzard",
		borderTexture = "Blizzard Dialog",
		backgroundTexture = "Blizzard Dialog Background"
	},
	char = {
		LastWatchedFaction = nil
	}
}

--Options Table
function VerticalRep_Options(uiTypes, uiName, appName)
	local options = {
		type = "group",
		name = "Vertical Reputation Bar Options",
		args = {
			version = {
				name = versionText,
				type = "header",
				order = 0,
				width = "full"
			},
			enable = {
				name = "Enable",
				desc = "Enable Vertical Rep Bar. Warning: If you spam this you will crash",
				type = "toggle",
				order = 100,
				width = "full",
				set = function(info, value)
					self.db.profile.enabled = value;
					self:ToggleRepBar();
				end,
				get = function(info) return self.db.profile.enabled end
			},
			locked = {
				name = "Locked",
				desc = "Disable to drag the Rep bar",
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
				desc = "Turn Rep bubbles on and off",
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
				desc = "Adjust the height of the Rep bar",
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
				desc = "Adjust the width of the Rep bar",
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
			exaltedColor = {
				name = "Exalted",
				desc = "Color of the reputation when Exalted",
				type = "color",
				order = 1000,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.ExaltedColor.r, self.db.profile.ExaltedColor.g, self.db.profile.ExaltedColor.b, self.db.profile.ExaltedColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.ExaltedColor.r, self.db.profile.ExaltedColor.g, self.db.profile.ExaltedColor.b, self.db.profile.ExaltedColor.a end
			},
			reveredColor = {
				name = "Revered",
				desc = "Color of the reputation when Revered",
				type = "color",
				order = 1010,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.ReveredColor.r, self.db.profile.ReveredColor.g, self.db.profile.ReveredColor.b, self.db.profile.ReveredColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.ReveredColor.r, self.db.profile.ReveredColor.g, self.db.profile.ReveredColor.b, self.db.profile.ReveredColor.a end
			},
			honoredColor = {
				name = "Honored",
				desc = "Color of the reputation when Honored",
				type = "color",
				order = 1020,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.HonoredColor.r, self.db.profile.HonoredColor.g, self.db.profile.HonoredColor.b, self.db.profile.HonoredColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.HonoredColor.r, self.db.profile.HonoredColor.g, self.db.profile.HonoredColor.b, self.db.profile.HonoredColor.a end
			},
			friendlyColor = {
				name = "Friendly",
				desc = "Color of the reputation when Friendly",
				type = "color",
				order = 1030,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.FriendlyColor.r, self.db.profile.FriendlyColor.g, self.db.profile.FriendlyColor.b, self.db.profile.FriendlyColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.FriendlyColor.r, self.db.profile.FriendlyColor.g, self.db.profile.FriendlyColor.b, self.db.profile.FriendlyColor.a end
			},
			neturalColor = {
				name = "Netural",
				desc = "Color of the reputation when Netural",
				type = "color",
				order = 1040,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.NeturalColor.r, self.db.profile.NeturalColor.g, self.db.profile.NeturalColor.b, self.db.profile.NeturalColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.NeturalColor.r, self.db.profile.NeturalColor.g, self.db.profile.NeturalColor.b, self.db.profile.NeturalColor.a end
			},
			unfriendlyColor = {
				name = "Unfriendly",
				desc = "Color of the reputation when Unfriendly",
				type = "color",
				order = 1050,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.UnfriendlyColor.r, self.db.profile.UnfriendlyColor.g, self.db.profile.UnfriendlyColor.b, self.db.profile.UnfriendlyColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.UnfriendlyColor.r, self.db.profile.UnfriendlyColor.g, self.db.profile.UnfriendlyColor.b, self.db.profile.UnfriendlyColor.a end
			},
			hostileColor = {
				name = "Hostile",
				desc = "Color of the reputation when Hostile",
				type = "color",
				order = 1060,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.HostileColor.r, self.db.profile.HostileColor.g, self.db.profile.HostileColor.b, self.db.profile.HostileColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.HostileColor.r, self.db.profile.HostileColor.g, self.db.profile.HostileColor.b, self.db.profile.HostileColor.a end
			},
			hatedColor = {
				name = "Hated",
				desc = "Color of the reputation when Hostile",
				type = "color",
				order = 1070,
				hasAlpha = true,
				set = function(info, r, g, b, a)
					self.db.profile.HatedColor.r, self.db.profile.HatedColor.g, self.db.profile.HatedColor.b, self.db.profile.HatedColor.a = r, g, b, a;
					self:UpdateColors();
				end,
				get = function(info) return self.db.profile.HatedColor.r, self.db.profile.HatedColor.g, self.db.profile.HatedColor.b, self.db.profile.HatedColor.a end
			},
			barTexture = {
				order = 600,
				width = "double",
				type = 'select',
				dialogControl = 'LSM30_Statusbar',
				name = 'Rep Bar Texture',
				desc = 'Select the texture of the Reputation bar.',
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
				name = 'Rep Border',
				desc = 'Select the border of the Reputation bar.',
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
function VerticalRep:OnInitialize()
	--Force the user to unlock the bar
	self.locked = true;
	--Register Chat command
	self:RegisterChatCommand("vrep", "HandleSlashCommand");
	--Setup Options 
	LibStub("AceConfig-3.0"):RegisterOptionsTable("VerticalRep", VerticalRep_Options);
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("VerticalRep", "Vertical Reputation");
	self.db = LibStub("AceDB-3.0"):New("VerticalRepDB", defaults, true);
end

--Runs when addon is enabled by user
function VerticalRep:OnEnable()
	self:CreateRepFrames();
	--Restores the last rep watched when changing characters
	if self.db.char.LastFactionWatched then
		SetWatchedFactionIndex(self.db.char.LastFactionWatched);
	end
	--Register rep update event
	self:RegisterEvent("UPDATE_FACTION", "UpdateRepBar");
	--Runthrough config options
	self:UpdateTexture(self.db.profile.barTexture);
	self:UpdateBaseFrame();
	self:UpdateClamp();
	self:UpdateBubbles();
	self:UpdateBorder();
	self:UpdateWidth();
	self:UpdateHeight();
	self:ToggleRepBar();
	self:Print("VerticalRep Enabled");
end

--Runs when addon is disabled by user
function VerticalRep:OnDisable()
	--No clue what I should do here
end

--Render the frames
function VerticalRep:CreateRepFrames()

	--Background Frame
	self.frame = CreateFrame("Frame", "VerticalRepFrame", UIParent);
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
	
	--The actual Rep bar
	self.frame.RepBar = CreateFrame("StatusBar", "VerticalRepBar", VerticalRepFrame);
	self.frame.RepBar:SetScale(1);
	self.frame.RepBar:SetFrameLevel(3);
	self.frame.RepBar:ClearAllPoints();
	self.frame.RepBar:SetPoint("Center", VerticalRepFrame, "Center", 0, 0);
	self.frame.RepBar:SetOrientation("VERTICAL");
	
	--The Rep Bubbles
	self.frame.Bubbles = CreateFrame("StatusBar", "Bubbles", VerticalRepFrame);
	self.frame.Bubbles:SetScale(1);
	self.frame.Bubbles:SetFrameLevel(4);
	self.frame.Bubbles:ClearAllPoints();
	self.frame.Bubbles:SetPoint("Center", VerticalRepFrame, "Center", 0, 0);
	self.frame.Bubbles:SetOrientation("VERTICAL");
	self.frame.Bubbles:SetStatusBarTexture("Interface\\Addons\\VerticalXP\\textures\\Bubbles");
end


----------------------------
--Configuration Functions
----------------------------

--Clamp to screen
function VerticalRep:UpdateClamp()
	if self.db.profile.clamp then
		self.frame:SetClampedToScreen(true);
	else
		self.frame:SetClampedToScreen(false);
	end
end

--Bubbles
function VerticalRep:UpdateBubbles()
	if self.db.profile.bubbles then
		self.frame.Bubbles:Show();
	else
		self.frame.Bubbles:Hide();
	end
end

--Update the background and border textures
function VerticalRep:UpdateBaseFrame()
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
function VerticalRep:UpdateTexture(texture)
	local textureFile = LSM3:Fetch("statusbar", texture);
	self.frame.RepBar:SetStatusBarTexture(textureFile);
	self.frame.RepBar:GetStatusBarTexture():SetRotation(rotate_90);
end

--General color handler function
function VerticalRep:UpdateColors()
	local name, standing, rmin, rmax, value = GetWatchedFactionInfo();
	if standing == 1 then
		--Hated
		self.frame.RepBar:SetStatusBarColor(self.db.profile.HatedColor.r, self.db.profile.HatedColor.g, self.db.profile.HatedColor.b, self.db.profile.HatedColor.a);
		repLevel = "Hated"
		return
	end
	if standing == 2 then
		--Hostile
		self.frame.RepBar:SetStatusBarColor(self.db.profile.HostileColor.r, self.db.profile.HostileColor.g, self.db.profile.HostileColor.b, self.db.profile.HostileColor.a);
		repLevel = "Hostile"
		return
	end
	if standing == 3 then
		--Unfriendly
		self.frame.RepBar:SetStatusBarColor(self.db.profile.UnfriendlyColor.r, self.db.profile.UnfriendlyColor.g, self.db.profile.UnfriendlyColor.b, self.db.profile.UnfriendlyColor.a);
		repLevel = "Unfriendly"
		return
	end
	--When no rep is being watched the color defaults to the netural color
	if standing == (4 or 0) then
		--Netural
		self.frame.RepBar:SetStatusBarColor(self.db.profile.NeturalColor.r, self.db.profile.NeturalColor.g, self.db.profile.NeturalColor.b, self.db.profile.NeturalColor.a);
		repLevel = "Netural"
		return
	end
	if standing == 5 then
		--Friendly
		self.frame.RepBar:SetStatusBarColor(self.db.profile.FriendlyColor.r, self.db.profile.FriendlyColor.g, self.db.profile.FriendlyColor.b, self.db.profile.FriendlyColor.a);
		repLevel = "Friendly"
		return
	end
	if standing == 6 then
		--Honored
		self.frame.RepBar:SetStatusBarColor(self.db.profile.HonoredColor.r, self.db.profile.HonoredColor.g, self.db.profile.HonoredColor.b, self.db.profile.HonoredColor.a);
		repLevel = "Honored"
		return
	end
	if standing == 7 then
		--Revered
		self.frame.RepBar:SetStatusBarColor(self.db.profile.ReveredColor.r, self.db.profile.ReveredColor.g, self.db.profile.ReveredColor.b, self.db.profile.ReveredColor.a);
		repLevel = "Revered"
		return
	end
	if standing == 8 then
		--Exalted
		self.frame.RepBar:SetStatusBarColor(self.db.profile.ExaltedColor.r, self.db.profile.ExaltedColor.g, self.db.profile.ExaltedColor.b, self.db.profile.ExaltedColor.a);
		repLevel = "Exalted"
		return
	end
end

--Includes code to hide Blizzard Reputation bar
function VerticalRep:ToggleRepBar()
	if self.db.profile.enabled then
		self.frame:Show();
		ReputationWatchBar:HookScript("OnEvent", function(self) self:Hide() end)
		ReputationWatchBar:HookScript("OnShow", function(self) self:Hide() end)
		ReputationWatchBar:Hide()
	else
		self.frame:Hide();
		ReputationWatchBar:HookScript("OnEvent", function(self) self:Show() end)
		ReputationWatchBar:HookScript("OnShow", function(self) self:Show() end)
		ReputationWatchBar:Show()
	end
end

--Called from config
function VerticalRep:UpdateBorder()
	if self.db.profile.border then
		self.frame:SetBackdropBorderColor(1, 1, 1, 1);
	else
		self.frame:SetBackdropBorderColor(1, 1, 1, 0);
	end
end
	
--Height resize function, called from config	
function VerticalRep:UpdateHeight()
	self.frame:SetHeight(self.db.profile.height);
	self.frame.RepBar:SetHeight(self.db.profile.height - 8);
	self.frame.Bubbles:SetHeight(self.db.profile.height - 8);
	self.frame.RepBar:SetValue(0);
	self:UpdateRepBar();
end

--Width Resize function, called from config
function VerticalRep:UpdateWidth()
	self.frame:SetWidth(self.db.profile.width);
	self.frame.RepBar:SetWidth(self.db.profile.width - 10);
	self.frame.Bubbles:SetWidth(self.db.profile.width - 10);
end

----------------------------------------------------
--Events Section
----------------------------------------------------

--General Update when Rep changes 
function VerticalRep:UpdateRepBar()
	local name, standing, repMin, repMax, value = GetWatchedFactionInfo();
	currentRep = value - repMin;
	reltiveMaxRep = repMax - repMin;
	repName = name;
	self.frame.RepBar:SetMinMaxValues(0, reltiveMaxRep);
	self.frame.RepBar:SetValue(currentRep);
	--Change RepBar color for current rep level
	self:UpdateColors();
	cRepColor.r, cRepColor.g, cRepColor.b, cRepColor.a = self.frame.RepBar:GetStatusBarColor();
end

--Display the config window on /vxp
function VerticalRep:HandleSlashCommand(input)
	LibStub("AceConfigDialog-3.0"):Open("VerticalRep");
end

---------------------------
--Tooltip scripts
function VerticalRep:MouseEnter()
	local tooltip = LibQTip:Acquire("VerticalRepToolTip", 5, "LEFT", "RIGHT","LEFT","LEFT", "LEFT");
	local mult = 10^(1); -- 10^(x) x=Number of desimal places to round to
	local percentOfRep = math.floor((currentRep / reltiveMaxRep * 100) * mult + 0.5) / mult;
	local toRep = reltiveMaxRep - currentRep;
	self.tooltip = tooltip;
	tooltip:AddHeader('Reputation', nil, nil, nil, nil);
	tooltip:AddLine(repName);
	tooltip:AddLine(repLevel);
	tooltip:AddSeparator(2, cRepColor.r, cRepColor.g, cRepColor.b);
	tooltip:AddLine('Total Rep:', currentRep, '/', reltiveMaxRep);
	tooltip:AddLine('Rep to next tier:', toRep, nil, percentOfRep, '%');
	
	tooltip:SmartAnchorTo(self);
	tooltip:Show();
end

function VerticalRep:MouseLeave()
	LibQTip:Release(self.tooltip);
	self.tooltip = nil;
end