local tool
tool = BrokerToolBox:NewTool("clock",{
	author="Sanori (/ethancentaurai)",
	version="1.1",
	defaultON=true,
	db={
		timetype="l",
		["24hours"]=true,
		calendar=true,
	},
	OnUpdate = function(self, elapsed)
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
		if (self.TimeSinceLastUpdate > 0.5) then	--refresh all 0,5sec
			--Server Time
			local sHour, sMin = GetGameTime()
			local ampm = ""
			if not self.db["24hours"] then
				ampm="AM"
				if sHour>=12 then ampm="PM" end
				if sHour>12 then
					sHour=sHour-12
				elseif sHour==0 then
					sHour=12
				end
			end
			local _sHour = tostring(sHour)
			local _sMin = tostring(sMin)
			if sHour<10 then _sHour = "0".._sHour end
			if sMin<10 then _sMin = "0".._sMin end
			self.server = format("%s:%s%s",_sHour,_sMin,ampm)
			--Locale Time and UTC Time
			if self.db["24hours"] then
				self.locale = date("%H:%M")
				self.utc = date("!%H:%M")
			else
				self.locale = date("%I:%M%p")
				self.utc = date("!%I:%M%p")
			end
			--Print
			if self.db.timetype=="l" then
				self.broker.text = self.locale
			elseif self.db.timetype=="s" then
				self.broker.text = self.server
			else
				self.broker.text = self.utc
			end
			self.TimeSinceLastUpdate = 0
		end
	end,
	broker = {
		type = "data source",
		text = "00:00",
		icon = "Interface\\Icons\\Spell_Holy_BorrowedTime",
		OnTooltipShow = function()
			--date and time
			local day = tool:L("days"..tonumber(date("%w")))
			GameTooltip:AddDoubleLine(tool:L("date"),day..", "..date("%d.%m.%Y"))
			GameTooltip:AddDoubleLine(tool:L("stime"),tool.server)
			GameTooltip:AddDoubleLine(tool:L("ltime"),tool.locale)
			GameTooltip:AddDoubleLine(tool:L("utime"),tool.utc)
			GameTooltip:AddLine(" ")
			--calendar
			if tool.db.calendar then
				GameTooltip:AddLine(tool:L("todayevents"))
				local found
				local day=tonumber(date("%d"))
				for i=1, CalendarGetNumDayEvents(0,day) do
					local title, hour, minute, calendarType, _, eventType, texture, _, inviteStatus, _ = CalendarGetDayEvent(0, day, i)
					if (calendarType~="HOLIDAY" and calendarType~="RAID_LOCKOUT") then
						found=true
						local ampm = ""
						if not tool.db["24hours"] then
							ampm="AM"
							if hour>=12 then ampm="PM" end
							if hour>12 then
								hour=hour-12
							elseif hour==0 then
								hour=12
							end
						end
						local _hour, _minute = tostring(hour), tostring(minute)
						if hour<10 then _hour="0".._hour end
						if minute<10 then _minute="0".._minute end
						--output
						GameTooltip:AddDoubleLine(format("|cff%s%s (%s)|r",tool.calenderstatus[inviteStatus].color,title,tool.calenderstatus[inviteStatus].text),format("%s:%s%s",_hour,_minute,ampm))
						if (eventType and tool.calendartextures[eventType] and texture) then
							GameTooltip:AddTexture(format(tool.calendartextures[eventType],texture))
						end
					end
				end
				if not found then GameTooltip:AddLine(tool:L("noevents"),1,1,1) end
				GameTooltip:AddLine(" ")
			end
			--buttons
			GameTooltip:AddLine(tool:L("leftclick"))
			GameTooltip:AddLine(tool:L("shiftleftclick"))
			GameTooltip:AddLine(tool:L("rightclick"))
		end,
		OnClick = function(self, button)
			if button=="RightButton" then
				tool.menu:Open(self, 'children', function(level, value)
					GameTooltip:Hide()
					tool.menu:AddSelection(tool.db.timetype, function(var) tool.db.timetype=var end, {
						["<1>"..tool:L("stime")] = "s",
						["<2>"..tool:L("ltime")] = "l",
						["<3>"..tool:L("utime")] = "u",
					})
					tool.menu:AddLine()
					tool.menu:AddToggle(tool:L("24hours"), tool.db["24hours"], function(var) tool.db["24hours"]=var end)
					tool.menu:AddToggle(tool:L("showcalendarevents"), tool.db.calendar, function(var) tool.db.calendar=var end)
				end)
				return
			end
			if IsShiftKeyDown() then
				GameTimeFrame_OnClick(GameTimeFrame)
				return
			end
			ToggleTimeManager()
		end,
	},
	PreInit = function(self)
		self.TimeSinceLastUpdate = 0
		self.locale, self.server, self.utc = "00:00", "00:00", "00:00"
	end,
	PostInit = function(self)
		GameTimeFrame_OnClick(GameTimeFrame)
		GameTimeFrame_OnClick(GameTimeFrame)
		self.calenderstatus = {
			[CALENDAR_INVITESTATUS_INVITED]      = {
				color="ffff00",
				text=CALENDAR_STATUS_INVITED,
			},
			[CALENDAR_INVITESTATUS_ACCEPTED]     = {
				color="00ff00",
				text=CALENDAR_STATUS_ACCEPTED,
			},
			[CALENDAR_INVITESTATUS_DECLINED]     = {
				color="ff0000",
				text=CALENDAR_STATUS_DECLINED,
			},
			[CALENDAR_INVITESTATUS_CONFIRMED]    = {
				color="00ff00",
				text=CALENDAR_STATUS_CONFIRMED,
			},
			[CALENDAR_INVITESTATUS_OUT]          = {
				color="ff0000",
				text=CALENDAR_STATUS_OUT,
			},
			[CALENDAR_INVITESTATUS_STANDBY]      = {
				color="ff8040",
				text=CALENDAR_STATUS_STANDBY,
			},
			[CALENDAR_INVITESTATUS_SIGNEDUP]     = {
				color="00ff00",
				text=CALENDAR_STATUS_SIGNEDUP,
			},
			[CALENDAR_INVITESTATUS_NOT_SIGNEDUP] = {
				color="ffff00",
				text=CALENDAR_STATUS_NOT_SIGNEDUP,
			},
			[CALENDAR_INVITESTATUS_TENTATIVE]    = {
				color="ff8040",
				text=CALENDAR_STATUS_TENTATIVE,
			},
		}
		self.calendartextures = {
			[CALENDAR_EVENTTYPE_RAID]		= "Interface\\LFGFrame\\LFGIcon-%s",
			[CALENDAR_EVENTTYPE_DUNGEON]	= "Interface\\LFGFrame\\LFGIcon-%s",
			[CALENDAR_EVENTTYPE_PVP]		= "Interface\\Calendar\\UI-Calendar-Event-PVP",
			[CALENDAR_EVENTTYPE_MEETING]	= "Interface\\Calendar\\MeetingIcon",
			[CALENDAR_EVENTTYPE_OTHER]		= "Interface\\Calendar\\UI-Calendar-Event-Other",
		}
	end,
})