
------------------------------------------------------
-- Define PezUI Core namespace
------------------------------------------------------
pez = {};


------------------------------------------------------
-- PezUI Core Options
------------------------------------------------------
pez.options = {};
pez.options.DEBUG = true;



------------------------------------------------------
-- Core Functions
------------------------------------------------------


--**************************************************--
-- Logs a message to the general chat window, only if
-- the DEBUG option is enabled.
-- @param msg	A message to be logged. tostring() will
--		be called on the given value.
--**************************************************--
function pez.log(msg)
	if (pez.options.DEBUG) then
		print("|cffffe00a<|r|cffff7d0aPezUI|r|cffffe00a>|r "..tostring(msg));
	end
end