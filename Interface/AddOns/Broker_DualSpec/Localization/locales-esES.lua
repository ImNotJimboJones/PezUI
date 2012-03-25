-- ********************************************************************************
-- Data Broker Dual Specilisation (Broker_DualSpec)
-- A dual specialisation switch for Data Broker.
-- By: Shenton
--
-- Locales-esES.lua
-- ********************************************************************************

local L = LibStub("AceLocale-3.0"):NewLocale("Broker_DualSpec", "esES");

if L then
L["ADDON_NAME"] = "DualSpec"
L["CLOSE"] = "Cerrar"
L["COMMAND_USAGE_1"] = "Comandos, \"/ds\", \"/bds\", \"/brokerdualspec\""
L["COMMAND_USAGE_2"] = "Sin comandos adicionales, solo cambiará tu especialización"
L["COMMAND_USAGE_3"] = "\"/ds show\", mostrar icono en el minimapa, \"/ds list\", listado de tus equipaciones"
L["COMMAND_USAGE_4"] = "\"/ds <primary|secondary> <gear set>\", asignará la especialización a la equipación seleccionada"
L["CURRENT_SPEC"] = "Especialización actual"
L["DISPLAY_SPEC_NAME"] = "Mostrar nombre de especialización"
L["DISPLAY_SPEC_POINTS"] = "Mostrar los puntos de talentos"
L["GEAR_NOT_EXISTS"] = "Esa equipación no existe, usa \"/ds list\" para verlas"
L["GEAR_SETS"] = "Equipaciones"
L["HIDE_MINIMAP"] = "El icono del minimapa está oculto. Si quieres mostrarlo utilizar: \"/ds show\" (o /bds /brokerdualspec)"
L["IN_COMBAT"] = "Mientras estás en combate no puedes cambiar de especialización"
L["NO_GEAR_DEFINED"] = "No has elegido la equipación de esa especialización"
L["NO_GEAR_SETS"] = "No tienes una equipación establecida"
L["NOT_AVAILABLE"] = "No disponible"
L["OPTIONS"] = "Opciones"
L["PRIMARY_SPEC"] = "Primaria"
L["SECONDARY_SPEC"] = "Secundaria"
L["SHOW_HIDE_MINIMAP"] = "Mostrar/ocultar icono en el minimapa"
L["SWITCH_GEAR_TOO"] = "Cambiar de equipación también"
L["SWITCH_TO"] = "Cambiar a"
L["TOOLTIP_TIPS"] = "%sClick izquierdo:%s Cambiar de especialización y equipo si está permitido\n%sClick derecho:%s Muestra el menú de configuración";
L["WITH_GEAR_SET"] = "Con equipación"
end
