1. About the plugin
===================
Titan Panel [Quests] (or short: Titan Quests) is a plugin for the WoW addon Titan Panel. It was originally developed by Corgi/Ryessa with smaller updates being done by PcHaXoR and r3neGaDe and then taken over by urnati for about 2 years.

Titan Quests adds a new button to Titan Panel, granting direct access to the quest list and some quest-related functionality.

1.1 Features
============
* adds a quest icon to Titan Panel, showing the number of completed/total quests
* shows detailed quest statistic on mouse-over (number of elite quests, pvp quests,...)
* shows a quest list of all currently accepted quests upon right-clicking the Titan Quests icon
* shows detailed quest information when mousing over a quest in the quest list
* allows to add/remove quests from the quest watcher by left-clicking on a quest in the quest list
* shortcut to open/close the quest log by left-clicking on the Titan Quests icon
* customizable elements (all visible elements can be configured)
* little performance impact on the game (only performs updates, when quest-related events occur)
* complete English/German translation, partial French/Spanish/Latin American/Russian translation - more languages can be supported with help from volunteers
* high code quality (due to use of automated tests, profiling, bug tracking, a clean architectural design and a beta release schedule prior to the release of each version)

2. Introduction
===============
After successful installation of the plugin, you'll see a new icon in the Titan Panel. By moving the mouse over that icon, a summary of the current quests is displayed (see "2.1 Titan Panel Tooltip").
By right-clicking onto the icon, a detailed questlist pops up, which presents the name, level and current state of each quest (see "2.2 Questlist").
Mousing over one of these quests opens up a quest-menu which presents a comprehensive summary of the quest as well as further options like abandoning the quest, sharing it, or adding it to the watch list (see "2.3 Questdetails").
Last but not least can the display of Titan Quests be customized via the options dialog (see "2.4 Options").

2.1. Titan Panel Tooltip
============================
The Titan Quests button on the Titan Panel displays the number of completed and total quests. By mousing over, a tooltip displaying the following information is shown:
- total number of quests
- the total number of quests split up into the number of quests by category (elite, group, regular, etc.) - the prefix representing the category is displayed in brackets (this prefix is used in the questlist --- see "2.2 Questlist")
- number of daily quests
- number of completed quests
- number of incomplete quests
- the time when the raid instances will reset
- some hints explaining the possible interactions with the Titan Quests button.

By left-clicking onto the Titan Quests button the questlog is brought up.
By right-clicking onto the button the questlist is displayed (see 2.2 Questlist).

2.2 Questlist
=============
The first entry in the questlist is the option dialog (see "2.4 Options").
This is followed by the list of quests (if no quests match the selected filter or the player has no quests at all a message is displayed instead of the actual questlist).
The questlist is structured the following way:
The number, which is colored according to the difficulty, represents the questlevel. It is followed by the questprefix representing the quest category. The following prefixes can appear (note that different localizations can use different prefixes):
"+" = elite quests
"g" = group quests
"h" = heroic quests
"d" = dungeon quests
"r" = raid quests
"p" = PvP quests
If no prefix is displayed, the quest is a regular quest.

The quest category prefix is followed by a "*", if the quest is also a daily quest.
After these basic quest information comes the name of the quest.
Groupquests then display the number of suggested group members in square brackets.
Completed quests show "(done)" in green color, quests which have failed show "(failed)" in red color afterwards.
Before the zone name which the quest takes part in, a blue "(W)" is visible, if the quest is also in the watch list.
Note that the zone name is not displayed, if sorting is set to "by location" and "group sorted quests" is enabled (see "2.4 Options" for further details).
In case "group sorted quests" is enabled and the questlist is set to be either sorted by level or by location, the quests are preceded by a header naming either the location or the level.

By mousing over any quest in the list, the questdetails for that quest are displayed (see "2.3 Questdetails").

If the questlist becomes too long and cannot be displayed completely the messge "Quest list too large. Some quests are not displayed." is displayed. In this case at least one quest is not displayed. One way to work around this is by disabling the setting to group quests. This will remove the group-headers from the list and hence should provide enough space to display all quests.

The last two lines show some hints about what kind of interaction is possible by left-clicking or shift-left-clicking onto a quest.
Depending on the setting left-clicking either opens the questlog for that particular quests or adds/removes the quest to/from the watch list. Shift-left-clicking performs the other action (see "2.4 Options" for more information).

2.3 Questdetails
================
Upon mousing over a quest in the questlist, a summary for the quest is displayed with the following information:
The first line contains the questname, followed by either a one-liner or a list of objectives which have to be fullfilled to complete the quest. If an objective has been completed, it is colored green.
Next comes the list of rewards the player gets when completing the quest. Items can be clicked to display more information about the particular item. The following rewards can be displayed (note that if the quest doesn't give a specific reward, it is not displayed and if the quest does not give any rewards at all, no reward section is displayed at all):
- money
- rewarded item
- rewarded spell
- a list of item rewards, the player can choose from
- talent points
- title

If the player is in a group and at least one other group member has the same quest, another section is displayed listing all the players who are on the same quest.
Last but not least a number of questoptions are available:
- track quest
- share quest
- abandon quest
- quest details (opens up the questlog)
- link quest (creates a questlink in the chat box)

2.4 Options
===========
The different settings of the plugin can be accessed via the options-dropdown list which can be opened by right-clicking onto the icon on the Titan Panel and moving the mouse over the "Options" entry.
The following settings are available:
- Sort:
	Sets the sort order for the questlist.
- Show:
	Sets the filter for the questlist (only quests which meet the specific selection will be displayed)
- Left Click to Watch quest:
	If ticked, left-clicking on a questlist entry will add/remove the quest to/from the WoW watchlist.
	If unticked, left-clicking on a questlist entry will open the quest in the questlog.
- Group Sorted Quests:
	If ticked, quests in the questlist will be sorted under a level/location header, if sort order is set to level or location.
- Show Icon
	Shows/Hides the Titan Quests icon on the Titan Panel.
- Show Label Text
	Shows/Hides the Titan Quests text on the Titan Panel.
- Hide
	Disables the Titan Quests button on the Titan Panel. (Titan Quests can then be reopened via the Titan Panel right-click menu)
- About
	Shows the about dialog (containing the version number as well as the list of authors)

3. Important changes
====================
For those coming back to Titan Quests from 0.24 and also for those which are just upgrading from 2.14.30300 there are several notable changes. The following sections list the most important ones for people upgrading from either 0.24 or from 2.14.30300.

3.1 Changes since Titan Panel [Quests] 0.24
===========================================
* added more detailed quest information
  Mousing over an entry in the questlist presents not only the quest-objective(s) but also includes the rewards and the list of other players on the same quest, now.
* completely overhauled the tooltip
  The layout of the Titan Quest tooltip has been redone to improve readability and add additional information like the number of total/completed quests and the time when the instances reset.
* added support for new WoW features
  Titan Quests supports daily and heroic quests.
  All restrictions to watch quests have been removed, so that any number of quests can now be added to the watchlist.
* improved performance
  The plugin listens only to those events it is interested in and updates the questlist only if necessary. Rather than regenerating the questlist whenever the player opens the Titan Quests questlist, it is now being kept in memory. This caching of the questlist significiantly boosts the performance when accessing the questlist and fixes all cases which previously caused notable delays and stuttering (performance improved by 50-99%).
* removed quests detail frame
  Whereever it was used, we now use the default WoW quest log. The only purpose of having a separate quest log was to provide a larger and movable quest frame. Meanwhile, the default quest log was updated several times and itself became movable and its size was increased, so there's no longer the need to provide a separate quest log.
  Furthermore, using the default quest log allows better interaction with other addons which replace/hook into the normal quest frame.
* removed persistent quest tracking support
  In earlier versions of WoW the quest watch list was reset whenever the player logged in/out of the game. That means that players always had to reactivate the quests they wanted to track between sessions.
  Titan Quests stored the watchlist and upon restarting the game, restored the watch list entries, so the watchlist became persistent.
  In one of the later updates to WoW Blizzard made the default watchlist persistant itself, effectively removing the need to provide this functionality ourselves.
* removed toggle options menu
  Earlier versions of Titan Quests provided a toggle menu which allowed toggling of several 3rd party quest-related addons (like Monkey Quests, QuestIOn, Quest History). This caused a significant work-load on maintaining this functionality, because all the provided addons had to be checked for updates on a regular basis.
* added quest log shortcut
  Since the toggle menu was removed, the toggle function of the quest log was removed, too. To provide a better/simpler way to toggle the quest log, the functionality was added to open/close the quest log by simply left-clicking on the Titan Quests icon in the Titan Panel bar.
* added shortcut hints
  Useful hints are displayed which point especially new users to the shortcuts they can use within Titan Quests.

3.2 Changes since Titan Panel [Quests] 2.14.30300
=================================================
* added support for new WoW features
  Titan Quests supports heroic quests now and the support for daily quests has been extended (aka: the questlist can be set to show daily quests only)
* removed quest event notifications
  The system to display a message when a quest-relevant event occurred (like killing a quest target, etc.) has been removed from Titan Quests, since this feature is now considered outside the scope of the plugin.
* performance further improved
  Even though there have been several changes to significiantly boost performance since version 1.0, some use-cases could be improved to further increase the performance by up to 50%.
* removed persistent quest tracking support
  In earlier versions of WoW the quest watch list was reset whenever the player logged in/out of the game. That means that players always had to reactivate the quests they wanted to track between sessions.
  Titan Quests stored the watchlist and upon restarting the game, restored the watch list entries, so the watchlist became persistent.
  In one of the later updates to WoW Blizzard made the default watchlist persistant itself, effectively removing the need to provide this functionality ourselves.
* removed toggle options menu
  Earlier versions of Titan Quests provided a toggle menu which allowed toggling of several 3rd party quest-related addons (like Monkey Quests, QuestIOn, Quest History). This caused a significant work-load on maintaining this functionality, because all the provided addons had to be checked for updates on a regular basis.
* removed ShowColoredText option
  Restored the 0.24 button coloring behavior which colors the number of completed quests on the Titan Quests button green and the number of total quests in white, in order to use a consistent green coloring for completed quests.
* removed initialization output
  Though the output print to the chat when the addon has been successfully loaded might be useful to prevent user errors it also spams the chat-output. If each addon would print such a message, players with 50+ addons would unnecessarily be spammed whenever they start WoW. Hence, the initialization message has been removed.
* added shortcut hints
  Useful hints are displayed which point especially new users to the shortcuts they can use within Titan Quests.

4. License
==========
This plugin is distributed under the GNU GPL v3. Please refer to the gpl-3.0.txt file for the complete license.

5. Contact and Distribution
===========================
The official page for this addon is http://www.luke1410.de/typo3/index.php?id=titanquests.
The addon is also distributed via the following addon pages:
- WoW Interface: http://www.wowinterface.com/downloads/info9990-TitanQuests.html
- Curse: http://wow.curseforge.com/addons/titan-panel-quests/
Furthermore, thanks to users of the addon it is also distributed via the following additional addon pages:
- WoW files: http://worldofwarcraft.filefront.com/file/Titan_Panel_Quests;114231

Last but not least you can contact me directly via Luke1410[NOBOTSPAM]atgmx[dot]de.

6. Thanks
=========
Thanks go to:
- urnati for taking over the maintenance of the addon and introducing a bunch of new features - last but not least thanks for the great support with passing over the project to me
- Corgi/Ryessa for coding the original version of this addon
- PcHaXoR/r3neGaDe for providing updates for the early version
- The devs from Auctioneer who helped me a lot getting into WoW addon development --- it was great fun working with you guys.
- The guys from www.wowwiki.com for their great page with all the useful information about the WoW API.
- Blizzard for their contribution to the community and offering us such a great way to alter the game to our wishes.