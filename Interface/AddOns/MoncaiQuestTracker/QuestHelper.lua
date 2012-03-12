local ML = LibStub("MoncaiLib");
local MQT = LibStub("AceAddon-3.0"):GetAddon("MoncaiQuestTracker");
local L = LibStub("AceLocale-3.0"):GetLocale("MoncaiQuestTracker", false);
local QH = MQT:NewModule("MQT_QuestHelper");
_G["QH"] = QH;
local MQTW = MQT.workspace;
MQT.QH = QH

function QH.QH_Tracker_UpdateRoute(new_route)
	QH.route = new_route;
	QH.UpdateWatchWindow();
end;

local qhu_timer = 0;
local qhu_delta = 5;

function QH.Update(self, elapsed)
	qhu_timer = qhu_timer + elapsed;
	if qhu_timer >= qhu_delta then
		qhu_timer = 0;
		QH.UpdateWatchWindow()
	end
end

function QH.UpdateNext()
	qhu_timer = qhu_delta - .15;
end

function QH.UpdateWatchWindow()
	QH.UpdateWatches()
	WatchFrame_Update();
end

function QH.UpdateWatches()
	if not MQT.db.profile.questhelper then 
		--//TODO: disable QH addon at this point.
		Print("QH Integration is not enabled in profile; disabling...")
		QH:Disable();
		return 
	end
	
	local collection = {};
	local W = MQTW;
	W.watches = 0;

	local idx;
	
	if QH.route then
		for i, obj in ipairs(QH.route) do
			if obj.type_quest and obj.type_quest.index then idx = obj.type_quest and obj.type_quest.index
			else idx = nil end;
			
			if idx and not collection[idx] and W.watches < 10 and (MQTC.qhshowall or IsQuestWatched(idx) ) then
				W.watches = W.watches + 1;
				W.hash[W.watches] = idx;
				collection[idx] = true;
			end
			-- if i > 5 then break; end;
		end
	end;
	
	MQT.EnumWatches(collection)
end

--------------------------------------------------------------------------------------------------------
--
-- Initialize
--
--------------------------------------------------------------------------------------------------------

function QH.OnInitialize(self)	
	local hooks = ML.api.hooking:new(self);
	self.hooks = hooks;
	hooks:GlobalDelegate("QH_Tracker_UpdateRoute");
	hooks:GlobalDelegate("QuestLog_Update", QH.UpdateNext);
	hooks:HookMethod(MQT, "UpdateWatches");
	hooks:MethodDelegate(MQT, "Update");
	if IsAddOnLoaded("QuestHelper") then
		self:SetEnabledState(MQT.db.profile.questhelper)
		if not MQT.db.profile.questhelper then
			if MQT.db.profile.debug then Print("QuestHelper functionality disabled in config") end
		end
	else
		self:SetEnabledState(false)	
	end
end

function QH.OnEnable(self)
	self.hooks:enable();
	Print(L["QuestHelper integration active"]);
end

function QH.OnDisable(self)
	self.hooks:disable();
	Print(L["QuestHelper integration disabled"]);	
end
