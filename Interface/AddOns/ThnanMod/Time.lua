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
	local now = date("!*t");
	local resetHours = (24 + configValues.dailyResetTime) - now.hour;
	if resetHours > 23 then
		resetHours = resetHours - 24;
	end
	local resetMinutes = 0;
	if (now.min > 0) then
		resetHours = resetHours - 1;
		resetMinutes = 60 - now.min;
	end
	return resetHours, resetMinutes;
end
function time:currentDailyDate()
	local now = date("!*t");
	local resetHours, resetMinutes = time:timeUntilDailyReset();
	configValues.dailyResetTime = 11;
	
	if configValues.dailyResetTime > 12 then
		if resetHours < configValues.dailyResetTime then
			return now.day, now.month, now.year;
		elseif resetHours == configValues.dailyResetTime then
			if resetMinutes == 0 then
				return now.day, now.month, now.year;
			else
				return time:rectifyDate(now.day + 1, now.month, now.year);
			end
		else
			return time:rectifyDate(now.day + 1, now.month, now.year);
		end
	else
		if resetHours < configValues.dailyResetTime then
			return time:rectifyDate(now.day - 1, now.month, now.year);
		elseif resetHours == configValues.dailyResetTime then
			if resetMinutes == 0 then
				return time:rectifyDate(now.day - 1, now.month, now.year);
			else
				return now.day, now.month, now.year;
			end
		else
			return now.day, now.month, now.year;
		end
	end
end