local MovAny = _G.MovAny
local MOVANY = _G.MOVANY
local _G = _G
local _ = _

local genericFunctions
genericFunctions = {
	OnMAScaleChildren = function(self, scale)
		if type(scale) ~= "number" then
			return
		end
		if self.attachedChildren then
			for i, child in pairs(self.attachedChildren) do
				child:SetScale(scale)
			end
		end
	end,
	OnMAResetChildrenScale = function(self, readOnly)
		if not readOnly and self.opt.scale and self.opt.scale ~= 1 then
			genericFunctions.OnMAScaleChildren(self, 1)
		end
	end,
}

MovAny.lVirtualMovers = {
	UIPanelMover1 = {
		w = 384,
		h = 512,
		point = {"TOPLEFT", "UIParent", "TOPLEFT", 0, -104},
		OnMAAttach = MovAny.SyncUIPanels,
		OnMAPosition = MovAny.SyncUIPanels,
		OnMAAlpha = MovAny.SyncUIPanels,
		OnMAScale = MovAny.SyncUIPanels,
	},
	UIPanelMover2 = {
		w = 384,
		h = 512,
		point = {"TOPLEFT", "UIParent", "TOPLEFT", 384, -104},
		OnMAAttach = MovAny.SyncUIPanels,
		OnMAPosition = MovAny.SyncUIPanels,
		OnMAAlpha = MovAny.SyncUIPanels,
		OnMAScale = MovAny.SyncUIPanels,
	},
	UIPanelMover3 = {
		w = 384,
		h = 512,
		point = {"TOPLEFT", "UIParent", "TOPLEFT", 772, -104},
		OnMAAttach = MovAny.SyncUIPanels,
		OnMAPosition = MovAny.SyncUIPanels,
		OnMAAlpha = MovAny.SyncUIPanels,
		OnMAScale = MovAny.SyncUIPanels,
	},
	TooltipMover = {
		frameStrata = "TOOLTIP",
		w = 150,
		h = 80,
		point = {"TOP", "UIParent", 0, 0},
		OnShow = function()
			self:SetFrameLevel(GameTooltip:GetFrameLevel() + 1)
		end,
		--[[
		OnMAPostHook = function(self)
			--MovAny:HookTooltip(self)
		end,
		OnMAPosition = function(self)
			--MovAny:HookTooltip(self)
		end,
		]]
		OnMAPreReset = function(self)
			local f = _G.GameTooltip
			self.MAE:Reset(f, true)
			f.MAHidden = nil
		end,
	},
	BagItemTooltipMover = {
		frameStrata = "TOOLTIP",
		w = 150,
		h = 80,
		point = {"TOP", "UIParent", 0, 0},
		OnLoad = function(self)
			self:SetFrameLevel(GameTooltip:GetFrameLevel() + 1)
		end,
		OnMAPreReset = function(self)
			local f = _G.GameTooltip
			self.MAE:Reset(f, true)
			f.MAHidden = nil
		end
	},
	BagButtonsMover = {
		w = 196,
		h = 44,
		relPoint = {"BOTTOMRIGHT", "MainMenuBarArtFrame", "BOTTOMRIGHT", -6, -2},
		excludes = "BagButtonsVerticalMover",
		children = {
			"MainMenuBarBackpackButton",
			"CharacterBag0Slot",
			"CharacterBag1Slot",
			"CharacterBag2Slot",
			"CharacterBag3Slot",
		},
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("RIGHT", self, "RIGHT", 0, 0)
			else
				child:SetPoint("RIGHT", self.lastChild, "LEFT", -4, 0)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("BOTTOMRIGHT", "MainMenuBarArtFrame", "BOTTOMRIGHT", -6, -2)
			else
				child:SetPoint("RIGHT", self.lastChild, "LEFT", -4, 0)
			end
		end,
	},
	BagButtonsVerticalMover = {
		w = 44,
		h = 173,
		relPoint = {"BOTTOMRIGHT", "MainMenuBarArtFrame", "BOTTOMRIGHT", -6, -2},
		excludes = "BagButtonsMover",
		notMAParent = true,
		children = {
			"MainMenuBarBackpackButton",
			"CharacterBag0Slot",
			"CharacterBag1Slot",
			"CharacterBag2Slot",
			"CharacterBag3Slot",
		},
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("BOTTOM", self, "BOTTOM", 0, 0)
			else
				child:SetPoint("BOTTOM", self.lastChild, "TOP", 0, 3)
			end
			child.MAParent = self
		end,
		OnMAReleaseChild = function(self, index, child)
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("BOTTOMRIGHT", "MainMenuBarArtFrame", "BOTTOMRIGHT", -6, -2)
			else
				child:SetPoint("RIGHT", self.lastChild, "LEFT", -4, 0)
			end
			child.MAParent = "BagButtonsMover"
		end,
	},
	BagFrame1 = {
		inherits = "MovableBagFrame",
		id = 0,
	},
	BagFrame2 = {
		inherits = "MovableBagFrame",
		id = 1,
	},
	BagFrame3 = {
		inherits = "MovableBagFrame",
		id = 2,
	},
	BagFrame4 = {
		inherits = "MovableBagFrame",
		id = 3,
	},
	BagFrame5 = {
		inherits = "MovableBagFrame",
		id = 4,
	},
	BankBagFrame1 = {
		inherits = "MovableBagFrame",
		id = 5,
	},
	BankBagFrame2 = {
		inherits = "MovableBagFrame",
		id = 6,
	},
	BankBagFrame3 = {
		inherits = "MovableBagFrame",
		id = 7,
	},
	BankBagFrame4 = {
		inherits = "MovableBagFrame",
		id = 8,
	},
	BankBagFrame5 = {
		inherits = "MovableBagFrame",
		id = 9,
	},
	BankBagFrame6 = {
		inherits = "MovableBagFrame",
		id = 10,
	},
	BankBagFrame7 = {
		inherits = "MovableBagFrame",
		id = 11,
	},
	KeyRingFrame = {
		inherits = "MovableBagFrame",
		id = -2,
	},
	MicroButtonsMover = {
		w = 303,
		h = 37,
		relPoint = {"BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 549, 2},
		excludes = "MicroButtonsVerticalMover",
	--	excludes2 = "MicroButtonsVehicleMover",
		children = {
			"CharacterMicroButton", 
			"SpellbookMicroButton",
			"TalentMicroButton", 
			"AchievementMicroButton", 
			"QuestLogMicroButton",
			"GuildMicroButton", 
			"PVPMicroButton", 
			"LFDMicroButton",
			"CompanionsMicroButton",
			"EJMicroButton", 
			"MainMenuMicroButton", 
			"HelpMicroButton"},
		OnMAFoundChild = function(self, index, child)
			if child == self.firstChild then
				child:ClearAllPoints()
				child:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if child == self.firstChild then
				child:SetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 546, 2)
			else
				child:SetPoint("BOTTOMLEFT", self.lastChild, "BOTTOMRIGHT", -2, 0)
			end
		end,
		OnMAScale = genericFunctions.OnMAScaleChildren,
		OnMAPreReset = genericFunctions.OnMAResetChildrenScale,
	},
--[[	MicroButtonsVehicleMover = {
		w = 166,
		h = 75,
		relPoint = {"BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 635, 150},
		excludes = "MicroButtonsVerticalMover",
	--	excludes2 = "MicroButtonsMover",
		children = {
			"CharacterMicroButton", 
			"SpellbookMicroButton",
			"TalentMicroButton", 
			"AchievementMicroButton", 
			"QuestLogMicroButton",
			"GuildMicroButton", 
			"PVPMicroButton", 
			"LFDMicroButton",
			"CompanionsMicroButton",
			"EJMicroButton", 
			"MainMenuMicroButton", 
			"HelpMicroButton",
			},
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if child == self.firstChild then
				macount = 1
				print("if",child:GetName(), macount)
				child:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 24)
			else
				macount = macount+1
				print("else",child:GetName(), macount)
				if macount > 1 and macount < 7 then
					child:SetPoint("BOTTOMLEFT", self.lastChild, "BOTTOMLEFT", 24, 0)
				elseif macount == 7 then 
					child:SetPoint("BOTTOMLEFT", self.lastChild, "BOTTOMLEFT", -120, -36)
				elseif macount > 7 and macount < 13 then
					child:SetPoint("BOTTOMLEFT", self.lastChild, "BOTTOMLEFT", 24, 0)
				end
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if child == self.firstChild then
				child:ClearAllPoints()
				child:SetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 548, 2)
			end
		end,
		OnMAScale = genericFunctions.OnMAScaleChildren,
		OnMAPreReset = genericFunctions.OnMAResetChildrenScale,
	},]]
	MicroButtonsVerticalMover = {
		w = 28,
		h = 405,
		relPoint = {"BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 546, 2},
		excludes = "MicroButtonsMover",
	--	excludes2 = "MicroButtonsVehicleMover",
		notMAParent = true,
		children = {"CharacterMicroButton", 
			"SpellbookMicroButton",
			"TalentMicroButton", 
			"AchievementMicroButton", 
			"QuestLogMicroButton",
			"GuildMicroButton",
			"PVPMicroButton", 
			"LFDMicroButton",
			"CompanionsMicroButton",
			"EJMicroButton",
			"MainMenuMicroButton", 
			"HelpMicroButton"},
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 24)
			else
				child:SetPoint("TOPLEFT", self.lastChild, "BOTTOMLEFT", 0, 24)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			child.MAParent = "MicroButtonsMover"
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 546, 2)
			else
				child:SetPoint("BOTTOMLEFT", self.lastChild, "BOTTOMRIGHT", -2, 0)
			end
		end,
		OnMAScale = genericFunctions.OnMAScaleChildren,
		OnMAPreReset = genericFunctions.OnMAResetChildrenScale,
	},
	BasicActionButtonsMover = {
		w = 498,
		h = 38,
		relPoint = {"BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 8, 3},
		protected = true,
		excludes = "BasicActionButtonsVerticalMover",
		prefix = "ActionButton",
		count = 12,
	--	prefix1 = "ActionButton",
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if prefix == nil then
			--	print("test:"..tostring(child:GetName()).." "..tostring(prefix).." "..tostring(self))
				if not self.lastChild then
					child:SetPoint("LEFT", self, "LEFT")
				else
					child:SetPoint("LEFT", self.lastChild, "RIGHT", 6, 0)
				end
			else
			--	print("test:"..tostring(child:GetName()).." "..tostring(prefix).." "..tostring(self))
			--	table.foreach(self, print)
				child:SetPoint("CENTER", self.prefix..index, "CENTER")
			end
		end,
		OnMAReleaseChild = function(self, index, child, prefix)
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 546, 2)
			else
				child:SetPoint("BOTTOMLEFT", prefix, "BOTTOMRIGHT", -2, 0)
			end
		end,
		OnMAHook = function(self)
			local b, bab
			ActionButton1:ClearAllPoints()
			if ActionButton1.MASetPoint then
				ActionButton1:MASetPoint("LEFT", self, "LEFT")
			else
				ActionButton1:SetPoint("LEFT", self, "LEFT")
			end
			ActionBarUpButton:ClearAllPoints()
			ActionBarUpButton:SetPoint("TOPLEFT", "ActionButton12", "TOPRIGHT", 0, 7)
			ActionBarDownButton:ClearAllPoints()
			ActionBarDownButton:SetPoint("BOTTOMLEFT", "ActionButton12", "BOTTOMRIGHT", 0, -9)
			for i = 1, 12, 1 do
				b = _G["ActionButton"..i]
				if i > 1 then
					b:ClearAllPoints()
					b:SetPoint("LEFT", "ActionButton"..(i-1), "RIGHT", 6, 0)
				end
				b.MAParent = self
				tinsert(self.attachedChildren, b)
			end
			if not MovAny:IsModified("ActionBarUpButton") then
				tinsert(self.attachedChildren, ActionBarUpButton)
			end
			if not MovAny:IsModified("ActionBarDownButton") then
				tinsert(self.attachedChildren, ActionBarDownButton)
			end
			MovAny:LockPoint(ActionButton1)
		end,
		OnMAPostReset = function(self)
			MovAny:UnlockPoint(ActionButton1)
			local b = _G["ActionButton1"]
			b:ClearAllPoints()
			if b.MASetPoint then
				b:MASetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 8, 4)
			else
				b:SetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 8, 4)
			end
			ActionBarUpButton:ClearAllPoints()
			ActionBarUpButton:SetPoint("CENTER", "MainMenuBarArtFrame", "TOPLEFT", 522, -22)
			ActionBarDownButton:ClearAllPoints()
			ActionBarDownButton:SetPoint("CENTER", "MainMenuBarArtFrame", "TOPLEFT", 522, -42)
			for i = 2, 12, 1 do
				b = _G[ "ActionButton"..i ]
				b:ClearAllPoints()
				b:SetPoint("LEFT", "ActionButton"..(i-1), "RIGHT", 6, 0)
			end
		end,
	},
	
	OverrideActionButtonsMover = {
		w = 340,
		h = 54,
		relPoint = {"BOTTOM", "OverrideActionBar", "BOTTOM", -128, 17},
		protected = true,
		prefix = "OverrideActionBarButton",
		count = 6,
	--	prefix1 = "ActionButton",
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if prefix == nil then
			--	print("test:"..tostring(child:GetName()).." "..tostring(prefix).." "..tostring(self))
				if not self.lastChild then
					child:SetPoint("LEFT", self, "LEFT")
				else
					child:SetPoint("LEFT", self.lastChild, "RIGHT", 6, 0)
				end
			else
			--	print("test:"..tostring(child:GetName()).." "..tostring(prefix).." "..tostring(self))
			--	table.foreach(self, print)
				child:SetPoint("CENTER", self.prefix..index, "CENTER")
			end
		end,
		OnMAReleaseChild = function(self, index, child, prefix)
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("BOTTOMLEFT", "OverrideActionBar", "BOTTOMLEFT", 546, 2)
			else
				child:SetPoint("BOTTOMLEFT", prefix, "BOTTOMRIGHT", -2, 0)
			end
		end,
		OnMAHook = function(self)
			local b, bab
			OverrideActionBarButton1:ClearAllPoints()
			if OverrideActionBarButton1.MASetPoint then
				OverrideActionBarButton1:MASetPoint("LEFT", self, "LEFT")
			else
				OverrideActionBarButton1:SetPoint("LEFT", self, "LEFT")
			end
			for i = 1, 6, 1 do
				b = _G["OverrideActionBarButton"..i]
				if i > 1 then
					b:ClearAllPoints()
					b:SetPoint("LEFT", "OverrideActionBarButton"..(i-1), "RIGHT", 7, 0)
				end
				b.MAParent = self
			end
			MovAny:LockPoint(OverrideActionBarButton1)
		end,
		OnMAPostReset = function(self)
			MovAny:UnlockPoint(OverrideActionBarButton1)
			local b = OverrideActionBarButton1
			b:ClearAllPoints()
			if b.MASetPoint then
				b:MASetPoint("BOTTOM", "OverrideActionBar", "BOTTOM", 277, 17)
			else
				b:SetPoint("BOTTOM", "OverrideActionBar", "BOTTOM", -277, 17)
			end
			for i = 2, 6, 1 do
				b = _G[ "OverrideActionBarButton"..i ]
				b:ClearAllPoints()
				b:SetPoint("LEFT", "OverrideActionBarButton"..(i-1), "RIGHT", 6, 0)
			end
		end,
	},
	
	BasicActionButtonsVerticalMover = {
		w = 38,
		h = 475,
		relPoint = {"BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 8, 4},
		protected = true,
		excludes = "BasicActionButtonsMover",
		OnMAHook = function(self)
			local b
			b = _G["ActionButton1"]
			b:ClearAllPoints()
			if b.MASetPoint then
				b:MASetPoint("TOP", self, "TOP")
			else
				b:SetPoint("TOP", self, "TOP")
			end
			for i = 1, 12, 1 do
				b = _G[ "ActionButton"..i ]
				tinsert(self.attachedChildren, _G[ "ActionButton"..i ])
				if i > 1 then
					b:ClearAllPoints()
					b:SetPoint("TOP", "ActionButton"..(i-1), "BOTTOM", 0, -2)
				end
				b.MAParent = self
			end
			tinsert(self.attachedChildren, ActionBarUpButton)
			tinsert(self.attachedChildren, ActionBarDownButton)
			ActionBarUpButton:ClearAllPoints()
			ActionBarUpButton:SetPoint("TOPLEFT", "ActionButton12", "BOTTOMLEFT", -8, 4)
			ActionBarDownButton:ClearAllPoints()
			ActionBarDownButton:SetPoint("TOPRIGHT", "ActionButton12", "BOTTOMRIGHT", 8, 4)
		end,
		OnMAPostReset = function(self)
			local b
			b = _G["ActionButton1"]
			b:ClearAllPoints()
			if b.MASetPoint then
				b:MASetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 8, 4)
			else
				b:SetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 8, 4)
			end
			ActionBarUpButton:ClearAllPoints()
			ActionBarUpButton:SetPoint("CENTER", "MainMenuBarArtFrame", "TOPLEFT", 522, -22)
			ActionBarDownButton:ClearAllPoints()
			ActionBarDownButton:SetPoint("CENTER", "MainMenuBarArtFrame", "TOPLEFT", 522, -42)
			for i = 2, 12, 1 do
				b = _G[ "ActionButton"..i ]
				b.MAParent = BasicActionButtonsMover
				b:ClearAllPoints()
				b:SetPoint("LEFT", "ActionButton"..(i-1), "RIGHT", 6, 0)
			end
		end,
	},
	PetActionButtonsMover = {
		w = 375,
		h = 36,
		point = {"BOTTOMLEFT", "PetActionBarFrame", "BOTTOMLEFT", 8, 2},
		excludes = "PetActionButtonsVerticalMover",
		protected = true,
		prefix = "PetActionButton",
		count = 10,
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("LEFT", self, "LEFT", 0, 0)
			else
				child:SetPoint("LEFT", self.lastChild, "RIGHT", 8, 0)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("BOTTOMLEFT", "PetActionBarFrame", "BOTTOMLEFT", 8, 2)
			else
				child:SetPoint("LEFT", self.lastChild, "RIGHT", 8, 0)
			end
		end,
	},
	PetActionButtonsVerticalMover = {
		w = 36,
		h = 375,
		point = {"BOTTOMLEFT", "PetActionBarFrame", "BOTTOMLEFT", 36, 1},
		excludes = "PetActionButtonsMover",
		notMAParent = true,
		protected = true,
		prefix = "PetActionButton",
		count = 10,
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			child.MAParent = self
			if index == 1 then
				child:SetPoint("TOP", self, "TOP", 0, 0)
			else
				child:SetPoint("TOP", self.lastChild, "BOTTOM", 0, -8)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			child:ClearAllPoints()
			child.MAParent = "PetActionButtonsMover"
			if index == 1 then
				child:SetPoint("BOTTOMLEFT", "PetActionBarFrame", "BOTTOMLEFT", 36, 1)
			else
				child:SetPoint("LEFT", self.lastChild, "RIGHT", 8, 0)
			end
		end,
	},
	ExtraActionBarFrameMover = {
		w = 52,
		h = 52,
		point = {"BOTTOM", "MainMenuBar", 0, 160},
		protected = true,
		dontLock = true,
		prefix = "ExtraActionButton",
		count = 1,
		OnMAHook = function(self)
			local b = _G.ExtraActionBarFrame
			b:DisableDrawLayer("BACKGROUND")
			b:DisableDrawLayer("BORDER")
			MovAny:UnlockPoint(b)
			b:ClearAllPoints()
			b:SetPoint("BOTTOMLEFT", ExtraActionBarFrameMover, "BOTTOMLEFT", 0, 0)
			MovAny:LockPoint(b)
			b.ignoreFramePositionManager = true
			b:SetMovable(true)
			b:SetUserPlaced(true)
			self.sbf = b
		end,
		OnMAPreReset = function(self)
			local b = self.sbf
			MovAny:UnlockPoint(b)
			b:SetPoint("BOTTOM", _G.MainMenuBar, 0, 160)
			b:EnableDrawLayer("BACKGROUND")
			b:EnableDrawLayer("BORDER")
			b.ignoreFramePositionManager = nil
			b:SetUserPlaced(nil)
			b:SetMovable(nil)
		end,
		OnMAHide = function(self, hidden)
			if hidden then
				MovAny:LockVisibility(self.sbf)
			else
				MovAny:UnlockVisibility(self.sbf)
			end
		end,
	},
	StanceButtonsMover = {
		w = 225,
		h = 37,
		point = {"BOTTOMLEFT", "MainMenuBar", "TOPLEFT", 45, 30},
		excludes = "StanceButtonsVerticalMover",
		protected = true,
		prefix = "StanceButton",
		count = 10,
	--	dontLock = true,
		OnMAHook = function(self)
			local b = _G.StanceBarFrame
			b:DisableDrawLayer("BACKGROUND")
			b:DisableDrawLayer("BORDER")
			MovAny:UnlockPoint(b)
			b:ClearAllPoints()
			b:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
			MovAny:LockPoint(b)
			b.ignoreFramePositionManager = true
			b:SetMovable(true)
			b:SetUserPlaced(true)
			self.sbf = b
		end,
		OnMAPreReset = function(self)
			local b = self.sbf
			MovAny:UnlockPoint(b)
			b:SetPoint("BOTTOMLEFT", _G.MainMenuBar, "TOPLEFT", 45, 30)
			b:EnableDrawLayer("BACKGROUND")
			b:EnableDrawLayer("BORDER")
			b.ignoreFramePositionManager = nil
			b:SetUserPlaced(nil)
			b:SetMovable(nil)
		end,
		OnMAHide = function(self, hidden)
			if hidden then
				MovAny:LockVisibility(self.sbf)
				RegisterStateDriver(StanceBarFrame, "visibility", "hide");
			else
				MovAny:UnlockVisibility(self.sbf)
				RegisterStateDriver(StanceBarFrame, "visibility", "show");
			end
		end,
	},
	StanceButtonsVerticalMover = {
		w = 32,
		h = 225,
		point = {"BOTTOMLEFT", "MainMenuBar", "TOPLEFT", 45, 30},
		excludes = "StanceButtonsMover",
	--	notMAParent = true,
		protected = true,
		prefix = "StanceButton",
		count = 10,
		OnMAHook = function(self)
			local b = _G.StanceBarFrame
			b:DisableDrawLayer("BACKGROUND")
			b:DisableDrawLayer("BORDER")
			b.ignoreFramePositionManager = true
			b:SetMovable(true)
			b:SetUserPlaced(true)
			self.sbf = b
		end,
		OnMAPostReset = function(self)
			local b = self.sbf
			b:EnableDrawLayer("BACKGROUND")
			b:EnableDrawLayer("BORDER")
			b.ignoreFramePositionManager = nil
			if self.sbf:IsUserPlaced() then
				self.sbf:SetUserPlaced(nil)
			end
			if self.sbf:IsMovable() then
				self.sbf:SetMovable(nil)
			end
		end,
		OnMAFoundChild = function(self, index, child)
			child.MAParent = self
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("TOP", self, "TOP", 0, -7)
			else
				child:SetPoint("TOP", self.lastChild, "BOTTOM", 0, -7)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			child.MAParent = "StanceButtonsMover"
			child:ClearAllPoints()
			if child == self.firstChild then
				child:SetPoint("BOTTOMLEFT", self.sbf, "BOTTOMLEFT", 11, 3)
			else
				child:SetPoint("LEFT", self.lastChild, "RIGHT", 8, 0)
			end
		end,
		OnMAHide = function(self, hidden)
			if hidden then
				MovAny:LockVisibility(self.sbf)
				RegisterStateDriver(StanceBarFrame, "visibility", "hide");
			else
				MovAny:UnlockVisibility(self.sbf)
				RegisterStateDriver(StanceBarFrame, "visibility", "show");
			end
		end,
	},
	MultiBarRightMover = {
		w = 38,
		h = 498,
		point = {"BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", 0, 98},
		excludes = "MultiBarRightHorizontalMover",
	--	notMAParent = true,
		protected = true,
		prefix = "MultiBarRightButton",
		count = 12,
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("TOPLEFT", self)
			else
				child:SetPoint("TOPLEFT", self.lastChild, "TOPLEFT", 0, -42)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("TOPRIGHT", "MultiBarRight")
			else
				child:SetPoint("TOP", self.lastChild, "BOTTOM", 0, -6)
			end
			child.MAParent = nil
		end,
	--[[	OnMAHide = function(self, hidden)
			if hidden then
				MovAny:LockVisibility(self)
				RegisterStateDriver(MultiBarRightMover, "visibility", "hide");
			else
				MovAny:UnlockVisibility(self)
				RegisterStateDriver(MultiBarRightMover, "visibility", "show");
			end
		end]]
	},
	MultiBarRightHorizontalMover = {
		w = 498,
		h = 38,
		point = {"BOTTOM", "UIParent", "BOTTOM", 0, 250},
		excludes = "MultiBarRightMover",
	--	notMAParent = true,
		protected = true,
		prefix = "MultiBarRightButton",
		count = 12,
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("TOPLEFT", self)
			else
				child:SetPoint("LEFT", self.lastChild, "RIGHT", 6, 0)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("TOPRIGHT", "MultiBarRight")
			else
				child:SetPoint("TOP", self.lastChild, "BOTTOM", 0, -6)
			end
			child.MAParent = nil
		end,
	--[[	OnMAHide = function(self, hidden)
			if hidden then
				MovAny:LockVisibility(self)
				RegisterStateDriver(MultiBarRightHorizontalMover, "visibility", "hide");
			else
				MovAny:UnlockVisibility(self)
				RegisterStateDriver(MultiBarRightHorizontalMover, "visibility", "show");
			end
		end]]
	},
	MultiBarLeftMover = {
		w = 38,
		h = 498,
		point = {"BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -38, 98},
		excludes = "MultiBarLeftHorizontalMover",
	--	notMAParent = true,
		protected = true,
		prefix = "MultiBarLeftButton",
		count = 12,
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("TOPLEFT", self)
			else
				child:SetPoint("TOPLEFT", self.lastChild, "TOPLEFT", 0, -42)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("TOPRIGHT", "MultiBarLeft")
			else
				child:SetPoint("TOP", self.lastChild, "BOTTOM", 0, -6)
			end
			child.MAParent = nil
		end,
	--[[	OnMAHide = function(self, hidden)
			if hidden then
				MovAny:LockVisibility(self)
				RegisterStateDriver(MultiBarLeftMover, "visibility", "hide");
			else
				MovAny:UnlockVisibility(self)
				RegisterStateDriver(MultiBarLeftMover, "visibility", "show");
			end
		end]]
	},
	MultiBarLeftHorizontalMover = {
		w = 498,
		h = 38,
		point = {"BOTTOM", "UIParent", "BOTTOM", 0, 285},
		excludes = "MultiBarLeftMover",
	--	notMAParent = true,
		protected = true,
		prefix = "MultiBarLeftButton",
		count = 12,
		OnMAFoundChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("TOPLEFT", self)
			else
				child:SetPoint("LEFT", self.lastChild, "RIGHT", 6, 0)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			child:ClearAllPoints()
			if index == 1 then
				child:SetPoint("TOPRIGHT", "MultiBarLeft")
			else
				child:SetPoint("TOP", self.lastChild, "BOTTOM", 0, -6)
			end
			child.MAParent = nil
		end,
	--[[	OnMAHide = function(self, hidden)
			if hidden then
				MovAny:LockVisibility(self)
				RegisterStateDriver(MultiBarLeftHorizontalMover, "visibility", "hide");
			else
				MovAny:UnlockVisibility(self)
				RegisterStateDriver(MultiBarLeftHorizontalMover, "visibility", "show");
			end
		end]]
	},
	PartyMember1DebuffsMover = {
		w = 66,
		h = 15,
		point = {"TOPLEFT", "PartyMemberFrame1", "TOPLEFT", 48, -32},
		prefix = "PartyMemberFrame1Debuff",
		count = MAX_PARTY_DEBUFFS,
		dontLock = true,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self)
				MovAny:LockPoint(child)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				MovAny:UnlockPoint(child)
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", "PartyMemberFrame1", 48, -32)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["PartyMemberFrame1"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	PartyMember2DebuffsMover = {
		w = 66,
		h = 15,
		point = {"TOPLEFT", "PartyMemberFrame2", "TOPLEFT", 48, -32},
		prefix = "PartyMemberFrame2Debuff",
		count = MAX_PARTY_DEBUFFS,
		dontLock = true,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self)
				MovAny:LockPoint(child)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				MovAny:UnlockPoint(child)
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", "PartyMemberFrame2", 48, -32)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["PartyMemberFrame2"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	PartyMember3DebuffsMover = {
		w = 66,
		h = 15,
		point = {"TOPLEFT", "PartyMemberFrame3", "TOPLEFT", 48, -32},
		prefix = "PartyMemberFrame3Debuff",
		count = MAX_PARTY_DEBUFFS,
		dontLock = true,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self)
				MovAny:LockPoint(child)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				MovAny:UnlockPoint(child)
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", "PartyMemberFrame3", 48, -32)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["PartyMemberFrame3"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	PartyMember4DebuffsMover = {
		w = 66,
		h = 17,
		point = {"TOPLEFT", "PartyMemberFrame4", "TOPLEFT", 48, -32},
		prefix = "PartyMemberFrame4Debuff",
		count = MAX_PARTY_DEBUFFS,
		dontLock = true,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self)
				MovAny:LockPoint(child)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				MovAny:UnlockPoint(child)
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", "PartyMemberFrame4", 48, -32)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["PartyMemberFrame4"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	PetDebuffsMover = {
		w = 66,
		h = 17,
		point = {"TOPLEFT", "PetFrame", "TOPLEFT", 48, -42},
		prefix = "PetFrameDebuff",
		count = 4,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", "PetFrame", 48, -42)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["PetFrame"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	TargetBuffsMover = {
		w = 122,
		h = 21,
		point = {"TOPLEFT", "TargetFrame", "BOTTOMLEFT", 5, 32},
		prefix = "TargetFrameBuff",
		count = MAX_TARGET_BUFFS,
		dontLock = true,
		OnLoad = function(self)
			if TargetFrame_UpdateAuras then
				hooksecurefunc("TargetFrame_UpdateAuras", function(frame)
					if frame == TargetFrame and self.MAHooked then
						self:MAScanForChildren()
					end
				end)
			end
		end,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self)
				MovAny:LockPoint(child)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				MovAny:UnlockPoint(child)
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", TargetFrame, "BOTTOMLEFT", 5, 32)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["TargetFrame"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	TargetDebuffsMover = {
		w = 122,
		h = 23,
		point = {"TOPLEFT", "TargetFrame", "BOTTOMLEFT", 5, 35},
		prefix = "TargetFrameDebuff",
		count = MAX_TARGET_DEBUFFS,
		dontLock = true,
		OnLoad = function(self)
			if TargetFrame_UpdateAuras then
				hooksecurefunc("TargetFrame_UpdateAuras", function(frame)
					if frame == TargetFrame and self.MAHooked then
						self:MAScanForChildren()
					end
				end)
			end
		end,
		OnMAFoundChild = function(self, index, child)
			if self.firstChild == child then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
				MovAny:LockPoint(child)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if self.firstChild == child then
				MovAny:UnlockPoint(child)
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", TargetFrame, "BOTTOMLEFT", 5, 35)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["TargetFrame"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	FocusBuffsMover = {
		w = 124,
		h = 23,
		point = {"TOPLEFT", "FocusFrame", "BOTTOMLEFT", 4, 33},
		prefix = "FocusFrameBuff",
		count = MAX_TARGET_BUFFS,
		dontLock = true,
		OnLoad = function(self)
			if TargetFrame_UpdateAuras then
				hooksecurefunc("TargetFrame_UpdateAuras", function(frame)
					if frame == FocusFrame and self.MAHooked then
						self:MAScanForChildren()
					end
				end)
			end
		end,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
				MovAny:LockPoint(child)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				MovAny:UnlockPoint(child)
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", FocusFrame, "BOTTOMLEFT", 5, 35)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["FocusFrame"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	FocusDebuffsMover = {
		w = 124,
		h = 21,
		point = {"TOPLEFT", "FocusFrame", "BOTTOMLEFT", 4, 33},
		prefix = "FocusFrameDebuff",
		count = MAX_TARGET_DEBUFFS,
		dontLock = true,
		OnLoad = function(self)
			if TargetFrame_UpdateAuras then
				hooksecurefunc("TargetFrame_UpdateAuras", function(frame)
					if frame == FocusFrame and self.MAHooked then
						self:MAScanForChildren()
					end
				end)
			end
		end,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
				MovAny:LockPoint(child)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				MovAny:UnlockPoint(child)
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", FocusFrame, "BOTTOMLEFT", 4, 33)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["FocusFrame"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	TargetFrameToTDebuffsMover = {
		w = 23,
		h = 23,
		point = {"TOPLEFT", "TargetFrameToT", "TOPRIGHT", 3, -9},
		prefix = "TargetFrameToTDebuff",
		count = 4,
		OnLoad = function(self)
			if TargetFrame_CreateTargetofTarget then
				hooksecurefunc("TargetFrame_CreateTargetofTarget", function(frame)
					if frame == TargetFrame and self.MAHooked then
						self:MAScanForChildren()
					end
				end)
			end
		end,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", TargetFrameToT, "TOPRIGHT", 4, -10)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["TargetFrameToT"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	PlayerBuffsMover = {
		w = 31,
		h = 31,
		point = {"TOPRIGHT", "UIParent", "TOPRIGHT", -205, -13},
		children = {"TemporaryEnchantFrame", "ConsolidatedBuffs"},
		prefix = "BuffButton",
		count = 32,
		dontHide = true,
		dontLock = true,
		dontScale = true,
		OnLoad = function(vm)
			if BuffFrame_Update then
				local opt, e, cb
				
				local hBuffFrame_Update = function()
					opt = vm.opt
					if opt and not opt.disabled and vm.MAE and vm.MAE:IsModified() then
						vm:MAScanForChildren(true, true)
						
						if opt.scale then
							cb = GetCVar("consolidateBuffs")
							if not opt.hidden and vm.attachedChildren then
								if cb == "1" then
									for i, v in pairs(vm.attachedChildren) do
										if v:GetParent():GetName() ~= "ConsolidatedBuffsContainer" then
											v:SetScale(opt.scale)
										else
											v:SetScale(1)
										end
									end
								else
									for i, v in pairs(vm.attachedChildren) do
										v:SetScale(opt.scale)
									end
								end
							end
						end
						MovAny:UnlockPoint(vm.tef)
						vm.tef:ClearAllPoints()
						if IsInGroup() and GetCVarBool("consolidateBuffs") then
							vm.tef:SetPoint("TOPRIGHT", ConsolidatedBuffs, "TOPLEFT", -6, 0)
						else
							vm.tef:SetPoint("TOPRIGHT", ConsolidatedBuffs, "TOPRIGHT", 0, 0)
						end
						
						MovAny:LockPoint(vm.tef)
					end
				end
				local hBuffFrame_ErrorHandler = function()
					--print("Error: "..debugstack(2, 20, 20))
				end
				hooksecurefunc("BuffFrame_Update", function()
					xpcall(hBuffFrame_Update, hBuffFrame_ErrorHandler)
				end)
			end
		end,
		--[[
		OnMAFoundChild = function(self, index, child)
			if self.opt and self.opt.scale then
				--MovAny:UnlockScale(child)
				if child:GetParent():GetName() ~= "ConsolidatedBuffsContainer" then
					child:SetScale(self.opt.scale)
				else
					child:SetScale(1)
				end
				--MovAny:LockScale(child)
			end
			--print(index.."  OnMAFoundChild  "..self:GetName().."  "..child:GetName())
		end,
		]]
		--[[
		OnMAReleaseChild = function(self, index, child)
			--print(index.."  OnMAReleaseChild  "..self:GetName().."  "..child:GetName())
		end,
		]]
		OnMAScale = function(self, scale)
			if type(scale) ~= "number" then
				return
			end
			if self.attachedChildren then
				if GetCVar("consolidateBuffs") then
					for i, child in pairs(self.attachedChildren) do
						if child:GetParent():GetName() ~= "ConsolidatedBuffsContainer" then
							child:SetScale(scale)
						else
							child:SetScale(1)
						end
					end
				else
					for i, child in pairs(self.attachedChildren) do
						child:SetScale(scale)
					end
				end
			end
		end,
		OnMAHook = function(self)
			local b = _G["BuffFrame"]
			b:ClearAllPoints()
			b:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
			MovAny:LockPoint(b)
			
			b = _G["TemporaryEnchantFrame"]
			MovAny:LockPoint(b)
			self.tef = b
			
			b = _G["ConsolidatedBuffs"]
			b:ClearAllPoints()
			b:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
			MovAny:LockPoint(b)
			if BuffFrame.numConsolidated == 0 then
				b:Hide()
			end
			
			if self.attachedChildren and self.opt and self.opt.scale then
				if GetCVar("consolidateBuffs") == "1" then
					for i, v in pairs(self.attachedChildren) do
						if v:GetParent():GetName() ~= "ConsolidatedBuffsContainer" then
							v:SetScale(self.opt.scale)
						else
							v:SetScale(1)
						end
					end
				else
					for i, v in pairs(self.attachedChildren) do
						v:SetScale(self.opt.scale)
					end
				end
			end
		end,
		OnMAPreReset = function(self, readOnly)
			if readOnly then
				return true
			end
			MovAny:UnlockPoint(self.tef)
			
			local b = _G["BuffFrame"]
			MovAny:UnlockPoint(b)
			b:ClearAllPoints()
			b:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -205, -13)
			b = _G["ConsolidatedBuffs"]
			MovAny:UnlockPoint(b)
			b:ClearAllPoints()
			b:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -180, -13)
			
			for i, v in pairs(self.attachedChildren) do
				MovAny:UnlockScale(v)
				v:SetScale(1)
			end
			
			self.tef = nil
		end,
		OnMAPostReset = function(self, readOnly)
			if readOnly then
				return true
			end
		end,
		OnMAHide = function(self, hidden)
			if hidden then
				MovAny:LockVisibility(_G["ConsolidatedBuffs"])
				MovAny:LockVisibility(_G["BuffFrame"])
				MovAny:LockVisibility(_G["TemporaryEnchantFrame"])
			else
				MovAny:UnlockVisibility(_G["ConsolidatedBuffs"])
				MovAny:UnlockVisibility(_G["BuffFrame"])
				MovAny:UnlockVisibility(_G["TemporaryEnchantFrame"])
			end
		end,
	},
	PlayerDebuffsMover = {
		w = 31,
		h = 31,
		prefix = "DebuffButton",
		count = 16,
		point = {"TOPRIGHT", "BuffFrame", "BOTTOMRIGHT", 0, -50},
		OnLoad = function(self)
			if BuffFrame_Update then
				hooksecurefunc("BuffFrame_Update", function()
					if self.MAHooked then
						self:MAScanForChildren()
					end
				end)
			end
		end,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPRIGHT", self, "TOPRIGHT", -1, -1)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPRIGHT", ConsolidatedBuffs, "BOTTOMRIGHT", 0, -TempEnchant1:GetHeight()*3)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["BuffFrame"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	FocusFrameToTDebuffsMover = {
		w = 23,
		h = 23,
		point = {"TOPLEFT", "FocusFrameToT", "TOPRIGHT", 3, -9},
		prefix = "FocusFrameToTDebuff",
		count = 8,
		OnMAFoundChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", self, 1, -1)
			end
		end,
		OnMAReleaseChild = function(self, index, child)
			if index == 1 then
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", "FocusFrameToT", "TOPRIGHT", 4, -10)
			end
		end,
		OnMAHook = function(self)
			self:SetScale(_G["FocusFrameToT"]:GetEffectiveScale() / UIParent:GetScale())
		end,
	},
	RaidUnitFramesMover = {
		linkedSize = "CompactRaidFrameContainer",
		linkedPoint = "CompactRaidFrameContainer",
		children = {"CompactRaidFrameContainer"},
		dontLock = true,
		OnLoad = function(self)
			hooksecurefunc("CompactRaidFrameManager_SetSetting", function(setting, value, skip)
				if skip ~= "MASkip" and setting == "Locked" and IsShiftKeyDown() then
					if not InCombatLockdown() then
						if value then
							MovAny:StopMoving(self:GetName())
						else
							CompactRaidFrameManager_LockContainer(CompactRaidFrameManager)
							if not MovAny:GetMoverByFrame(self:GetName()) then
								MovAny:AttachMover(self:GetName())
							end
						end
					end
				end
			end)
		end,
		OnMAHook = function(self)
			local con = _G["CompactRaidFrameContainer"]
			self.con = con
			MovAny:UnlockPoint(con)
			con:ClearAllPoints()
			con:SetPoint("CENTER", self, "CENTER", 0, 0)
			MovAny:LockPoint(con)
		end,
		OnMAPreReset = function(self)
			if self.con then
				MovAny:UnlockPoint(self.con)
				self.con:SetPoint("TOPLEFT", "CompactRaidFrameManagerContainerResizeFrame", "TOPLEFT", 4, -7)
				self.con = nil
			end
		end,
		OnMADetach = function()
			CompactRaidFrameManager_SetSetting("Locked", "lock", "MASkip")
		end,
		OnMAAttach = function()
			if CompactRaidFrameManager_GetSetting("Locked") == "lock" then
				CompactRaidFrameManager_SetSetting("Locked", "unlock", "MASkip")
				CompactRaidFrameManager_LockContainer(CompactRaidFrameManager)
			end
		end,
		OnMAAlpha = function(self, alpha)
			local bg
			if self.con then
				if alpha > 0.999 then
					for i=1, GetNumGroupMembers(), 1 do
						bg = _G["CompactRaidFrame"..i]
						if bg then
							bg:EnableDrawLayer("BACKGROUND")
							bg:EnableDrawLayer("BORDER")
						end
					end
				else
					for i=1, GetNumGroupMembers(), 1 do
						bg = _G["CompactRaidFrame"..i]
						if bg then
							bg:DisableDrawLayer("BACKGROUND")
							bg:DisableDrawLayer("BORDER")
						end
					end
				end
				
				if self.con.groupMode == "discrete" then
					if alpha > 0.999 then
						for i=1, 8, 1 do
							for j=1, 5, 1 do
								bg = _G["CompactRaidGroup"..i.."Member"..j]
								if bg then
									bg:EnableDrawLayer("BACKGROUND")
									bg:EnableDrawLayer("BORDER")
								end
							end
						end
					else
						for i=1, 8, 1 do
							for j=1, 5, 1 do
								bg = _G["CompactRaidGroup"..i.."Member"..j]
								if bg then
									bg:DisableDrawLayer("BACKGROUND")
									bg:DisableDrawLayer("BORDER")
								end
							end
						end
					end
				end
			end
		end,
	},
	RaidUnitFramesManagerMover = {
		linkedSize = "CompactRaidFrameManager",
		point = {"TOPLEFT", "UIParent", "TOPLEFT", -7, -140},
		children = {"CompactRaidFrameManager"},
		dontLock = true,
		OnLoad = function(self)
			local b = CreateFrame("Button", "MACompactRaidFrameManagerToggleButton", UIParent, nil, "MADontHook")
			b:SetSize(16, 64)
			b:SetNormalTexture("Interface\\RaidFrame\\RaidPanel-Toggle")
			if GetNumGroupMembers() < 1 then
				b:Hide()
			end
			local tex = b:GetNormalTexture()
			tex:SetDrawLayer("OVERLAY")
			tex:SetTexCoord(0, .5, 0, 1)
			tex:SetSize(self:GetSize())
			b:SetScript("OnMouseDown", function(self)
				local tex = self:GetNormalTexture()
				tex:ClearAllPoints()
				tex:SetSize(self:GetSize())
				tex:SetPoint("CENTER", 1, 0)
			end)
			b:SetScript("OnMouseUp", function(self)
				self:GetNormalTexture():SetAllPoints()
			end)
			b:SetScript("OnClick", function() CompactRaidFrameManager_Expand(CompactRaidFrameManager) end)
			
			local man = _G["CompactRaidFrameManager"]
			p = {"TOPLEFT", "UIParent", "TOPLEFT", -5, -225}
			b:SetPoint(unpack(p))
			local e = MovAny.API:GetElement(b:GetName())
			if e:IsModified() then
				e:Sync()
			end
			self.button = b
			
			hooksecurefunc("CompactRaidFrameManager_Expand", function(man)
				if not self.MAHooked then
					return
				end
				MovAny:UnlockPoint(man)
				man:ClearAllPoints()
				man:SetPoint("CENTER", self, "CENTER", 0, 0)
				MovAny:LockPoint(man)
				b:Hide()
			end)
			hooksecurefunc("CompactRaidFrameManager_Collapse", function(man)
				if not self.MAHooked then
					return
				end
				MovAny:UnlockPoint(man)
				man:ClearAllPoints()
				man:SetPoint("BOTTOMRIGHT", UIParent, "TOPLEFT", 0, 0)
				MovAny:LockPoint(man)
				if GetNumGroupMembers() > 0 then
					b:Show()
				end
			end)
		end,
		OnMAHook = function(self)
			local man = _G["CompactRaidFrameManager"]
			self.man = man
			if not self.opt or not self.opt.hidden then
				if man.collapsed then
					MovAny:UnlockPoint(man)
					man:ClearAllPoints()
					man:SetPoint("BOTTOMRIGHT", UIParent, "TOPLEFT", 0, 0)
					MovAny:LockPoint(man)
					if GetNumGroupMembers() > 0 then
						self.button:Show()
					end
				else
					MovAny:UnlockPoint(man)
					man:ClearAllPoints()
					man:SetPoint("CENTER", self, "CENTER", 0, 0)
					MovAny:LockPoint(man)
					self.button:Hide()
				end
			end
		end,
		OnMAPreReset = function(self)
			local e = MovAny.API:GetElement(self:GetName())
			MovAny.Position:Reset(e, self.man, true)
			self.button:Hide()
			self.man = nil
		end,
	},
	BagsMover = {
		w = 100,
		h = 100,
		point = {"BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -93, 125},
		prefix = "ContainerFrame",
		count = 14,
		dontLock = true,
		dontScale = true,
		dontAlpha = true,
		OnMAFoundChild = function(self, index, child)
			if MovAny:IsModified(MovAny.lTransContainerToBag[child:GetName()]) then
				return
			end
			child:SetParent(self)
			MovAny:UnlockScale(child)
			child:SetScale(1)
			MovAny:LockScale(child)
		end,
		OnMAReleaseChild = function(self, index, child)
			child:SetParent(UIParent)
			MovAny:UnlockScale(child)
		end,
		OnMAPosition = MovAny.hUpdateContainerFrameAnchors,
		OnMAScale = MovAny.hUpdateContainerFrameAnchors,
		OnMAPreReset = function(self, readOnly)
			if not readOnly then
				if self.attachedChildren then
					table.wipe(self.attachedChildren)
				end
				self:MAScanForChildren()
			end
		end,
		OnMAPostReset = function(self)
			if not readOnly then
				UpdateContainerFrameAnchors()
			end
		end,
	},
	ChatEditBoxesMover = {
		relPoint = {"TOPLEFT", "ChatFrame1", "BOTTOMLEFT", -5, -2},
		prefix = "ChatFrame",
		postfix = "EditBox",
		count = 10,
		--dontLock = 1,
		OnMAHook = function(self)
			self:SetSize(ChatFrame1:GetWidth(), ChatFrame1EditBox:GetHeight())
		end,
		OnMAFoundChild = function(self, index, child)
			MovAny.Position:StoreOrgPoints(child, child)
			child:SetWidth(self:GetWidth())
			child.MAOrgParent = child:GetParent()
			child:SetParent(self)
			child:ClearAllPoints()
			child:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
			child:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
			MovAny:LockPoint(child)
		end,
		OnMAReleaseChild = function(self, index, child)
			child:SetParent(child.MAOrgParent)
			child.MAOrgParent = nil
			MovAny:UnlockPoint(child)
			MovAny.Position:RestoreOrgPoints(child, child, true)
		end,
	},
	MA_FEMover = {
		frameStrata = "DIALOG",
		point = {"CENTER", "UIParent", "CENTER", 0, 0},
		w = 650,
		h = 490,
		prefix = "MA_FE",
		count = 1000000,
	},
}