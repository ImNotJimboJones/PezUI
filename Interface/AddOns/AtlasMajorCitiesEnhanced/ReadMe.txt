A short introduction to the edit mode (see at beginning of AtlasMajorCities.lua to enable it):

Commands:
---------

/amc [help / reload / revert / copydbtouser / on / all / pos / sign / npc / off]
  copydbtouser - copy all the DBs to the user space, overwrite all changes made - the internal DB can now be modified by the user
  reload - load the user DB to Atlas
  revert - load the internal DB to Atlas
  on - activate the default editing mode which allow all renamings
       (/amcz (renaming only), /amca, /amct, /amcc, sign, NPC)
  all - activate all changes
  pos - activate all changes, exept sign, and NPC (no first person mode)
  sign - activate the scanning of signs and NPCs (/amcc, sign, NPC)
  npc - activate the scanning of NPCs only (no first person mode)
  off - deactivate scanning mode (now you can leave the first person view)

/amcz [{zone name} / delete]
  Create the DB entry for the actual zone and set the continent, city, and zone name.
  The name of the city is displayed at the pull-down menu of atlas, and forms from the city name itself, the city faction, and the race of a char in the target, if any.
  Default is to uses the name displayed over the minimap as zone name, but you can also give {zone name} manually.
  The option delete remove the zone name.

/amca [none]
  Activate the shop at the actual label position for modifications.
  You optional give "none" to define the "no position" shop (see below).

/amcp [none / delete / nonedelete]
  Setup a new shop at the actual position, and ask for a label for it. The label is shown at the map, right at your actual position. So, check your position at the map if the label would be right there, because the map is not always identical to the minimap.
  If there already exist a shop at your position, you only move the label to your actual position.
  You optional give "none" to create the "no position" shop (see below).
  With "delete" you remove the active shop. Check that you assigned the right shop with /amca.
  With "nonedelete" you remove the "no position" shop (see below).

/amcl [{label}]
  Change the label of the active shop. Activate the shop with /amca or /amcp.
  If {label} is not given, a popup window will open.

/amcs
  Add the empty shop sign at the actual position to the active shop. Use /amca to activate the shop at the label position. The name from the sign is set separately (see below). Shop signs are identified by the position on the map.

/amct [{shop comment}]
  Set or change the comment to a shop. Shop titles from shop signs are shown between "*" in the list, Shop comments are enclosed in "." to separate and identify them.
  If {shop comment} is not given, a popup window will open. This popup window is filled with the old shop comment, the tooltip text, or the minimap title.

/amcc [{NPC comment}]
  Set a comment to a NPC, displayed in brackets behind the NPC in the list.
  If {NPC comment} is not given, a popup window will open. This popup window is filled with the old NPC comment.

mouse over sign and CTRL+Shift
  To get the text from a shop sign, move the mouse over the sign and press CTRL+Shift. You have to activate a appropriate scan mode with /amc.
  The map is subdivided into a grid, to define the position of the signs. If the sign is located near the border of such a grid cell, a part of it is not at the right position, and not identified as the right sign. So, if the shop sign is not find, try to move the mouse to the other side of the sign. Signs are also only scanned up to a special distance, so you have to go near the sign. Some time it helps also to change your angle to the sign, because signs are not symmetric.

mouse over NPC target frame
  To add a NPC to a shop, activate a shop with /amca or /amcp, take the NPC in target and move the mouse over the target window. You have to activate a appropriate scan mode with /amc. I the NPC is already assigned to a shop, only its name is refreshed.
  If you are in the npc-mode (setup with /amc), you refresh only the description of an already assigned NPC, i.e. for localization.

Explanations:
-------------

To all actions a status message is displayed at the chat window.

The "no position" shop is a shop with no defined position. Its used to show NPCs at the list, which have no fixed position to show a label, i.e. the NPC walk around. The label shown at list defaults to "-", if no label is set.

If a shop has only a label, but no description and NPCs, it is not shown at the list. This way the letter box is labeled (with the predefined label "@").

The slash-commands are also included in the key bindings, so you can assign a key to every function. But to use an option the slash command is needed.

The option strings can be loclalized in AtlasMajorCities_loc.lua.

Why the first person mode: To identify the signs at its position, the first person mode is needed, because it is not possible anymore to get the data of the player camera. One only get the viewing angle of the player and the display position of the mouse. In the first person mode it is still possible to get the position, where the mouse points to, to identify the sign at the mouse position.
