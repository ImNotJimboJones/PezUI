HunterHelper - Notification Addon for Hunters
Written by KieferSkunk
Based on ViperNotify, by Angelnorn
----------------------------------

HunterHelper is a lightweight addon for WoW that helps hunters improve their situational awareness
in combat.  It gives you a notification when you enter combat without a battle aspect (no aspect
selected, or if you're in Cheetah or Pack), and when your pet is missing or misbehaving.  It
otherwise sits in the background, taking up no space in your UI.

To get started with HunterHelper, simply install the addon.  You can configure HunterHelper through
the Interface Options (Interface >> AddOns >> HunterHelper), or you can use a variety of console
commands.  Type /hh for a list of commands.

HunterHelper is based on Angelnorn's excellent ViperNotify addon, and contains a significant
portion of her code.  This addon is published to Curse.com with her permission.


--------------------------
Using the Console Commands
--------------------------
Type /hh for a list of console commands.  As of v1.8, the supported commands are as follows:

* /hh interval N
  Set the update interval anywhere between 0.5 and 20 seconds.

* /hh displaycombat
  Display notifications as combat text.

* /hh displayraid
  Display notifications as raid warnings.

* /hh displaynone
  Don't display messages.

* /hh sounds
  Toggle sounds on and off

* /hh solo
  Toggle whether notifications occur when you're by yourself.


* /hh enable (warnings)
* /hh disable (warnings)
* /hh toggle (warnings)

  Enable, disable or toggle one or more warnings.  Warnings may be combined in a single command.
  For example: /hh enable nopet noaspect happiness
  - This enables the warnings for not having an aspect selected, not having a pet, and your pet
    being unhappy.

  Use "all" (no quotes) to act on all warnings at once.
  Example: /hh disable all


* /hh snooze [N] [warnings]

  Temporarily turn off some or all warnings for a certain amount of time.  Use "all" to suppress
  all warnings at once, or enter specific warnings to suppress just those.  Enter a number greater
  than zero to specify the number of minutes to "snooze".

  All of the following commands are valid:
  - /hh snooze                    (snoozes all warnings for 5 minutes)
  - /hh snooze 3                  (snoozes all warnings for 3 minutes)
  - /hh snooze nopet              (snoozes the "nopet" warning for 5 minutes)
  - /hh snooze 8 noaspect         (snoozes the "noaspect" warning for 8 minutes)
  - /hh snooze noaspect 8         (snoozes the "noaspect" warning for 8 minutes)

* /hh snooze off
  Turns off the snooze timer.  Equivalent to /hh snooze 0 [anything]

-----------------------------
List of HunterHelper Warnings
-----------------------------
As of v1.97, HunterHelper provides the following warnings:

noaspect    = Warns when you go into battle without a battle aspect (Hawk, Fox or Wild).
nopet       = Warns when you go into battle without a pet.
passive     = Your pet is set to Passive
              - Optionally check to see if the pet is still attacking even on Passive, or is
                doing something strategic like standing in a specific location.
defensive   = Your pet is set to Defensive and is only attacking enemies that directly attack
              you or it.
assist      = Your pet is set to Assist and is attacking your targets automatically.
pethealth   = Your pet is low on health.
petdead     = Your pet has died!
growling    = Your pet is growling when you don't want it to be.
notgrowling = Your pet is NOT growling when you DO want it to be.
equipment   = You have non-battle equipment (chef's hat, fishing pole, etc.) equipped, or
              your critical equipment is broken.


--------------------------
Frequently-Asked Questions
--------------------------

Q: What do you mean by "No battle aspect selected"?

A: This is a new notification that lets you know when you've entered combat without a battle
   aspect selected.  This means that you either don't have any hunter aspect selected at all, or
   that your current aspect is "Aspect of the Cheetah" or "Aspect of the Pack", both of which are
   a hindrance to hunters and their parties while in combat.  To remedy this, select another aspect.

   As of Patch 4.0.1, Aspect of the Hawk, Fox and Wild are the only battle aspects.


Q: I'd like to translate HunterHelper into another language!  How can I help?

A: Awesome!  Check out HunterHelper's CurseForge page at the following address:

   http://wow.curseforge.com/addons/hunterhelper/localization

   From there, you can click on the language you want to work with, and so long as you have a
   Curse or CurseForge account, you can just start translating. :)  I personally can read
   Spanish, and know just enough French and German to get the jist of translated phrases, but
   I know nothing about Korean, Chinese or Russian.  So I'm counting on your translations to
   be accurate, and credits are going into the .lua files as to who's translating stuff.  If
   you type in a bunch of garbage or obscenities, people will know who you are. ;)


Q: I found a bug or have a suggestion.  What's the best way to let you know about it?

A: Send me a message on Curse.com or open a ticket on CurseForge .  Be sure to include
   information on what you did, what your setup is, etc. when the bug occurred, so that I can
   track down the problem.  In some cases, HunterHelper may not work well with other addons -
   if you discover a problem with HunterHelper conflicting with another addon, let me know and
   I'll see what can be done to fix the problem.  HunterHelper should really stay out of the
   way of all other addons, since all it's really meant to do is to put messages on the screen
   and play sounds. :)

   NEW (1.97): I've gotten a number of suggestions for various forms of general buff/debuff
   and timer tracking capabiities (like notifying when Serpent Sting or Freezing Trap have
   expired or their cooldowns are up).  I will consider these for future releases, but these
   are beyond the scope of what I want to accomplish with HunterHelper, which is really meant
   to help hunters with things that are hindering them.  It's more likely that these features
   will go into a different addon that uses a different style of notification system (like
   visible timers similar to what Deadly Boss Mods provides).


Q: What's the story with this addon vs. ViperNotify, anyway?

A: I had been using ViperNotify for a long time.  I think it's an excellent addon, and one that
   all hunters should at least consider using.  The biggest problem I see with most hunters I
   raid with is that many of them stay in Aspect of the Viper much longer than they really need
   to, and their DPS suffers as a result.  That's the whole reason ViperNotify was created - to
   keep that from happening.

   One problem I have personally on my hunter is that I'll forget to put myself back into a battle
   aspect after running back to my corpse.  I'll enter battle again and only realize that I was
   fighting without my power-increasing buff when I run out of mana and turn Viper on.  So I
   figured, it shouldn't be too difficult to detect that condition and get ViperNotify to tell me
   about it, right?  It was a good opportunity for me to learn how to write addons, too.

   To make the new options work well, I ended up incorporating the WoWAce framework to redesign
   the configuration UI.  This allowed me to also translate the addon into Spanish, and it
   eventually led to more or less a complete rewrite of the code.  I was eager to share my work
   with Angelnorn, the addon's original author.

   Angelnorn politely declined to incorporate the Battle Aspect feature into ViperNotify, but
   graciously gave me permission to publish it (including her ViperNotify functions) as my own
   independent addon.  I decided on the name "HunterHelper", to reflect its more general use as
   a hunter assistant, and since then, I've added numerous additional warnings to the addon to
   improve the hunter's situational awareness.

   Full credit goes to Angelnorn for getting me started.  I would strongly encourage you to drop
   her a line on Curse.com if you like the functionality - most of it is hers.  I just added to
   it. :)

   Now that hunters in Cataclysm use Focus instead of Mana, the original basis for HunterHelper
   has become obsolete, and the addon now focuses mostly on pet-related notifications.  Much of
   the code could certainly be reused for other mana-using classes, though.


Q: Do you plan to write similar "helper" addons for other classes?

A: There are already a number of other buff monitors and such for many different classes, but
   if a need arises for a simple notification addon like this, I'll definitely consider adapting
   it.  Who knows?  Perhaps you'll eventually see ShamanHelper, RogueHelper, MageHelper, etc.

   Kinda like "Hamburger Helper", isn't it? :)