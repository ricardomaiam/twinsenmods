LBA2 MOD MANAGER - Little Big Adventure 2
=========================================

HOW TO USE
  1. Double-click "LBA2 Mod Manager.bat".
     (Windows asks for administrator permission because the game is in
      "Program Files". Click "Yes".)
  2. Type a mod number and press Enter to turn it ON or OFF.
  3. P = PLAY with the chosen mods.
     O = play the ORIGINAL GOG version (no mods).
     R = revert everything to the original game.   Q = quit.
     L = language (English/Portuguese) of the manager, of the mods' texts and
         of the game started with P.

THE MODS
  They all run on the community version of the game, which is what P starts.
  The original game files are not changed. Turning them on/off is instant;
  close the game and start it again with P for the change to apply.

KEYS OF THE MODS
  Swimming:        automatic in deep water and in Zeelich's gas
                   (faster in Athletic mode).
  Free jetpack:    with the Super Jetpack, E = up, Q = down.
  Pilot ships:     V near a ship = get in/out. Arrows = forward/back and turn,
                   A / D = sideways, E / Q = up/down. Ride the Dino-Fly too.
  Orbital Camera:  outdoors. The camera settles behind Twinsen by itself.
                   Move the mouse to look around; it comes back after a
                   moment. Mouse wheel = zoom, Enter = camera back behind him.
  Open World:      just keep going past the edge of an island - swim, fly the
                   jetpack or pilot a ship - and you reach the open sea and the
                   other islands of the same planet. You can't save at open sea.
                   Mini holomap (lower-left): the red arrow is Twinsen.
                   F12 + minimap hides/shows it.
                   Climb very high with the Esmer ship to reach space; fly to
                   another world and you land on it.
  Open World: unlock by story (add-on, use with Open World):
                   islands and worlds you have not reached in the story yet
                   are covered by a translucent dome (planets: a white layer).
  Game console: F12.

INSTALLING A NEW MOD
  Put the mod folder in here. It shows up in the list by itself.

SAFETY
  The first time a game file is changed, the original is kept in
  "_backup_originais". Do NOT delete that folder.
  The community version is in ferramentas\motor (open source, GPL license;
  the changes are in mods_motor.patch). Its saves are kept in their own
  Windows folder, separate from the GOG saves.

MAKING A MOD
  A folder with:
    mod.ini        name, description, author and version     (required)
    textos.txt     changes texts/dialogues                     (optional)
    hqr\FILE.HQR\N.bin   replaces entry N of Common\FILE.HQR   (optional)
    arquivos\...   copies whole files into the game folder     (optional)
  textos.txt:
    [EN sys]                       <- language (EN FR DE ES IT PT or *) and bank
    71 = New Game                  <- text number = new text
  All original texts, with their numbers, are in ferramentas\referencia\
