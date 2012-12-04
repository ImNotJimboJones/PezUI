-- internal vars

local tocName, TMPrivate = ...;
local L = TMPrivate.L;

TMPrivate.addonName = GetAddOnMetadata(tocName, "Title");
TMPrivate.plugins = {};

-- global vars

ThnanMod = {};

-- core functions

local addonNameColor = "|cFF00FFFF";

function ThnanMod:output(msg)
	print(addonNameColor..TMPrivate.addonName..":|r "..tostring(msg));
end

function ThnanMod:registerPlugin(plugin)
	TMPrivate.plugins[plugin.pluginName] = plugin;
end