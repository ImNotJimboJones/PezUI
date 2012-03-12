--defaults enUS
TITAN_PETSTATUS_ID = "PetStatus";
TITAN_PETSTATUS_HAPPINESS_TABLE = {"|cffff0000", "|cff0863c3", "|cff10ff10"};
TITAN_PETSTATUS_EXP_TABLE = {"|cffff0000", "|cffff9c00", "|cffffff00", "|cffa800a8", "|cff10ff10"};
titanPetStatusCyanFont = "|cff00b1b1";
titanPetStatusLevelFont = "|cffF58CBA";

-- TITANPETSTATUS_VERSION = GetAddOnMetadata("TitanPetStatus", "Version"); test change
TITANPETSTATUS_TITLE = "Pet Status";
TITANPETSTATUS_UNKNOWN = "Unknown";
TITANPETSTATUS_EXP = "XP";
TITANPETSTATUS_FOOD = "Food";
TITANPETSTATUS_FEEDING = "Feeding";
TITANPETSTATUS_MAX = "Max.";
TITANPETSTATUS_MAXLEVEL = "Max Level Achieved";
TITANPETSTATUS_SHOWPETNAME = "Show pet name";
TITANPETSTATUS_SHOWPETLEVEL = "Show pet level";
TITANPETSTATUS_XP = "XP";
TITANPETSTATUS_SHOWHAPPINESS = "Show happiness";
TITANPETSTATUS_SHOWFEEDING = "Show feeding status";
TITANPETSTATUS_UNHAPPY = "Unhappy";
TITANPETSTATUS_CONTENT = "Content";
TITANPETSTATUS_HAPPY = "Happy";
TITANPETSTATUS_SHOWPETXP = "Show XP percent";
TITANPETSTATUS_DISMISSED = "Dismissed";
TITANPETSTATUS_STABLED = "Stabled";

--translate to Spanish where differences exist
--(*** Thanks to Fili for translations ***)
if (GetLocale() == "esES") then
TITANPETSTATUS_TITLE = "Estado Mascota";
TITANPETSTATUS_UNKNOWN = "Desconocida";
TITANPETSTATUS_FOOD = "Comida";
TITANPETSTATUS_FEEDING = "Alimentando";
TITANPETSTATUS_MAXLEVEL = "Max Nivel Archivado";
TITANPETSTATUS_SHOWPETNAME = "Muestra nombre Mascota";
TITANPETSTATUS_SHOWPETXP = "Muestra Porcentaje de XP";
TITANPETSTATUS_SHOWPETTRAINING = "Muestra entrenamiento de la mascota";
TITANPETSTATUS_SHOWPETLEVEL = "Muestra Nivel de Mascota";
TITANPETSTATUS_SHOWHAPPINESS = "Muestra felicidad";
TITANPETSTATUS_SHOWFEEDING = "Muestra estado de alimentaci\195\179n";
TITANPETSTATUS_UNHAPPY = "Infeliz";
TITANPETSTATUS_CONTENT = "Contento";
TITANPETSTATUS_HAPPY = "Feliz";
TITANPETSTATUS_DISMISSED = "Despedido";
TITANPETSTATUS_STABLED = "Estable";
end

--translate to German where differences exist
--(*** Thanks to Franca for the translations ***)
if (GetLocale() == "deDE") then
TITANPETSTATUS_TITLE = "Tierstatus";
TITANPETSTATUS_UNKNOWN = "Unbekannt";
TITANPETSTATUS_FOOD = "Futter";
TITANPETSTATUS_FEEDING = "F\195\188ttern";
TITANPETSTATUS_MAXLEVEL = "Max. Stufe erreicht";
TITANPETSTATUS_SHOWPETNAME = "Zeige Tiername";
TITANPETSTATUS_SHOWPETLEVEL = "Zeige Tierstufe";
TITANPETSTATUS_SHOWPETTRAINING = "Zeige Tierausbildung";
TITANPETSTATUS_SHOWHAPPINESS = "Zeige Zufriedenheit";
TITANPETSTATUS_SHOWFEEDING = "Zeige F\195\188tternstatus";
TITANPETSTATUS_UNHAPPY = "Unzufrieden";
TITANPETSTATUS_CONTENT = "Zufrieden";
TITANPETSTATUS_HAPPY = "Gl\195\188cklich";
end