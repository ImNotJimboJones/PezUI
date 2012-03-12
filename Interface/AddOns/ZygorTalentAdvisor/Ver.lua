assert(ZygorTalentAdvisor,"Zygor Talent Advisor failed to load.")
local name,_=...
ZygorTalentAdvisor.revision = tonumber(string.sub("$Revision: 3165 $", 12, -3))
ZygorTalentAdvisor.version = GetAddOnMetadata(name,"version") .. "." .. ZygorTalentAdvisor.revision
ZygorTalentAdvisor.date = string.sub("$Date: 2011-11-29 14:42:47 -0600 (Tue, 29 Nov 2011) $", 8, 17)
--2011/11/29 15:42:46.76956
