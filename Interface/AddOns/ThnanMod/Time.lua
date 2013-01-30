local _, TMPrivate = ...;
local configValues = TMPrivate.configValues;

ThnanMod.Time = {};
local time = ThnanMod.Time;

local function isLeapYear(year)
	if (year % 400) == 0 then
		return true
	elseif (year % 100) == 0 then
		return false;
	elseif (year % 4) == 0 then
		return true;
	else
		return false;
	end
end
local function getNumDaysForMonth(month, year)
	if month == 2 then
		if isLeapYear(year) then
			return 29;
		else
			return 28;
		end
	elseif ((month == 1) or (month == 3) or (month == 5) or (month == 7) or (month == 8) or (month == 10) or (month == 12)) then
		return 31;
	else
		return 30;
	end
end

function time:rectifyDate(day, month, year)
	while month < 1 do
		month = month + 12;
		year = year - 1;
	end
	while month > 12 do
		month = month - 12;
		year = year + 1;
	end
	while day < 1 do
		month = month - 1;
		if month < 1 then
			month = 12;
			year = year - 1;
		end
		day = day + getNumDaysForMonth(month, year);
	end
	while day > getNumDaysForMonth(month, year) do
		day = day - getNumDaysForMonth(month, year);
		month = month + 1;
		if month > 12 then
			month = 1;
			year = year + 1;
		end
	end
	return day, month, year;
end
function time:timeUntilDailyReset()
	local nowHour = tonumber(date("!%H"));
	local nowMin = tonumber(date("!%M"));
	local resetHours = (24 + configValues.dailyResetTime) - nowHour;
	local resetMinutes = 0;
	if (nowMin > 0) then
		resetHours = resetHours - 1;
		resetMinutes = 60 - nowMin;
	end
	if resetHours > 24 then
		resetHours = resetHours - 24;
	elseif resetHours == 24  and resetMinutes > 0 then
		resetHours = 0;
	end
	return resetHours, resetMinutes;
end
function time:currentDailyDate()
	local nowYear = tonumber(date("!%Y"));
	local nowMonth = tonumber(date("!%m"));
	local nowDay = tonumber(date("!%d"));
	local nowHour = tonumber(date("!%H"));
	local nowMin = tonumber(date("!%M"));
	local resetHours, resetMinutes = time:timeUntilDailyReset();
	
	if configValues.dailyResetTime > 12 then
		if resetHours < configValues.dailyResetTime then
			return nowDay, nowMonth, nowYear;
		elseif resetHours == configValues.dailyResetTime then
			if resetMinutes == 0 then
				return nowDay, nowMonth, nowYear;
			else
				return time:rectifyDate(nowDay + 1, nowMonth, nowYear);
			end
		else
			return time:rectifyDate(nowDay + 1, nowMonth, nowYear);
		end
	else
		if resetHours < configValues.dailyResetTime then
			return time:rectifyDate(nowDay - 1, nowMonth, nowYear);
		elseif resetHours == configValues.dailyResetTime then
			if resetMinutes == 0 then
				return time:rectifyDate(nowDay - 1, nowMonth, nowYear);
			else
				return nowDay, nowMonth, nowYear;
			end
		else
			return nowDay, nowMonth, nowYear;
		end
	end
end