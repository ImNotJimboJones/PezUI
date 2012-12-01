local L = LibStub("AceLocale-3.0"):NewLocale("Titan","itIT")
if not L then return end

L["TITAN_PANEL"] = "Titan Panel";
local TITAN_PANEL = "Titan Panel";
L["TITAN_DEBUG"] = "<Titan>";
L["TITAN_PRINT"] = "Titan";
     
L["TITAN_NA"] = "N/A";
L["TITAN_SECONDS"] = "secondi";
L["TITAN_MINUTES"] = "minuti";
L["TITAN_HOURS"] = "ore";
L["TITAN_DAYS"] = "giorni";
L["TITAN_SECONDS_ABBR"] = "s";
L["TITAN_MINUTES_ABBR"] = "m";
L["TITAN_HOURS_ABBR"] = "h";
L["TITAN_DAYS_ABBR"] = "d";
L["TITAN_MILLISECOND"] = "ms";
L["TITAN_KILOBYTES_PER_SECOND"] = "KB/s";
L["TITAN_KILOBITS_PER_SECOND"] = "kbps"
L["TITAN_MEGABYTE"] = "MB";
L["TITAN_NONE"] = "None";

L["TITAN_PANEL_ERROR_PROF_DELCURRENT"] = "Non puoi eliminare il profilo in uso.";
local TITAN_PANEL_WARNING = GREEN_FONT_COLOR_CODE.."Attenzione : "..FONT_COLOR_CODE_CLOSE
local TITAN_PANEL_RELOAD_TEXT = "Se vuoi continuare questa operazione premi 'Accetta' (la IU si ricaricherà); altrimenti premi 'Annulla' o il tasto Cancella."
L["TITAN_PANEL_RESET_WARNING"] = TITAN_PANEL_WARNING
	.."Questa impostazione reimposterà la tue barre e le impostazioni di "..TITAN_PANEL.." e ricreerà il tuo profilo corrente. "
	..TITAN_PANEL_RELOAD_TEXT
L["TITAN_PANEL_RELOAD"] = TITAN_PANEL_WARNING
	.."Questo ricaricherà "..TITAN_PANEL..". "
	..TITAN_PANEL_RELOAD_TEXT
L["TITAN_PANEL_ATTEMPTS"] = "Plugin registrati di "..TITAN_PANEL
L["TITAN_PANEL_ATTEMPTS_SHORT"] = "Plugin Registrati"
L["TITAN_PANEL_ATTEMPTS_DESC"] = "I plugin seguenti hanno richiesto di essere registrati su "..TITAN_PANEL..".\n"
	.."Invia qualsiasi segnalazione di problemi ai rispettivi autori dei plugin."
L["TITAN_PANEL_ATTEMPTS_TYPE"] = "Tipo"
L["TITAN_PANEL_ATTEMPTS_CATEGORY"] = "Categoria"
L["TITAN_PANEL_ATTEMPTS_BUTTON"] = "Nome Pulsante"
L["TITAN_PANEL_ATTEMPTS_STATUS"] = "Stato"
L["TITAN_PANEL_ATTEMPTS_ISSUE"] = "Problemi"
L["TITAN_PANEL_ATTEMPTS_NOTES"] = "Note"
L["TITAN_PANEL_ATTEMPTS_TABLE"] = "Indice tabella"
L["TITAN_PANEL_EXTRAS"] = TITAN_PANEL.." Extra"
L["TITAN_PANEL_EXTRAS_SHORT"] = "Extras"
L["TITAN_PANEL_EXTRAS_DESC"] = "Questi plugin hanno una configurazione ma non sono attivi in questo momento.\n"
	.."Possono essere eliminati tranquillamente."
L["TITAN_PANEL_EXTRAS_DELETE_BUTTON"] = "Elimina configurazione"
L["TITAN_PANEL_EXTRAS_DELETE_MSG"] = "la configuazione è stata rimossa."
L["TITAN_PANEL_CHARS"] = "Personaggi"
L["TITAN_PANEL_CHARS_DESC"] = "Questi sono personaggi che hanno una configurazione."
L["TITAN_PANEL_REGISTER_START"] = "Registrazione plugin di "..TITAN_PANEL.." in corso..."
L["TITAN_PANEL_REGISTER_END"] = "Registrazione plugins completata."

-- slash command help
L["TITAN_PANEL_SLASH_RESET_0"] = LIGHTYELLOW_FONT_COLOR_CODE.."Uso: |cffffffff/titan {reset | reset tipfont/tipalpha/panelscale/spacing}";
L["TITAN_PANEL_SLASH_RESET_1"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset: |cffffffffReimposta "..TITAN_PANEL.." ai valori/alle posizioni standard.";
L["TITAN_PANEL_SLASH_RESET_2"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset tipfont: |cffffffffReimposta "..TITAN_PANEL.." la scala dei font dei tooltip.";
L["TITAN_PANEL_SLASH_RESET_3"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset tipalpha: |cffffffffReimposta "..TITAN_PANEL.." la trasparenza dei font dei tooltip.";
L["TITAN_PANEL_SLASH_RESET_4"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset panelscale: |cffffffffReimposta "..TITAN_PANEL.." la scala.";
L["TITAN_PANEL_SLASH_RESET_5"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset spacing: |cffffffffReimposta "..TITAN_PANEL.." la spaziatura tra i pulsanti.";
L["TITAN_PANEL_SLASH_GUI_0"] = LIGHTYELLOW_FONT_COLOR_CODE.."Uso: |cffffffff/titan {gui control/trans/skin}";
L["TITAN_PANEL_SLASH_GUI_1"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui control: |cffffffffApre la finestra di controllo di "..TITAN_PANEL;
L["TITAN_PANEL_SLASH_GUI_2"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui trans: |cffffffffApre the finestra di controllo della trasparenza.";
L["TITAN_PANEL_SLASH_GUI_3"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui skin: |cffffffffApre the finestra di controllo degli skin.";
L["TITAN_PANEL_SLASH_PROFILE_0"] = LIGHTYELLOW_FONT_COLOR_CODE.."Uso: |cffffffff/titan {profile use <profile>}";
L["TITAN_PANEL_SLASH_PROFILE_1"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."profile use <name> <server>: |cffffffffImposta il profilo selezionando il profilo salvato richiesto.";
L["TITAN_PANEL_SLASH_PROFILE_2"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<name>: |cffffffffpuò essere il nome del personaggio o il nome personalizzato scelto."
L["TITAN_PANEL_SLASH_PROFILE_3"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<server>: |cffffffffpuò essere il nome del server o 'TitanCustomProfile'."
L["TITAN_PANEL_SLASH_HELP_0"] = LIGHTYELLOW_FONT_COLOR_CODE.."Uso: |cffffffff/titan {help | help <topic>}";
L["TITAN_PANEL_SLASH_HELP_1"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<topic>: reset/gui/profile/help ";
L["TITAN_PANEL_SLASH_ALL_0"] = LIGHTYELLOW_FONT_COLOR_CODE.."Uso: |cffffffff/titan <topic>";
L["TITAN_PANEL_SLASH_ALL_1"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<topic>: |cffffffffreset/gui/profile/help ";
    
-- slash command responses
L["TITAN_PANEL_SLASH_RESP1"] = LIGHTYELLOW_FONT_COLOR_CODE..TITAN_PANEL.." la scala del font dei tooltip è stata reimpostata.";
L["TITAN_PANEL_SLASH_RESP2"] = LIGHTYELLOW_FONT_COLOR_CODE..TITAN_PANEL.." la trasparenza dei tooltip è stata reimpostata.";
L["TITAN_PANEL_SLASH_RESP3"] = LIGHTYELLOW_FONT_COLOR_CODE..TITAN_PANEL.." la scala è stata reimpostata.";
L["TITAN_PANEL_SLASH_RESP4"] = LIGHTYELLOW_FONT_COLOR_CODE..TITAN_PANEL.." la spaziatura tra i bottoni è stata riempostata.";
     
-- global profile locale
L["TITAN_PANEL_GLOBAL"] = "Globale";     
L["TITAN_PANEL_GLOBAL_PROFILE"] = "Profilo Globale";     
L["TITAN_PANEL_GLOBAL_USE"] = "Usa profilo globale";     
L["TITAN_PANEL_GLOBAL_USE_AS"] = "Usa come profilo globale";     
L["TITAN_PANEL_GLOBAL_USE_DESC"] = "Usa un profilo che vale per tutti i personaggi";     
L["TITAN_PANEL_GLOBAL_RESET_PART"] = "resetting options";     
L["TITAN_PANEL_GLOBAL_ERR_1"] = "Non puoi caricare un profilo se stai usando un profilo globale";     

-- general panel locale
L["TITAN_PANEL_VERSION_INFO"] = "|cffffd700 by the |cffff8c00"..TITAN_PANEL.." Development Team";     
L["TITAN_PANEL_MENU_TITLE"] = TITAN_PANEL;
L["TITAN_PANEL_MENU_HIDE"] = "Nascondi";
L["TITAN_PANEL_MENU_IN_COMBAT_LOCKDOWN"] = "(In combattimento)";
L["TITAN_PANEL_MENU_RELOADUI"] = "(Ricarica l'IU)";
L["TITAN_PANEL_MENU_SHOW_COLORED_TEXT"] = "Mostra testo colorato";
L["TITAN_PANEL_MENU_SHOW_ICON"] = "Mostra icona";
L["TITAN_PANEL_MENU_SHOW_LABEL_TEXT"] = "Mostra testo";
L["TITAN_PANEL_MENU_AUTOHIDE"] = "Auto-Nascondi";
L["TITAN_PANEL_MENU_CENTER_TEXT"] = "Testo Centrale";
L["TITAN_PANEL_MENU_DISPLAY_BAR"] = "Mostra barra";
L["TITAN_PANEL_MENU_DISABLE_PUSH"] = "Disabilita adattamento allo schermo";
L["TITAN_PANEL_MENU_DISABLE_MINIMAP_PUSH"] = "Disabilita adattamento alla minimappa";
L["TITAN_PANEL_MENU_DISABLE_LOGS"] = "Adattamento automatico log";
L["TITAN_PANEL_MENU_DISABLE_BAGS"] = "Adattamento automatico borse";
L["TITAN_PANEL_MENU_DISABLE_TICKET"] = "Adattamento automatico alla finestra segnalazioni";
L["TITAN_PANEL_MENU_PROFILES"] = "Profili";
L["TITAN_PANEL_MENU_PROFILE"] = "Profilo ";
L["TITAN_PANEL_MENU_PROFILE_CUSTOM"] = "Personalizzato";
L["TITAN_PANEL_MENU_PROFILE_DELETED"] = " è stato eliminato.";
L["TITAN_PANEL_MENU_PROFILE_SERVERS"] = "Server";
L["TITAN_PANEL_MENU_PROFILE_CHARS"] = "Personaggio";
L["TITAN_PANEL_MENU_PROFILE_RELOADUI"] = "L'IU verrà ricaricata premento 'OK' per permettere il salvataggio del tuo profilo personalizzato.";
L["TITAN_PANEL_MENU_PROFILE_SAVE_CUSTOM_TITLE"] = "Inserisci un nome per il tuo profilo personalizzato:\n(20 caratteri massimo, spazi non permessii, case sensitive)";
L["TITAN_PANEL_MENU_PROFILE_SAVE_PENDING"] = "Le impostazioni in uso verranno salvate con il nome profilo: ";
L["TITAN_PANEL_MENU_PROFILE_ALREADY_EXISTS"] = "Il nome profilo inserito esiste già. Sei sicuro di volerlo sovrascrivere? Premi 'Accetta' se si, altrimenti premi 'Annulla' o il tasto 'Cancella.";
L["TITAN_PANEL_MENU_MANAGE_SETTINGS"] = "Gestisci";
L["TITAN_PANEL_MENU_LOAD_SETTINGS"] = "Carica";
L["TITAN_PANEL_MENU_DELETE_SETTINGS"] = "Elimina";
L["TITAN_PANEL_MENU_SAVE_SETTINGS"] = "Salva";
L["TITAN_PANEL_MENU_CONFIGURATION"] = "Configurazione";
L["TITAN_PANEL_OPTIONS"] = "Opzioni";
L["TITAN_PANEL_MENU_TOP"] = "In alto"
L["TITAN_PANEL_MENU_TOP2"] = "In alto 2"
L["TITAN_PANEL_MENU_BOTTOM"] = "In basso"
L["TITAN_PANEL_MENU_BOTTOM2"] = "In basso 2"
L["TITAN_PANEL_MENU_OPTIONS"] = "Tooltip e Finestre di "..TITAN_PANEL;
L["TITAN_PANEL_MENU_OPTIONS_SHORT"] = "Tooltip e Finestre";
L["TITAN_PANEL_MENU_TOP_BARS"] = "Barre in alto"
L["TITAN_PANEL_MENU_BOTTOM_BARS"] = "Barre in basso"
L["TITAN_PANEL_MENU_OPTIONS_BARS"] = "Barre"
L["TITAN_PANEL_MENU_OPTIONS_MAIN_BARS"] = "Barre in alto di "..TITAN_PANEL;
L["TITAN_PANEL_MENU_OPTIONS_AUX_BARS"] = "Barre in basso di "..TITAN_PANEL;
L["TITAN_PANEL_MENU_OPTIONS_TOOLTIPS"] = "Tooltip";
L["TITAN_PANEL_MENU_OPTIONS_FRAMES"] = "Finestre";
L["TITAN_PANEL_MENU_PLUGINS"] = "Plugins";
L["TITAN_PANEL_MENU_LOCK_BUTTONS"] = "Blocca Bottoni";
L["TITAN_PANEL_MENU_VERSION_SHOWN"] = "Visualizza le versioni dei plugin";
L["TITAN_PANEL_MENU_LDB_SIDE"] = "Plugin di destra";
L["TITAN_PANEL_MENU_LDB_FORCE_LAUNCHER"] = "Forza il posizionamento dei lanciatori LDB a destra";
L["TITAN_PANEL_MENU_CATEGORIES"] = {"Integrati","Generale","Combattimento","Informazione","Interfaccia","Professioni"}
L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN"] = "Mostra tooltip";
L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN_IN_COMBAT"] = "Nascondi tooltip in combattimento";
L["TITAN_PANEL_MENU_AUTOHIDE_IN_COMBAT"] = "Blocca le barre che si auto-nascondono in combattimento";
L["TITAN_PANEL_MENU_RESET"] = "Reimposta "..TITAN_PANEL;
L["TITAN_PANEL_MENU_TEXTURE_SETTINGS"] = "Skin";     
L["TITAN_PANEL_MENU_LSM_FONTS"] = "Font Finestre"
L["TITAN_PANEL_MENU_ENABLED"] = "Abilita";
L["TITAN_PANEL_MENU_DISABLED"] = "Disabilita";
L["TITAN_PANEL_SHIFT_LEFT"] = "Muovi a Sinistra";
L["TITAN_PANEL_SHIFT_RIGHT"] = "Muovi a Destra";
L["TITAN_PANEL_MENU_SHOW_PLUGIN_TEXT"] = "Mostra testo plugin";
L["TITAN_PANEL_MENU_BAR_ALWAYS"] = "Sempre accesa";
L["TITAN_PANEL_MENU_POSITION"] = "Posizione";
L["TITAN_PANEL_MENU_BAR"] = "Barra";
L["TITAN_PANEL_MENU_DISPLAY_ON_BAR"] = "Scegli in quale barra posizionare il plugin";
L["TITAN_PANEL_MENU_SHOW"] = "Mostra Plugin";
L["TITAN_PANEL_MENU_PLUGIN_RESET"] = "Ricarica Plugin";
L["TITAN_PANEL_MENU_PLUGIN_RESET_DESC"] = "Ricarica testo e posizione plugin";
    
-- localization strings for AceConfigDialog-3.0     
L["TITAN_ABOUT_VERSION"] = "Versione";
L["TITAN_ABOUT_AUTHOR"] = "Autore";
L["TITAN_ABOUT_CREDITS"] = "Crediti";
L["TITAN_ABOUT_CATEGORY"] = "Categoria";
L["TITAN_ABOUT_EMAIL"] = "Email";
L["TITAN_ABOUT_WEB"] = "Sito Web";
L["TITAN_ABOUT_LICENSE"] = "Licenza";
L["TITAN_PANEL_CONFIG_MAIN_LABEL"] = "Addon che visualizza delle barre di informazioni. Permette agli utenti di aggiungere dei plugin che vengono mostrati in barre nella parte alta e/o bassa dello schermo.";			 
L["TITAN_TRANS_MENU_TEXT"] = "Trasparenza di "..TITAN_PANEL;
L["TITAN_TRANS_MENU_TEXT_SHORT"] = "Trasparenza";
L["TITAN_TRANS_MENU_DESC"] = "Modifica trasparenza per le barre e i tooltip di "..TITAN_PANEL;		
L["TITAN_TRANS_MAIN_CONTROL_TITLE"] = "Barra principale";
L["TITAN_TRANS_AUX_CONTROL_TITLE"] = "Barra secondaria";
L["TITAN_TRANS_CONTROL_TITLE_TOOLTIP"] = "Tooltip";		 
L["TITAN_TRANS_TOOLTIP_DESC"] = "Imposta la trasparenza dei tooltip dei vari plugin.";
L["TITAN_UISCALE_MENU_TEXT"] = "Scala e Font di "..TITAN_PANEL;
L["TITAN_UISCALE_MENU_TEXT_SHORT"] = "Scala e Font";
L["TITAN_UISCALE_CONTROL_TITLE_UI"] = "Scala IU";
L["TITAN_UISCALE_CONTROL_TITLE_PANEL"] = "Scala di "..TITAN_PANEL;
L["TITAN_UISCALE_CONTROL_TITLE_BUTTON"] = "Spaziatura bottoni";
L["TITAN_UISCALE_CONTROL_TITLE_ICON"] = "Spaziatura icone";
L["TITAN_UISCALE_CONTROL_TOOLTIP_TOOLTIPFONT"] = "Scala del font dei tooltip";
L["TITAN_UISCALE_TOOLTIP_DISABLE_TEXT"] = "Disabilita la scala del font dei tooltip";		 
L["TITAN_UISCALE_MENU_DESC"] = "Controlla diversi aspetti dell'IU e di "..TITAN_PANEL..".";
L["TITAN_UISCALE_SLIDER_DESC"] = "Imposta la scala dell'intera IU.";
L["TITAN_UISCALE_PANEL_SLIDER_DESC"] = "Imposta la scala dei vari bottoni e icone di "..TITAN_PANEL..".";
L["TITAN_UISCALE_BUTTON_SLIDER_DESC"] = "Modifica lo spazio tra i plugin di sinistra.";
L["TITAN_UISCALE_ICON_SLIDER_DESC"] = "Modifica lo spazio tra i plugin di sinistra.";
L["TITAN_UISCALE_TOOLTIP_SLIDER_DESC"] = "Modifica la scala dei tooltip dei vari plugin.";
L["TITAN_UISCALE_DISABLE_TOOLTIP_DESC"] = "Disabilita il controllo della scala del font dei tooltip di "..TITAN_PANEL..".";

L["TITAN_SKINS_TITLE"] = "Skin di "..TITAN_PANEL;
L["TITAN_SKINS_OPTIONS_CUSTOM"] = "Skin Personalizzate";
L["TITAN_SKINS_TITLE_CUSTOM"] = "Skin personalizzate di "..TITAN_PANEL;
L["TITAN_SKINS_MAIN_DESC"] = "Tutti gli skin personalizzati devono trovarsi in: \n"
			.."..\\AddOns\\Titan\\Artwork\\Custom\\<Cartella Skin>\\ ".."\n"
			.."\nGli skin di "..TITAN_PANEL.." e quelli personalizzati si trovano nella cartella 'Custom'"
L["TITAN_SKINS_LIST_TITLE"] = "Lista Skin";
L["TITAN_SKINS_SET_DESC"] = "Scegli uno skin per le barre di "..TITAN_PANEL;
L["TITAN_SKINS_SET_HEADER"] = "Imposta lo skin di "..TITAN_PANEL;
L["TITAN_SKINS_RESET_HEADER"] = "Reimposta gli skin di "..TITAN_PANEL;
L["TITAN_SKINS_NEW_HEADER"] = "Aggiungi un nuovo skin";
L["TITAN_SKINS_NAME_TITLE"] = "Nome skin"
L["TITAN_SKINS_NAME_DESC"] = "Inserisci un nome per il nuovo skin. Verrà utilizzato nella lista degli skin.";
L["TITAN_SKINS_PATH_TITLE"] = "<Cartella Skin>"
L["TITAN_SKINS_PATH_DESC"] = "<Skin Folder> under the "..TITAN_PANEL.." install. See the example above." 
L["TITAN_SKINS_ADD_HEADER"] = "Aggiungi skin";
L["TITAN_SKINS_ADD_DESC"] = "Aggiunge un nuovo skin alla lista degli skin disponibili per "..TITAN_PANEL..".";
L["TITAN_SKINS_REMOVE_HEADER"] = "Rimuovi Skin";
L["TITAN_SKINS_REMOVE_DESC"] = "Scegli uno skin personalizzato da rimuovere."
L["TITAN_SKINS_REMOVE_BUTTON"] = "Rimuovi";
L["TITAN_SKINS_REMOVE_BUTTON_DESC"] = "Rimuove lo skin personalizzato scelto.";
L["TITAN_SKINS_REMOVE_NOTES"] = "Sei responsabile di rimuovere gli skin che non vuoi dalla cartella di installazione di "..TITAN_PANEL..". Agli addon non è permesso rimuovere file."
L["TITAN_SKINS_RESET_DEFAULTS_TITLE"] = "Reimposta ai valori standard";
L["TITAN_SKINS_RESET_DEFAULTS_DESC"] = "Reimposta la lista degli skin ai valori standard degli skin di "..TITAN_PANEL;
L["TITAN_PANEL_MENU_LSM_FONTS_DESC"] = "Scegli il tipo di font per i plugin delle barre di "..TITAN_PANEL..".";
L["TITAN_PANEL_MENU_FONT_SIZE"] = "Dimensione Font";
L["TITAN_PANEL_MENU_FONT_SIZE_DESC"] = "Imposta la dimensione dei font di "..TITAN_PANEL;
L["TITAN_PANEL_MENU_FRAME_STRATA"] = ""..TITAN_PANEL.." Frame Strata";
L["TITAN_PANEL_MENU_FRAME_STRATA_DESC"] = "Adjusts the frame strata for the "..TITAN_PANEL.." Bar(s).";
-- /end localization strings for AceConfigDialog-3.0

L["TITAN_PANEL_MENU_ADV"] = "Avanzate";
L["TITAN_PANEL_MENU_ADV_DESC"] = "Modifica i timer solo se hai problemi con finestre che non si posizionano correttamente.".."\n";
L["TITAN_PANEL_MENU_ADV_PEW"] = "Ingresso nel mondo";
L["TITAN_PANEL_MENU_ADV_PEW_DESC"] = "Modifica valore (di solito aumenta) se le finestre non si posizionano quando entri / esci dal mondo o da un istanza.";
L["TITAN_PANEL_MENU_ADV_VEHICLE"] = "Veicolo";
L["TITAN_PANEL_MENU_ADV_VEHICLE_DESC"] = "Modifica valore (di solito aumenta) se le finestre non si posizionano quando entri / esci in un veicolo.";
    
L["TITAN_AUTOHIDE_TOOLTIP"] = "Attiva/Disattiva la funzione Auto-Nascondi di "..TITAN_PANEL;
     
L["TITAN_BAG_FORMAT"] = "%d/%d";
L["TITAN_BAG_BUTTON_LABEL"] = "Zaino: ";
L["TITAN_BAG_TOOLTIP"] = "Info Zaino";
L["TITAN_BAG_TOOLTIP_HINTS"] = "Suggerimento: Click sinistro per aprire tutti gli zaini.";
L["TITAN_BAG_MENU_TEXT"] = "Zaino";
L["TITAN_BAG_USED_SLOTS"] = "Spazi Usati";
L["TITAN_BAG_FREE_SLOTS"] = "Spazi Liberi";
L["TITAN_BAG_BACKPACK"] = "Backpack";
L["TITAN_BAG_MENU_SHOW_USED_SLOTS"] = "Mostra spazi usati";
L["TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS"] = "Mostra spazi disponibili";
L["TITAN_BAG_MENU_SHOW_DETAILED"] = "Mostra tooltip dettagliato";
L["TITAN_BAG_MENU_IGNORE_SLOTS"] = "Ignora contenitori";
L["TITAN_BAG_MENU_IGNORE_PROF_BAGS_SLOTS"] = "Ignora zaini delle professioni";
L["TITAN_BAG_PROF_BAG_NAMES"] = {
-- Enchanting
"Enchanted Mageweave Pouch", "Enchanted Runecloth Bag", "Enchanter's Satchel", "Big Bag of Enchantment", "Spellfire Bag", 
"Mysterious Bag", "Otherworldly Bag", "\"Carriage - Exclusive\" Enchanting Evening Purse",
-- Engineering
"Heavy Toolbox", "Fel Iron Toolbox", "Titanium Toolbox", "Khorium Toolbox", "Elementium Toolbox", "\"Carriage - Maddy\" High Tech Bag",
-- Herbalism
"Herb Pouch", "Cenarion Herb Bag", "Satchel of Cenarius", "Mycah's Botanical Bag", "Emerald Bag", "Hyjal Expedition Bag",
"\"Carriage - Going Green\" Herb Tote Bag",
-- Inscription
"Scribe's Satchel", "Pack of Endless Pockets", "\"Carriage - Xandera\" Student's Satchel",
-- Jewelcrafting
"Gem Pouch", "Bag of Jewels", "\"Carriage - Exclusive\" Gem Studded Clutch",
-- Leatherworking
"Leatherworker's Satchel", "Bag of Many Hides", "Trapper's Traveling Pack", "\"Carriage - Meeya\" Leather Bag",
-- Mining
"Mining Sack", "Reinforced Mining Bag", "Mammoth Mining Bag", "\"Carriage - Christina\" Precious Metal Bag",
-- fishing
"Lure Master Tackle Box",
};

L["TITAN_CLOCK_TOOLTIP"] = "Orologio";     
L["TITAN_CLOCK_TOOLTIP_VALUE"] = "Offset ora server: ";
L["TITAN_CLOCK_TOOLTIP_LOCAL_TIME"] = "Ora locale: ";
L["TITAN_CLOCK_TOOLTIP_SERVER_TIME"] = "Ora server: ";
L["TITAN_CLOCK_TOOLTIP_SERVER_ADJUSTED_TIME"] = "Ora server corretta: ";
L["TITAN_CLOCK_TOOLTIP_HINT1"] = "Suggerimento: click sinistro per modificare l'offset dell'ora"
L["TITAN_CLOCK_TOOLTIP_HINT2"] = "(solo orario server) e formato ora 12/24.";
L["TITAN_CLOCK_TOOLTIP_HINT3"] = "Maiusc click sinistro per abilitare/disabilitare il calendario.";
L["TITAN_CLOCK_CONTROL_TOOLTIP"] = "Offset ora server: ";
L["TITAN_CLOCK_CONTROL_TITLE"] = "Offset";
L["TITAN_CLOCK_CONTROL_HIGH"] = "+12";
L["TITAN_CLOCK_CONTROL_LOW"] = "-12";
L["TITAN_CLOCK_CHECKBUTTON"] = "24H Fmt";
L["TITAN_CLOCK_CHECKBUTTON_TOOLTIP"] = "Scegle se visualizzare l'ora in formato 12/24 ore";
L["TITAN_CLOCK_MENU_TEXT"] = "Orologio";
L["TITAN_CLOCK_MENU_LOCAL_TIME"] = "Mostra ora locale (L)";
L["TITAN_CLOCK_MENU_SERVER_TIME"] = "Mostra ora server (S)";
L["TITAN_CLOCK_MENU_SERVER_ADJUSTED_TIME"] = "Mostra ora server corretta (A)";
L["TITAN_CLOCK_MENU_DISPLAY_ON_RIGHT_SIDE"] = "Mostra a destra";
L["TITAN_CLOCK_MENU_HIDE_GAMETIME"] = "Nascondi bottone ora/calendario";
L["TITAN_CLOCK_MENU_HIDE_MAPTIME"] = "Nascondi bottone ora";
L["TITAN_CLOCK_MENU_HIDE_CALENDAR"] = "Nascondi bottone calendario";
     
     
L["TITAN_COORDS_FORMAT"] = "(%.d, %.d)";
L["TITAN_COORDS_FORMAT2"] = "(%.1f, %.1f)";
L["TITAN_COORDS_FORMAT3"] = "(%.2f, %.2f)";
L["TITAN_COORDS_FORMAT_LABEL"] = "(xx , yy)";
L["TITAN_COORDS_FORMAT2_LABEL"] = "(xx.x , yy.y)";
L["TITAN_COORDS_FORMAT3_LABEL"] = "(xx.xx , yy.yy)";
L["TITAN_COORDS_FORMAT_COORD_LABEL"] = "Coordinate Format";
L["TITAN_COORDS_BUTTON_LABEL"] = "Loc: ";
L["TITAN_COORDS_TOOLTIP"] = "Location Info";
L["TITAN_COORDS_TOOLTIP_HINTS_1"] = "Hint: Shift + left-click to add location";
L["TITAN_COORDS_TOOLTIP_HINTS_2"] = "info to the chat message.";
L["TITAN_COORDS_TOOLTIP_ZONE"] = "Zone: ";
L["TITAN_COORDS_TOOLTIP_SUBZONE"] = "SubZone: ";
L["TITAN_COORDS_TOOLTIP_PVPINFO"] = "PVP Info: ";
L["TITAN_COORDS_TOOLTIP_HOMELOCATION"] = "Home Location";
L["TITAN_COORDS_TOOLTIP_INN"] = "Inn: ";
L["TITAN_COORDS_MENU_TEXT"] = "Location";
L["TITAN_COORDS_MENU_SHOW_ZONE_ON_PANEL_TEXT"] = "Show Zone Text";
L["TITAN_COORDS_MENU_SHOW_COORDS_ON_MAP_TEXT"] = "Show Coordinates on World Map";
L["TITAN_COORDS_MAP_CURSOR_COORDS_TEXT"] = "Cursor: %s";
L["TITAN_COORDS_MAP_PLAYER_COORDS_TEXT"] = "Player: %s";
L["TITAN_COORDS_NO_COORDS"] = "No Coords";
L["TITAN_COORDS_MENU_SHOW_LOC_ON_MINIMAP_TEXT"] = "Show Location Name Above Minimap";
L["TITAN_COORDS_MENU_UPDATE_WORLD_MAP"] = "Update World Map When Zone Changes";
     
L["TITAN_FPS_FORMAT"] = "%.1f";
L["TITAN_FPS_BUTTON_LABEL"] = "FPS: ";
L["TITAN_FPS_MENU_TEXT"] = "FPS";
L["TITAN_FPS_TOOLTIP_CURRENT_FPS"] = "Current FPS: ";
L["TITAN_FPS_TOOLTIP_AVG_FPS"] = "Average FPS: ";
L["TITAN_FPS_TOOLTIP_MIN_FPS"] = "Minimum FPS: ";
L["TITAN_FPS_TOOLTIP_MAX_FPS"] = "Maximum FPS: ";
L["TITAN_FPS_TOOLTIP"] = "Frames Per Second";
     
L["TITAN_LATENCY_FORMAT"] = "%d".."ms";
L["TITAN_LATENCY_BANDWIDTH_FORMAT"] = "%.3f ".."KB/s";
L["TITAN_LATENCY_BUTTON_LABEL"] = "Latency: ";
L["TITAN_LATENCY_TOOLTIP"] = "Network Status";
L["TITAN_LATENCY_TOOLTIP_LATENCY_HOME"] = "Realm Latency (home): ";
L["TITAN_LATENCY_TOOLTIP_LATENCY_WORLD"] = "Game Latency (world): ";
L["TITAN_LATENCY_TOOLTIP_BANDWIDTH_IN"] = "Bandwidth In: ";
L["TITAN_LATENCY_TOOLTIP_BANDWIDTH_OUT"] = "Bandwidth Out: ";
L["TITAN_LATENCY_MENU_TEXT"] = "Latency";
     
L["TITAN_LOOTTYPE_BUTTON_LABEL"] = "Loot: ";
L["TITAN_LOOTTYPE_FREE_FOR_ALL"] = "Free For All";
L["TITAN_LOOTTYPE_ROUND_ROBIN"] = "Round Robin";
L["TITAN_LOOTTYPE_MASTER_LOOTER"] = "Master Looter";
L["TITAN_LOOTTYPE_GROUP_LOOT"] = "Group Loot";
L["TITAN_LOOTTYPE_NEED_BEFORE_GREED"] = "Need Before Greed";
L["TITAN_LOOTTYPE_TOOLTIP"] = "Loot Type Info";
L["TITAN_LOOTTYPE_MENU_TEXT"] = "Loot Type";
L["TITAN_LOOTTYPE_RANDOM_ROLL_LABEL"] = "Random Roll";
L["TITAN_LOOTTYPE_TOOLTIP_HINT1"] = "Hint: Left-click for random roll.";
L["TITAN_LOOTTYPE_TOOLTIP_HINT2"] = "Select roll type from right-click menu.";
L["TITAN_LOOTTYPE_DUNGEONDIFF_LABEL"] = "Dungeon Difficulty";
L["TITAN_LOOTTYPE_DUNGEONDIFF_LABEL2"] = "Raid Difficulty";
L["TITAN_LOOTTYPE_SHOWDUNGEONDIFF_LABEL"] = "Show Dungeon/Raid Difficulty";
L["TITAN_LOOTTYPE_SETDUNGEONDIFF_LABEL"] = "Set Dungeon Difficulty";
L["TITAN_LOOTTYPE_SETRAIDDIFF_LABEL"] = "Set Raid Difficulty";
L["TITAN_LOOTTYPE_AUTODIFF_LABEL"] = "Auto (Group Based)";
     
L["TITAN_MEMORY_FORMAT"] = "%.3f".."MB";
L["TITAN_MEMORY_FORMAT_KB"] = "%d".."KB";
L["TITAN_MEMORY_RATE_FORMAT"] = "%.3f".."KB/s";
L["TITAN_MEMORY_BUTTON_LABEL"] = "Memory: ";
L["TITAN_MEMORY_TOOLTIP"] = "Memory Usage";
L["TITAN_MEMORY_TOOLTIP_CURRENT_MEMORY"] = "Current: ";
L["TITAN_MEMORY_TOOLTIP_INITIAL_MEMORY"] = "Initial: ";
L["TITAN_MEMORY_TOOLTIP_INCREASING_RATE"] = "Increasing Rate: ";
L["TITAN_MEMORY_KBMB_LABEL"] = "KB/MB";     
     
--L["TITAN_MONEY_GOLD"] = "g";
--L["TITAN_MONEY_SILVER"] = "s";
--L["TITAN_MONEY_COPPER"] = "c";
L["TITAN_MONEY_FORMAT"] = "%d".."g"..", %02d".."s"..", %02d".."c";
     
L["TITAN_PERFORMANCE_TOOLTIP"] = "Performance Info";
L["TITAN_PERFORMANCE_MENU_TEXT"] = "Performance";
L["TITAN_PERFORMANCE_ADDONS"] = "Addon Usage";
L["TITAN_PERFORMANCE_ADDON_MEM_USAGE_LABEL"] = "Addon Memory Usage";
L["TITAN_PERFORMANCE_ADDON_MEM_FORMAT_LABEL"] = "Addon Memory Format";
L["TITAN_PERFORMANCE_ADDON_CPU_USAGE_LABEL"] = "Addon CPU Usage";
L["TITAN_PERFORMANCE_ADDON_NAME_LABEL"] = "Name:";
L["TITAN_PERFORMANCE_ADDON_USAGE_LABEL"] = "Usage";
L["TITAN_PERFORMANCE_ADDON_RATE_LABEL"] = "Rate";
L["TITAN_PERFORMANCE_ADDON_TOTAL_MEM_USAGE_LABEL"] = "Total Addon Memory:";
L["TITAN_PERFORMANCE_ADDON_TOTAL_CPU_USAGE_LABEL"] = "Total CPU Time:";
L["TITAN_PERFORMANCE_MENU_SHOW_FPS"] = "Show FPS";
L["TITAN_PERFORMANCE_MENU_SHOW_LATENCY"] = "Show Realm Latency";
L["TITAN_PERFORMANCE_MENU_SHOW_LATENCY_WORLD"] = "Show Game Latency";
L["TITAN_PERFORMANCE_MENU_SHOW_MEMORY"] = "Show Memory";
L["TITAN_PERFORMANCE_MENU_SHOW_ADDONS"] = "Show Addon Memory Usage";
L["TITAN_PERFORMANCE_MENU_SHOW_ADDON_RATE"] = "Show Addon Usage Rate";
L["TITAN_PERFORMANCE_MENU_CPUPROF_LABEL"] = "CPU Profiling Mode";
L["TITAN_PERFORMANCE_MENU_CPUPROF_LABEL_ON"] = "Enable CPU Profiling Mode ";
L["TITAN_PERFORMANCE_MENU_CPUPROF_LABEL_OFF"] = "Disable CPU Profiling Mode ";
L["TITAN_PERFORMANCE_CONTROL_TOOLTIP"] = "Monitored Addons: ";
L["TITAN_PERFORMANCE_CONTROL_TITLE"] = "Monitored Addons";
L["TITAN_PERFORMANCE_CONTROL_HIGH"] = "40";
L["TITAN_PERFORMANCE_CONTROL_LOW"] = "1";
L["TITAN_PERFORMANCE_TOOLTIP_HINT"] = "Hint: Left-click to force a garbage collection.";
		     
L["TITAN_XP_FORMAT"] = "%d";
L["TITAN_XP_PERCENT_FORMAT"] = "%d".." (%.1f%%)";
L["TITAN_XP_BUTTON_LABEL_XPHR_LEVEL"] = "XP/hr This Level: ";
L["TITAN_XP_BUTTON_LABEL_XPHR_SESSION"] = "XP/hr This Session: ";
L["TITAN_XP_BUTTON_LABEL_TOLEVEL_TIME_LEVEL"] = "Time To Level: ";
L["TITAN_XP_LEVEL_COMPLETE"] = "Level Complete: ";
L["TITAN_XP_TOTAL_RESTED"] = "Rested: ";
L["TITAN_XP_XPTOLEVELUP"] = "XP To Level: ";
L["TITAN_XP_TOOLTIP"] = "XP Info";
L["TITAN_XP_TOOLTIP_TOTAL_TIME"] = "Total Time Played: ";
L["TITAN_XP_TOOLTIP_LEVEL_TIME"] = "Time Played This Level: ";
L["TITAN_XP_TOOLTIP_SESSION_TIME"] = "Time Played This Session: ";
L["TITAN_XP_TOOLTIP_TOTAL_XP"] = "Total XP Required This Level: ";
L["TITAN_XP_TOOLTIP_LEVEL_XP"] = "XP Gained This Level: ";
L["TITAN_XP_TOOLTIP_TOLEVEL_XP"] = "XP Needed To Level: ";
L["TITAN_XP_TOOLTIP_SESSION_XP"] = "XP Gained This Session: ";
L["TITAN_XP_TOOLTIP_XPHR_LEVEL"] = "XP/HR This Level: ";
L["TITAN_XP_TOOLTIP_XPHR_SESSION"] = "XP/HR This Session: ";     
L["TITAN_XP_TOOLTIP_TOLEVEL_LEVEL"] = "Time To Level (Level Rate): ";
L["TITAN_XP_TOOLTIP_TOLEVEL_SESSION"] = "Time To Level (Session Rate): ";
L["TITAN_XP_MENU_TEXT"] = "XP";
L["TITAN_XP_MENU_SHOW_XPHR_THIS_LEVEL"] = "Show XP/HR This Level";
L["TITAN_XP_MENU_SHOW_XPHR_THIS_SESSION"] = "Show XP/HR This Session";
L["TITAN_XP_MENU_SHOW_RESTED_TOLEVELUP"] = "Show Multi-Info View";
L["TITAN_XP_MENU_SIMPLE_BUTTON_TITLE"] = "Button";
L["TITAN_XP_MENU_SIMPLE_BUTTON_RESTED"] = "Show Rested XP";
L["TITAN_XP_MENU_SIMPLE_BUTTON_TOLEVELUP"] = "Show XP To Level";
L["TITAN_XP_MENU_SIMPLE_BUTTON_KILLS"] = "Show Estimated Kills To Level";
L["TITAN_XP_MENU_RESET_SESSION"] = "Reset Session";
L["TITAN_XP_MENU_REFRESH_PLAYED"] = "Refresh Timers";
L["TITAN_XP_UPDATE_PENDING"] = "Updating...";
L["TITAN_XP_KILLS_LABEL"] = "Kills To Level (at %d XP gained last): ";
L["TITAN_XP_KILLS_LABEL_SHORT"] = "Est. Kills: ";
L["TITAN_XP_BUTTON_LABEL_SESSION_TIME"] = "Session Time: ";
L["TITAN_XP_MENU_SHOW_SESSION_TIME"] = "Show Session Time";
L["TITAN_XP_GAIN_PATTERN"] = "(.*) dies, you gain (%d+) experience.";
L["TITAN_XP_XPGAINS_LABEL_SHORT"] = "Est. Gains: ";
L["TITAN_XP_XPGAINS_LABEL"] = "XP Gains To Level (at %d XP gained last): ";
L["TITAN_XP_MENU_SIMPLE_BUTTON_XPGAIN"] = "Show Estimated XP Gains To Level";

     --Titan Repair
     L["REPAIR_LOCALE"] = {
          pattern = "^Integrità (%d+) / (%d+)$",
          menu = "Repair",
          tooltip = "Repair Info",
          button = "Durability: ",
          normal = "Repair Cost (Normal): ",
          friendly = "Repair Cost (Friendly): ",
          honored = "Repair Cost (Honored): ",
          revered = "Repair Cost (Revered): ",
          exalted = "Repair Cost (Exalted): ",
          buttonNormal = "Show Normal",
          buttonFriendly = "Show Friendly (5%)",
          buttonHonored = "Show Honored (10%)",
          buttonRevered = "Show Revered (15%)",
          buttonExalted = "Show Exalted (20%)",
          percentage = "Show as Percentage",
          itemnames = "Show Item Names",
          mostdamaged = "Show Most Damaged",
          showdurabilityframe = "Show Durability Frame",
          undamaged = "Show Undamaged Items",
          discount = "Discount",
          nothing = "Nothing Damaged",
          confirmation = "Do you want to repair all items ?",
          badmerchant = "This merchant cannot repair. Displaying normal repair costs instead.",
          popup = "Show Repair Popup",
          showinventory = "Calculate Inventory Damage",
          WholeScanInProgress = "Updating...",
          AutoReplabel = "Auto-Repair",
          AutoRepitemlabel = "Auto Repair All Items",
          ShowRepairCost = "Show Repair Cost",
		  		ignoreThrown = "Ignore Thrown",
		  		ShowItems = "Show Items",
		  		ShowDiscounts = "Show Discounts",
		  		ShowCosts = "Show Costs",
		  		Items = "Items",
		  		Discounts = "Discounts",
		  		Costs = "Costs",
				CostTotal = "Total Cost",
				CostBag = "Bag Cost",
				CostEquip = "Equip Cost",
 				TooltipOptions = "Tooltip",
    };
     
     L["TITAN_REPAIR"] = "Titan Repair"
     L["TITAN_REPAIR_GBANK_TOTAL"] = "Guild Bank Funds :"
     L["TITAN_REPAIR_GBANK_WITHDRAW"] = "Guild Bank Withdrawal Allowed :"
     L["TITAN_REPAIR_GBANK_USEFUNDS"] = "Use Guild Bank Funds"
     L["TITAN_REPAIR_GBANK_NOMONEY"] = "Guild Bank can't afford the repair cost, or you can't withdraw that much."
     L["TITAN_REPAIR_GBANK_NORIGHTS"] = "You are either not in a guild or you don't have permission to use the guild bank to repair your items."
     L["TITAN_REPAIR_CANNOT_AFFORD"] = "You cannot afford to repair, at this time."
     L["TITAN_REPAIR_REPORT_COST_MENU"] = "Report Repair Cost to Chat"
     L["TITAN_REPAIR_REPORT_COST_CHAT"] = "Repair cost was "
     
--L["TITAN_PLUGINS_MENU_TITLE"] = "Plugins";

L["TITAN_GOLD_TOOLTIPTEXT"] = "Total Gold on";
L["TITAN_GOLD_ITEMNAME"] = "Titan Gold";
L["TITAN_GOLD_CLEAR_DATA_TEXT"] = "Clear Database";
L["TITAN_GOLD_RESET_SESS_TEXT"] = "Reset Current Session";
L["TITAN_GOLD_DB_CLEARED"] = "Titan Gold - Database Cleared.";
L["TITAN_GOLD_SESSION_RESET"] = "Titan Gold - Session Reset.";
L["TITAN_GOLD_MENU_TEXT"] = "Gold";
L["TITAN_GOLD_TOOLTIP"] = "Gold Info";
L["TITAN_GOLD_TOGGLE_PLAYER_TEXT"] = "Display Player Gold";
L["TITAN_GOLD_TOGGLE_ALL_TEXT"] = "Display Server Gold";
L["TITAN_GOLD_SESS_EARNED"] = "Earned This Session";
L["TITAN_GOLD_PERHOUR_EARNED"] = "Earned Per Hour";
L["TITAN_GOLD_SESS_LOST"] = "Lost This Session";
L["TITAN_GOLD_PERHOUR_LOST"] = "Lost Per Hour";
L["TITAN_GOLD_STATS_TITLE"] = "Session Statistics";
L["TITAN_GOLD_TTL_GOLD"] = "Total Gold";
L["TITAN_GOLD_START_GOLD"] = "Starting Gold";
L["TITAN_GOLD_TOGGLE_SORT_GOLD"] = "Sort Table By Gold";
L["TITAN_GOLD_TOGGLE_SORT_NAME"] = "Sort Gold By Name";
L["TITAN_GOLD_TOGGLE_GPH_SHOW"] = "Display Gold Per Hour";
L["TITAN_GOLD_TOGGLE_GPH_HIDE"] = "Hide Gold Per Hour";
L["TITAN_GOLD_GOLD"] = "g";
L["TITAN_GOLD_SILVER"] = "s";
L["TITAN_GOLD_COPPER"] = "c";
L["TITAN_GOLD_STATUS_PLAYER_SHOW"] = "Visible";
L["TITAN_GOLD_STATUS_PLAYER_HIDE"] = "Hidden";
L["TITAN_GOLD_DELETE_PLAYER"] = "Delete Toon";
L["TITAN_GOLD_SHOW_PLAYER"] = "Show Toon";
L["TITAN_GOLD_FACTION_PLAYER_ALLY"] = "Alliance";
L["TITAN_GOLD_FACTION_PLAYER_HORDE"] = "Horde";
L["TITAN_GOLD_CLEAR_DATA_WARNING"] = GREEN_FONT_COLOR_CODE.."Warning: "
..FONT_COLOR_CODE_CLOSE.."This setting will wipe your Titan Gold database. "
.."If you wish to continue with this operation, push 'Accept', otherwise push 'Cancel' or the 'Escape' key.";
L["TITAN_GOLD_COIN_NONE"] = "Show No Labels";
L["TITAN_GOLD_COIN_LABELS"] = "Show Text Labels";
L["TITAN_GOLD_COIN_ICONS"] = "Show Icon Labels";
L["TITAN_GOLD_ONLY"] = "Show Gold Only";
L["TITAN_GOLD_COLORS"] = "Show Gold Colors";
L["TITAN_USE_COMMA"] = "Use comma";
L["TITAN_USE_PERIOD"] = "Use period";


L["TITAN_VOLUME_TOOLTIP"] = "Volume Info";
L["TITAN_VOLUME_MASTER_TOOLTIP_VALUE"] = "Master Sound Volume: ";
L["TITAN_VOLUME_SOUND_TOOLTIP_VALUE"] = "Effects Sound Volume: ";
L["TITAN_VOLUME_AMBIENCE_TOOLTIP_VALUE"] = "Ambience Sound Volume: ";
L["TITAN_VOLUME_MUSIC_TOOLTIP_VALUE"] = "Music Sound Volume: ";
L["TITAN_VOLUME_MICROPHONE_TOOLTIP_VALUE"] = "Microphone Sound Volume: ";
L["TITAN_VOLUME_SPEAKER_TOOLTIP_VALUE"] = "Speaker Sound Volume: ";
L["TITAN_VOLUME_TOOLTIP_HINT1"] = "Hint: Left-click to adjust the"
L["TITAN_VOLUME_TOOLTIP_HINT2"] = "sound volume.";
L["TITAN_VOLUME_CONTROL_TOOLTIP"] = "Volume Control: ";
L["TITAN_VOLUME_CONTROL_TITLE"] = "Volume Control";
L["TITAN_VOLUME_MASTER_CONTROL_TITLE"] = "Master";
L["TITAN_VOLUME_SOUND_CONTROL_TITLE"] = "Effects";
L["TITAN_VOLUME_AMBIENCE_CONTROL_TITLE"] = "Ambience";
L["TITAN_VOLUME_MUSIC_CONTROL_TITLE"] = "Music";
L["TITAN_VOLUME_MICROPHONE_CONTROL_TITLE"] = "Microphone";
L["TITAN_VOLUME_SPEAKER_CONTROL_TITLE"] = "Speaker";
L["TITAN_VOLUME_CONTROL_HIGH"] = "High";
L["TITAN_VOLUME_CONTROL_LOW"] = "Low";
L["TITAN_VOLUME_MENU_TEXT"] = "Volume Control";
L["TITAN_VOLUME_MENU_AUDIO_OPTIONS_LABEL"] = "Show Sound/Voice Options" ;
L["TITAN_VOLUME_MENU_OVERRIDE_BLIZZ_SETTINGS"] = "Override Blizzard Volume Settings";
