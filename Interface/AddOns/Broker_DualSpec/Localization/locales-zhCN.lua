-- ********************************************************************************
-- Data Broker Dual Specilisation (Broker_DualSpec)
-- A dual specialisation switch for Data Broker.
-- By: Shenton
--
-- Locales-zhCN.lua
-- ********************************************************************************

local L = LibStub("AceLocale-3.0"):NewLocale("Broker_DualSpec", "zhCN");

if L then
-- L["ADDON_NAME"] = "DualSpec"
L["CLOSE"] = "关闭" -- Needs review
L["COMMAND_USAGE_1"] = "命令行, \"/ds\", \"/bds\", \"/brokerdualspec\"" -- Needs review
-- L["COMMAND_USAGE_2"] = "With no argument it will change your specialisation"
-- L["COMMAND_USAGE_3"] = "\"/ds show\", show the minimap icon, \"/ds list\", list your gear sets"
-- L["COMMAND_USAGE_4"] = "\"/ds <primary|secondary> <gear set>\", will set the given specialisation with the given gear set"
L["CURRENT_SPEC"] = "当前天赋" -- Needs review
L["DISPLAY_SPEC_NAME"] = "显示天赋名字" -- Needs review
L["DISPLAY_SPEC_POINTS"] = "显示天赋点数" -- Needs review
L["GEAR_NOT_EXISTS"] = "装备套装不存在,使用 \"/ds list\" 来获取" -- Needs review
L["GEAR_SETS"] = "状态套装" -- Needs review
-- L["HIDE_MINIMAP"] = "Minimap icon is hidden if you want to show it back use: \"/ds show\" (or /bds /brokerdualspec)"
L["IN_COMBAT"] = "你在战斗中不能切换天赋" -- Needs review
L["NO_GEAR_DEFINED"] = "切换套装已启用但没有定义套装" -- Needs review
L["NO_GEAR_SETS"] = "你没有定义套装" -- Needs review
L["NOT_AVAILABLE"] = "不可哟个" -- Needs review
L["OPTIONS"] = "选项" -- Needs review
L["PRIMARY_SPEC"] = "主天赋" -- Needs review
L["SECONDARY_SPEC"] = "副天赋" -- Needs review
L["SHOW_HIDE_MINIMAP"] = "显示/隐藏小地图按钮" -- Needs review
L["SWITCH_GEAR_TOO"] = "同时切换装备" -- Needs review
L["SWITCH_TO"] = "切换到" -- Needs review
L["TOOLTIP_TIPS"] = "%s左键点击:%s 切换天赋和套装\n%s右键点击:%s 显示配置面板" -- Needs review
L["WITH_GEAR_SET"] = "同时切换套装" -- Needs review
end
