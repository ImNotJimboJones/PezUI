Thnan's Mod - Battle Pets

This module adds a tooltip line to wild battle pets, items that teach you pets, and caged pets, telling you the highest rarity version you own of that pet type, and optionally, its level. This line appears when mousing over a pet in the world, on the minimap and in battle with it.
The module also adds rarity and level information to the release pet confirmation dialog.
The options to include the pet level in the tooltips cause the level of the highest quality pet to be displayed, not the highest level pet overall. For example, if you have a level 15 rare squirrel, and a level 20 uncommon squirrel, the tooltip will say level 15.

VERSION CHANGES:

1.3.1:

- Changed pet list generation to only call GetPetStats if petID is not nil.
- Pet items added in patch 5.2 will now have tooltip lines.

1.3.0:

- Hooked trigger for world tooltips to GameTooltip:OnTooltipSetUnit instead of catching UPDATE_MOUSEOVER_UNIT.
- Added tooltip lines to pet items.
- Added tooltip lines to caged pets.
- Cleaned up the appearance of battle tooltips.

1.2.0:

- Fixed issue where coloring confirmation dialog failed with other addons.
- Fixed issue where minimap tooltips would fail to detect a pet name if it was greyed out.
- Added option to show all owned pets in world and battle tooltips.

1.1.0:

- Added options to show the level of the highest rarity pet in world, battle and minimap tooltips.
- Added option to add rarity and level information to the release pet confirmation dialog.
- Fixed issue sometimes causing lua error when showing battle tooltips.

1.0.2:

- Actually, really fixed issue causing framerate loss when mousing over wild pets. (Really!)

1.0.1:

- Fixed issue causing framerate loss when mousing over wild pets. (again)

1.0.0:

 - Moved to dependent addon.
 - Changed name of plugin to Battle Pets.
 - Changed wording of tooltip lines to better integrate with Blizzard text added in 5.1
 - Fixed issue causing excessive memory usage.
 - Added the tooltip line to pet tooltips while in battle.
 - Included the collected, not collected, and favorites filter options in pet list expansion.
 - "Expand Pet List" option removed. This functionality is now baseline.
 - Filter settings now restored after searching the pet list.