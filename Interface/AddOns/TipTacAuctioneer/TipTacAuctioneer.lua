hooksecurefunc("CreateFrame", 
function(type, name, parent, template) 
if strfind(tostring(name), "LibExtraTip") then 
local frame = _G[name] 
frame:SetBackdrop(GameTooltip:GetBackdrop()) 
frame:SetBackdropColor(GameTooltip:GetBackdropColor()) 
frame:SetBackdropBorderColor(GameTooltip:GetBackdropBorderColor()) 
end 
end)