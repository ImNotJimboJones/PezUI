--[=[
There are four methods used to control new entries.

    :ClearCommands()
    Erases all existing menu entries.  The menu is not in a very usable state
    after this, and should be populated with replacements.

    :RegisterMenu ("pathname")
    -  PATHNAME:  The name of the menu to add.  To add a submenu to an existing
         menu, use a path separated by '.' characters.

    :RegisterCommand ("pathname", "label", "script"))
    :RegisterCommand ("pathname", command_table)
    There are two forms of this function.  The first uses all default options
    for the new command entry; the second allows full option control.
    -  PATHNAME:  Either of
         (1) a string previously passed to RegisterMenu, to place the new command
             in an existing menu, or
         (2) nil or the empty string, to place the new command in the top level menu.
    -  LABEL:  The label to display in the dropdown menu.
    -  SCRIPT:  The contents of the new entry.
    -  COMMAND_TABLE:  A table with the following fields.  Optional fields may be left out.
        menulabel     [REQUIRED]  The label to display in the dropdown menu.
        script        [REQUIRED]  The contents of the new entry.
        tooltip       [OPTIONAL]  Only shows up if the player has enabled the Blizzard option
                                  to "show beginner tooltips".  Defaults to showing nothing.
        no_show       [OPTIONAL]  [boolean]  Toggles the "No Show" checkbox.  Default false.
        verbose       [OPTIONAL]  [boolean]  Overrides the global profile setting.

    :RefreshConfig()
    Updates the menus and script editor.  This only needs to be done once,
    after all :Register* calls.

Example:

    local ArbitComm = LibStub("AceAddon-3.0"):GetAddon("ArbitraryCommands")

    ArbitComm:ClearCommands()   -- leave this out to only add to the existing examples

    ArbitComm:RegisterCommand (nil, "Turn On Looped Zone Music",
        [[ SetCVar("Sound_EnableMusic","1"); SetCVar("Sound_ZoneMusicNoDelay","1") ]])

    ArbitComm:RegisterMenu("Favorite Emotes")
    ArbitComm:RegisterCommand ("Favorite Emotes", "Silly", "/silly")
    ArbitComm:RegisterCommand ("Favorite Emotes", "Dance", "/dance")

    ArbitComm:RegisterMenu("Favorite Emotes.PvP")
    ArbitComm:RegisterCommand ("Favorite Emotes.PvP", "Challenge 1", "/taunt")
    ArbitComm:RegisterCommand ("Favorite Emotes.PvP", "Challenge 2", "/chicken")
    ArbitComm:RegisterCommand ("Favorite Emotes.PvP", {
        menulabel = "Challenge 3",
        tooltip = "Remember to not spam this until Jimmy's ban is up.",
        script = "/spit",
    })

    ArbitComm:RegisterCommand (nil, "for trade chat",
        "DEFAULT_CHAT_FRAME:AddMessage(\"\\124cff71d5ff\\124Hspell:65311\\124h[Supermassive Fail]\\124h\\124r\")")

    ArbitComm:RefreshConfig()

The resulting menu looks like this:

    Turn On Looped Zone Music
    Favorite Emotes
    ->  Silly
    ->  Dance
    ->  PvP
        ->  Challenge 1
        ->  Challenge 2
        ->  Challenge 3
    for trade chat
    Main Menu

]=]

local addon = select(2,...)
function addon:register_default_commands()

addon:RegisterMenu "Labels"
addon:RegisterCommand("Labels", {
    menulabel = "PvP",
    tooltip = "Player and NPC nameplates on",
    script = [[
        SetCVar("UnitNameEnemyPlayerName","1")
        SetCVar("UnitNameFriendlyPlayerName","1")
        SetCVar("UnitNameNPC","1")
    ]],
})
addon:RegisterCommand("Labels", {
    menulabel = "Solo",
    tooltip = "Player nameplates off, NPC nameplates on",
    script = [[
        SetCVar("UnitNameEnemyPlayerName","0")
        SetCVar("UnitNameFriendlyPlayerName","0")
        SetCVar("UnitNameNPC","1")
    ]],
})
addon:RegisterCommand("Labels", {
    menulabel = "Raid/Healing",
    tooltip = "Player and NPC nameplates off",
    script = [[
        SetCVar("UnitNameEnemyPlayerName","0")
        SetCVar("UnitNameFriendlyPlayerName","0")
        SetCVar("UnitNameNPC","0")
    ]],
})


addon:RegisterCommand (nil, "Sound High", [[
    -- Frees up a keybinding for combat use
    SetCVar("Sound_MasterVolume","0.7")]])
addon:RegisterCommand (nil, "Sound Low", [[
    -- Frees up a keybinding for combat use
    SetCVar("Sound_MasterVolume","0.1")]])
addon:RegisterCommand (nil, "Toggle Music", [[
    -- Frees up a keybinding for combat use
    local v = GetCVar("Sound_EnableMusic")
    v = (v=="1") and "0" or "1"
    SetCVar("Sound_EnableMusic",v)]])

addon:RegisterMenu "sRaidFrames"
addon:RegisterCommand ("sRaidFrames", {
    menulabel = "sort by class",
    verbose = false,   -- sRF will print out a message anyhow
    script = [[sRaidFrames:SetCurrentGroupSetup("By class")]]
})
addon:RegisterCommand ("sRaidFrames", {
    menulabel = "sort by group",
    verbose = false,   -- sRF will print out a message anyhow
    script = [[sRaidFrames:SetCurrentGroupSetup("By group")]]
})

addon:RegisterCommand (nil, {
    menulabel = "BB raid toggle",
    verbose = false,  -- BigBrother prints out its own message
    script = [[
    -- do the actual toggle
    SLASH("/bb settings polyoutput raid")
    -- if it was toggled *on* then warn the silly rogues...
    if BigBrother.db.profile.PolyOut[3] then
        CHAT("ra", "CC-breaking shame mod enabled.  Improve your awareness!")
    end]],
})

end
-- vim:et
