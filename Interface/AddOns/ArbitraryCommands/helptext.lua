local nametag, addon = ...
addon.helptext = {}
local H = addon.helptext


H[""] = [[
Arbitrary Commands provides an easily configurable menu of scriptable commands.
The commands may be slash commands (like macros) or a block of Lua code (as if
you were writing a long /script).  The menu should be viewable via any LDB launcher;
by default it will appear as a clickable minimap icon.

Choosing +Main Menu> from the minimap menu, or typing "/arbit", will
show the main configuration window.  +Right-clicking> the minimap icon opens
to the "Scripts" tab directly.  The "Options" and "Profiles" tabs should be
self-explanatory; the "Scripts" tab is more interesting.

If you use the minimap menu, turning on Blizzard's +Beginner Tooltips> option
may be useful until you are accustomed to the addon.

More information is available at the Curse project page,
http://wow.curse.com/downloads/wow-addons/details/arbitcomm.aspx

To submit a bug report or suggestion, use the ticket tracker at
http://www.wowace.com/addons/arbitcomm/tickets/
]]


H["editor"] = [[
The "Scripts" tab in the configuration window manages and edits the menu layout
and script contents.  There are some example default scripts for new users; most
of them are/were used by the author.

Changes to any scripts are saved automatically upon closing the window or
clicking on another script in the left-hand list.  There is no in-game undo, so
edit with caution!

The radio-button option at the top-right allows you to specify verbose mode
for individual scripts, overriding the global verbose mode setting from the
main Options panel.
]]


H["slash"] = [[
If the first letter of a script is the forward slash ("/"), then the script is
run as if it were a slash command.  You can write multiple slash commands and
they will be run all at once, like a macro.  Be warned that unlike real macros,
these are not remotely stored on the Blizzard servers.

These "sort of macros" are not run in a +secure context> and therefore have no
special permissions; they cannot automatically target the nearest healer in an
arena, or do anything else that macros are incapable of doing.  At this time,
they cannot do /use or /cast commands; the author typically writes them to do
chat output.
]]


H["lua"] = [[
You can also write Lua scripts of arbitrary length and complexity.  These are
just like the lines of code in a "/script" or "/run" command.  If you stumble
across some while reading forums, you can drop them in here instead of trying
to wrap a /run macro around them.

Checking the "Use Lua editor" box will activate syntax highlighting and
reasonably smart automatic indentation.

These scripts are not run in a +secure context> and therefore have no special
permissions; they cannot automatically target the nearest healer in an arena,
or do anything else that addons are incapable of doing.
]]


H["morefuncs"] = [[
For ease of use, some additional Lua functions are available for scripting.  If
you find yourself wanting to embed slash commands in the middle of a Lua block,
these may help.

+CHAT ("chat_slash", "msg")|r

Examples: <CHAT("rw","Pulling in 5 seconds")>

<CHAT("2","Here's what I can craft: "..GetTradeSkillListLink())>

<CHAT("r","Thank you for your interest in our guild.  The website is www.example.com.")>

Strings usable as <chat_slash> are say/s, yell/y, party/p, raid/ra,
rw, bg, r (to reply to whispers), and valid numbers for public channels.  For
locales other than US English, the common slash commands for those chat types
should be included automatically.

+SLASH ("slash command")|r

Example: <SLASH("/dbm pull 5")>


I recommend you install an addon such as SlashIn from curse.com to provide the
/in command for delaying things like chat actions.
]]


H["registercomm"] = [[
Menus and menu entries can be programmatically added by other addons, using
a simple API.

The default example scripts included with Arbitrary Commands are in fact loaded
using this same API.  The file 'example_commands.lua' in the addon folder performs
the loading and contains full documentation.
]]


do
	local replacement_colors = {
		["+"]="|cff30adff",    -- nice blue
		["<"]="|cff00ff00",    -- greeeeeeen
		[">"]="|r",            -- close
	}
	for k,text in pairs(H) do
		local wrapped = text
		wrapped = wrapped:gsub ("[%+<>]", replacement_colors)
		wrapped = wrapped:gsub ("([^\n])\n([^\n])", "%1 %2")  -- join lines
		wrapped = wrapped:gsub ("|r\n\n", "|r\n")
		--wrapped = wrapped:gsub ("", "")
		H[k] = wrapped
	end
end

-- vim:noet
