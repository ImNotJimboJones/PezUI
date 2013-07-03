﻿if GetLocale() == "frFR" then


function iclllocaleui()
	arallbuttonmaint = "Liste pour cette zone"
	arallbuttontak = "Tactiques"
	areachatlist1 = "raid"
	areachatlist2 = "avertissement de raid"
	areachatlist3 = "officier"
	areachatlist4 = "groupe"
	areachatlist5 = "guilde"
	areachatlist6 = "dire"
	areachatlist7 = "crier"
	areachatlist8 = "à soi-même"
	rallachdonel1 = "terminé"
	rallachdonel2 = "inachevé"
	rallachievekologarnhp1 = "800K - 1 million"
	rallachievekologarnhp2 = "3 millions - 4 millions"
	rallachiverepl1 = "Hauts faits non complétés dans "
	rallachiverepl10 = "Liste complète de hauts faits requis pour \"Gloire du héros/à l'écumeur de raids\" dans"
	rallachiverepl11 = "Les hauts faits requis pour \"Gloire du héros/à l'écumeur de raids\" n'ont pas été trouvés dans cette zone."
	rallachiverepl12 = "Liste complète de hauts faits inachevés dans"
	rallachiverepl13 = "Hauts faits inachevés pour"
	rallachiverepl14 = "Liste de tous les hauts faits pour"
	rallachiverepl15 = "Pas de haut fait trouvé pour le boss actuel avec le réglage des options."
	rallachiverepl16 = "Hauts faits inachevés pour \"Gloire au héros/à l'écumeur de raids\" pour"
	rallachiverepl17 = "Liste complète de hauts faits requis pour \"Gloire au héros/à l'écumeur de raid\" pour"
	rallachiverepl18 = "Liste complète de hauts faits inachevés pour"
	rallachiverepl19 = "Liste complète de tous les hauts faits dans"
	rallachiverepl2 = "Vous avez complété tous les hauts faits de cette zone."
	rallachiverepl3 = "La zone actuelle ne fait pas partie d'un raid ou d'un donjon héroïque."
	rallachiverepl4 = "Liste de tous les hauts faits dans"
	rallachiverepl5 = "Le groupe de hauts faits pour cette zone n'a pas été trouvé dans la base de données."
	rallachiverepl6 = "Vérification de hauts faits désactivée."
	rallachiverepl7 = "Plus de 10 hauts faits ont été trouvés (|cff00ff00%s|r). La liste complète est visible dans la fenêtre d'options de la zone (/rach - Liste pour cette zone)"
	rallachiverepl8 = "Hauts faits inachevés pour \"Gloire au héros/à l'écumeur de raids\" dans"
	rallachiverepl9 = "Vous avez complété tous les hauts faits pour \"Gloire au héros/à l'écumeur de raids\" dans cette zone."
	rallbutton2 = "Choisissez une autre zone"
	rallbutton3 = "<<< Retourner aux réglages"
	rallchatshowboss = "Montre dans le chat"
	ralldefaulttactic1 = "Il y a ~85 zombies dans la rue entière depuis le début de l'instance, il vous faudra donc:\n1. Tuer le 1er boss.\n2. 1. Traînez le 2ème boss jusqu'à la porte de l'auberge (il ne vous laissera pas l'amener à l'intérieur, l'amener juste près des marches).\n3. 2. Donnez-lui une minute ou deux jusqu'à ce que vous voyiez le repop des zombies, tuer le boss ensuite.\n4. 3. Parlez à Arthas, nettoyer ensuite l'auberge, tuez le 3ème boss et parlez à Arthas de nouveau pour lui faire ouvrir la bibliothèque.\n5. 1 ou 2 dps doivent aller là où vous avez tué le 2ème boss, le reste du groupe continue d'avancer.\n6. Commencez simultanément à tuer des zombies dans les deux emplacements jusqu'à ce que vous obteniez le haut fait."
	ralldefaulttactic10 = "Le boss commence à engendrer des limons déformés à 50 % et s'arrête à 25 %. Attendez que les limons déformés deviennent des Vases de Fer qu'il faudra alors tuer"
	ralldefaulttactic11 = "Gel prolongé se stack toutes les 2-3 secondes. Vous pouvez obtenir le haut fait en utilisant les rochers ou en dissipant le débuff rapidement"
	ralldefaulttactic12 = "Avant le 3ème et dernier boss, vous devez passer par un tunnel de glace sans qu'aucun membre du groupe ne soit touché par les chutes de stalactites. On peut voir où ces derniers tombent grâce au cercle bleu qui apparait au sol environ 5 secondes avant leur chute."
	ralldefaulttactic13 = "Après avoir nettoyé l'allée finale avant Mal'Ganis, vous entrez dans une zone qui ne semble pas avoir subit les assaut du fléau. Il y a 2 chemins, vous pouvez soit aller à droite vers Mal'Ganis OU aller à gauche. Le corrupteur infini est à GAUCHE, si il reste du temps sur votre timer."
	ralldefaulttactic14 = "Description : Toutes les 30 secondes environs, le boss va cibler un des membres du groupe et canaliser un sort qui vous fera faire apparaître un Fragment d'Ame Corrompu, dont vous êtes sensé vous éloigner le plus loin possible, car lorsque ces âmes apparaissent elles commencent à bouger en direction de Bronjahm, et quand elles le touchent, elles dépoppent. Quand la vie du boss est en dessous de 35%, il se téléporte au centre de la pièce et arrête de bouger.\nStratégie : Kitez le autour de la plateforme située à droite avant le pull, et attendez jusqu'à ce que les 4 âmes soient apparues, puis explosez le rapidement. Les fragments d'Ame Corrompus peuvent être ralentis"
	ralldefaulttactic15 = "Vous devez mettre en place une rotation pour interrompre le lancement de \"Déflagration fantôme\""
	ralldefaulttactic16 = "Le Boss devient insensible pendant 45 secondes une fois par combat, attendez et tuez-le  sans tuer les Failles chaotiques (attention avec les AoE)"
	ralldefaulttactic17 = "Haut-fait individuel. Froid intense se cumule sur le joueur toutes les 2 secondes. Bouger casse l'effet. Si vous restez sans bouger plus de 5 secondes, le haut-fait échoue. Attention, Keristrasza a une autre capacité qui gèle les joueurs pendant 10 sec, dissipez-là"
	ralldefaulttactic18 = "Desciption : le deuxième boss est aléatoire, ce sera le Confesseur d'Argent Paletress ou Eadric le Pur. Paletress invoque seulement 1 souvenir sur 25 par combat."
	ralldefaulttactic19 = "Description : \"Marteau de Justice\" - Assomme un ennemi, le rendant vulnérable au \"Marteau du Vertueux\" et incapable de bouger ou attaquer pendant 6 secondes.\n\"Marteau du Vertueux\" - projette un marteau qui frappe un ennemi pour 14000 dégâts du sacré. Si la cible n'est pas affectée par \"MArteau de Justice\" ce marteau peut être attrapé  et renvoyé sur le lanceur.\nStratégie : Amener le boss à 25k PV et attendez qu'il assomme quelqu'un, dispellez cet étourdissement et sur la barre d'habilité du joueur va apparaître 1 unique sort \"Renvoyer le marteau\" utilisez-le !"
	ralldefaulttactic2 = "Restez simplement sur les escaliers et tuez les mobs. Il n'y aura AUCUN add supplémentaire après que le bouclier de Novos soit cassé et que vous l'ayez engagé. Donc vous n'avez plus à vous soucier de ça."
	ralldefaulttactic20 = "Tuez les goules ou kitez le boss si elles commencent à lancer explosion"
	ralldefaulttactic21 = "\"Tombeau de givre\" - enferme la cible dans un bloc de glace. Tuez simplement le boss sans tuer les tombeaux que le boss va lancer aléatoirement sur les joueurs"
	ralldefaulttactic22 = "Il y a 2 Butors du Fléau près du boss, vous avez besoin d'un d'entre eux pour le haut-fait. A 50% le boss va commencer le \"Rituel de l'Epée\" vous devez tuer le Butor du Fléau après que l'explosion de l'épée l'ait touché"
	ralldefaulttactic23 = "Pour tuer Grauf vous devez tirer 3 harpons en utilisant les lance harpons simultanément"
	ralldefaulttactic24 = "Si vous ne tuez pas le boss rapidement, il va lancer \"Plaie\" sur lui même, vous ne devez pas faire de dégâts au boss sous ce buff. Explosez simplement le boss rapidement avant ce cast"
	ralldefaulttactic25 = "Tuez les Globules d'ichor rapidement pendant qu'ils essaient de fusionner avec le boss"
	ralldefaulttactic26 = "Les cristaux de contrôle de défense sont situés sur le mur, ne cliquez pas dessus et ne laissez pas les mobs faire de dégâts au sceau de la Prison"
	ralldefaulttactic27 = "Chaque fois que vous visitez le dongeon, vous rencontrez seulement 2 boss sur les 6 qui existent"
	ralldefaulttactic28 = "Si le gardien Ahn'kahar est proche du boss - le boss devient immunisé aux dégâts, kitez simplement l'add à l'écart du boss et tuez le boss rapidement"
	ralldefaulttactic29 = "Bjarngrim a 3 plateformes ou il s'arrête et prend sa charge électrique temporaire. Engagez le quand il a sa charge électrique temporaire sur lui"
	ralldefaulttactic3 = "Description : parfois le boss inflige des dégâts aux ennemis dans les 50 mètres. Pour chaque ennemi ayant subi des dégâts de cette façon le boss gagne 1 empilement de \"Consumer\"\nTactique: explosez le boss"
	ralldefaulttactic30 = "Parfois le boss frappe la forge de Volkhan, créant 2 Golems en fusion. Tuez le avant qu'il créé plus de 4 golems"
	ralldefaulttactic31 = "A la seconde phase (en vol) Onyxia va lancer Souffle Profond, écartez vous de sa direction (elle va traverser la pièce en diagonale), si vous la descendez rapidement, elle ne lancera pas ce sort"
	ralldefaulttactic32 = "A 65% Onyxia entre en phase 2, quand elle décolle du sol vous avez 10 sec pour entrer dans les cavernes pour forcer les petits à éclore"
	ralldefaulttactic33 = "Gormok l'empaleur lance des frigbolds sur les joueurs. Ne tuez pas %s d'entre eux, et tuez Glace-Hurlante en dernière phase de la rencontre"
	ralldefaulttactic34 = "Quand le boss atteint 35% il n'y aura plus de phase sous-terraine et plus de pop de Scarabés d'essaim. Attendez jusqu'à avoir la quantité nécessaire de scarabés et tuez-les simultanément"
	ralldefaulttactic35 = "Haut-fait individuel. Vous devez éviter Frappe de lave, PAS le mur de flammes. Frappe de lave est une AoE ciblée, ouvrez les yeux ! Ou mourrez au début du combat et vous l'avez ;)"
	ralldefaulttactic36 = "Pendant la seconde phase (après que le boss soit descendu en dessous de 50%) il va y avoir quelques Scions de l'Eternité, aquand l'un meurt il lâche un Disque en suspension, vous devez le prendre et faire un coup fatal sur un des scions de l'éternité"
	ralldefaulttactic37 = "Il y a deux façons de faire ce haut-fait : 1. Ne pas tuer les adds 2. Tuer les adds très loin du boss"
	ralldefaulttactic38 = "Description : Thaddius lance \"Changement de polarité\" : place une charge soit Positive soit Négative sur toutes les cibles à proximité (débuff). Les joueurs à côté d'autres  joueurs avec la même charge augmenteront leurs dégâts. Les joueurs à proximité d'autres joueurs avec une charge opposée infligeront des dégâts aux joueurs du raid proches et feront échouer le Haut-fait\nTactique : divisez le raid en deux camps (+ et -), après le changement de polarité, courrez vers l'un des camps selon votre nouveau débuff"
	ralldefaulttactic39 = "Durant la première phase vous devrez défaire les adds de Kel'Thuzad, attaquez les abominations et tuez-en la quantité nécessaire"
	ralldefaulttactic4 = "Tuez la quantité de dinosaures nécessaire pendant le combat contre le boss"
	ralldefaulttactic40 = "Pendant le combat le boss va lancer Pointe d'Os sur les joueurs (1 en 10 et 3 en 25), il doivent être tués très rapidement"
	ralldefaulttactic41 = "Le Boss invoque des adds de 2 type et les transforme uniquement pendant la phase 1. Soyez sûr d'avoir les 5 différents types d'adds avant de passer en phase 2 : Fanatique du culte, fanatique déformé, Fanatique réanimé, Adhérent du culte, Adhérent réanimé (les adhérents investis ne compte pas, tuez les simplement)"
	ralldefaulttactic42 = "Il y a différentes stratégies, simplement n'allez pas sur le navire ennemi plus d'une fois"
	-- ralldefaulttactic43 = ""
	-- ralldefaulttactic44 = ""
	-- ralldefaulttactic45 = ""
	-- ralldefaulttactic46 = ""
	-- ralldefaulttactic47 = ""
	-- ralldefaulttactic48 = ""
	-- ralldefaulttactic49 = ""
	-- ralldefaulttactic5 = ""
	-- ralldefaulttactic50 = ""
	-- ralldefaulttactic51 = ""
	ralldefaulttactic52 = "Haut-fait individuel. Les passagers du démolisseur peuvent être lancés sur le Léviathan de flammes, où ils peuvent tuer les Tourelles de défense, pour obtenir le haut-fait, vous devez faire un coup fatal"
	ralldefaulttactic53 = "Les joueurs peuvent être lancé sur le Léviathan de flammes depuis les démolisseurs pour détruire ses tourelles. Détruire toutes les tourelles active la surcharge des circuits, qui assomme le Léviathan, augmente ses dégâts subis de 50% et réinitialise ses empilements de Prise de vitesse. Ce haut-fait nécessite que le raid ignore ce mécanisme"
	ralldefaulttactic54 = "\"Marmite de scories\" - Charge une cible ennemie aléatoire, l'attrape et la lance dans la marmite de scories du lanceur. La cible reçoit 4500 dégâts de feu chaque seconde pendant 10 sec. Le tank principal n'est pas affecté par cette habilité"
	ralldefaulttactic55 = "Les Assemblages de Fer peuvent recevoir le buff Chaleur en se tenant dans le feu laissé par la brûlure d'Ignis. Quand Chaleur atteint 10 empilements, l'Assemblage gagne le buff En fusion, qui dure 20 secondes. Si durant cette période ils sont kités dans une flaque d'eau ils perdront le buff En fusion et à la place deviendront Fragile pour 15 secondes. Un coup infligeant 5000 dégâts ou plus en 1 fois à un Assemblage Fragile va le briser, provoquant une explosion. Faire cela à 2 Assemblages ou plus dans une fenêtre de 5 secondes validera ce haut-fait"
	ralldefaulttactic56 = "Faites du DPS monocible (évitez les DoT) et amenez les Gardiens Sombre-rune à moins de 15.000 PV. Juste avant la fin de la phase au sol, Tranchécaille soufflera des flammes dans la zone directement en face de lui. Le compteur ne se réinitialise pas du tout"
	ralldefaulttactic57 = "50% des PV du boss en 2 phases au sol"
	ralldefaulttactic58 = "La description du haut fait n'est pas correcte, il est difficile de comprendre ca qui le fait échouer"
	ralldefaulttactic59 = "Ne laissez aucun des Robots-ferrailleurs XS-013 atteindre et soigner le Déconstructeur X-002 en mode de difficulté normale. Ces robots apparaissent pendant la phase de coeur exposé, chaque intervalle de 25% de PV. Ils n'ont pas d'aggro et continuent à avancer vers le Déconstructeur. Les Robots-ferrailleurs peuvent être ralentis et entravés"
	ralldefaulttactic6 = "Ne laissez pas les serpents attaquer quelqu'un trop longtemps! Tuez-les ou explosez simplement le boss rapidement"
	ralldefaulttactic60 = "Chaque intervalle de 5% de ses PV, le coeur du Déconstructeur X-002 devient exposé et des adds apparaissent, parmis eux des Robot-boum XE-321 et de nombreux Robots-Ferrailleurs XS-013 qui avanceront vers X-002. Quand les Robot-boum XE-321 sont tués ils explosent causant des dégâts à tout autour d'eux"
	ralldefaulttactic61 = "Nécessite que le joueur soit sous l'effet du flacon de Botte de Fer quand le dernier des trois boss du Conseil de Fer est tué. Le flacon peut être acheté aux Pics Foudroyés à Olut Alegut (H) ou Rork Menton-pointu (A)"
	ralldefaulttactic62 = "Tout le monde reste au corps à corps, à l'exception de 3 distants, ils kiteront le Rayon de l'œil focalisé"
	ralldefaulttactic63 = "Tuez les bras et attendez leur repop. ne faites AUCUN dégât sur le boss"
	ralldefaulttactic64 = "DPSsez le boss jusqu'à %s PV, tuez les 2 bras simultanément"
	ralldefaulttactic65 = "Le défenseur farouche apparaît au bout d'1 minute et commence le combat avec 8 empilements d'Essence farouche. Il peut se ressuciter lui-même au prix d'1 empilement, obtenir ce haut fait recquiert de tuer le Défenseur 9 fois. Soyez prêts à tuer le boss après la dernière vie de l'add, l'enrager sera proche"
	ralldefaulttactic66 = "Haut-fait individuel. Puissance de la tempête buff un joueur pour 30 secondes, peu importe ou il se trouve, mais Feu douillet et Lumière stellaire sont limités à un endroit aléatoire, vous devez obtenir ces 3 buffs"
	ralldefaulttactic67 = "Cassez tous les Gel Instantané qui apparaissent sur les PNJ"
	ralldefaulttactic68 = "Tous les membres du raid doivent éviter les Gle Instantané en se tenant sur les Congères. Elles apparaissent après une chute de Glaçons sur le sol"
	ralldefaulttactic69 = "Ne laissez pas un membre du raid avoir plus de 2 empilements de Froid Mordant pendant le combat contre Hodir. La taille des empilements augmente sur la totalité du raid au cours du temps et chaque empilement povoque des dégâts sur la durée. Bouger ou se tenir à proximité du Feu douillet créé par le mage diminue le nombre d'empilements. Le gel dispellable et le Gel instantané compliquent las tâche de bouger pour baisser les empilements"
	ralldefaulttactic7 = "Vous devez interrompre toutes les incantations de \"Transformation\" le temps d'incantation est augmenté par sa santé"
	ralldefaulttactic70 = "Vous avez 3 minutes pour tuer le boss avant qu'il détruise sa cache rare"
	-- ralldefaulttactic71 = ""
	-- ralldefaulttactic72 = ""
	-- ralldefaulttactic73 = ""
	-- ralldefaulttactic74 = ""
	-- ralldefaulttactic75 = ""
	-- ralldefaulttactic76 = ""
	-- ralldefaulttactic77 = ""
	-- ralldefaulttactic78 = ""
	-- ralldefaulttactic79 = ""
	-- ralldefaulttactic8 = ""
	-- ralldefaulttactic80 = ""
	-- ralldefaulttactic81 = ""
	-- ralldefaulttactic82 = ""
	-- ralldefaulttactic83 = ""
	-- ralldefaulttactic84 = ""
	-- ralldefaulttactic85 = ""
	-- ralldefaulttactic86 = ""
	-- ralldefaulttactic87 = ""
	-- ralldefaulttactic88 = ""
	-- ralldefaulttactic89 = ""
	-- ralldefaulttactic9 = ""
	-- ralldefaulttactic90 = ""
	-- ralldefaulttactic91 = ""
	-- ralldefaulttactic92 = ""
	-- ralldefaulttactic93 = ""
	-- ralldefaulttactic94 = ""
	ralldefaulttacticmain1 = "L'addon vous informera dans la fenêtre de chat quand il sera possible de tuer le boss!"
	ralldefaulttacticmain2 = "Attention : vos familiers ou vos totems peuvent faire échouer ce haut fait."
	ralldefaulttacticmain3 = "L'échec du haut fait sera associé à l'ID de l'instance, et vous ne pourrez pas le réinitialiser aujourd'hui"
	ralldifparty = "groupe"
	ralldifraid = "raid"
	rallmanualtxt1 = "Extension:"
	rallmanualtxt2 = "Difficulté:"
	rallmanualtxt3 = "Zone:"
	rallmenutxt1 = "    Liste de hauts faits disponibles dans la zone actuelle"
	rallmenutxt2 = "    Liste de hauts faits par choix de zone"
	rallmenutxt3 = "    Tactiques pour le groupe de hauts faits"
	rallnoaddontrack = "Pas de recherche de la part de l'Addon"
	rallnotfoundachiv1 = "les hauts faits inachevés n'ont pas été trouvés"
	rallnotfoundachiv2 = "pas de hauts faits"
	rallnotfromboss = "pas depuis le boss"
	rallsend = "Envoyé"
	ralltacticbutsave1 = "Changements appliqués"
	ralltacticbutsave2 = "Restaurer les tactiques par défaut"
	ralltactictext1 = "Choisir un haut fait:"
	ralltactictext2 = "tactique requise"
	ralltactictext3 = "tactiques: /raida"
	ralltitle2 = "Ce module vous informe à propos des hauts faits dans |cff00ff00current location|r, quand vous entrez dans l'instance. Il peut aussi rappeler quand un boss ciblé est un critère pour accomplir un haut-fait. P.S. '|cffff0000not tracked by addon|r' signifie que l'addon ne peut pas suivre le haut fait actuel et ne vous informera pas s'il est échoué, '|cffff0000got not from boss|r' - le critère de ce haut fait n'est pas de tuer le boss, il peut s'agir d'un certain loot ou de quelque chose d'autre . Dans cette fenêtre vous pouvez voir tous les groupes de hauts faits disponibles dans la zone actuelle."
	ralltitle3 = "Ce module montre les hauts faits disponibles pour la zone choisie. Vous pouvez envoyer cette info dans la fenêtre de chat"
	ralltitle33 = "'tactiques: /raida' dans le chat montre les tactiques pour le haut fait qui peut causer des difficultés. Ici vous pouvez voir toutes les tactiques, c'est très utile si vous entrez dans le donjon pour la première fois. Vous pouvez éditer le texte et l'envoyer dans le chat. Tous les changements s'appliquent pour tous les personnages.\nP.S. Envoyez-moi vos commentaires ou tactiques, et ils seront disponibles sur cet addon pour aider les autres joueurs!\nP.S.2 Vous avez trouvé des erreurs dans la traduction française? Ecrivez moi pour avoir accès à la page Curse Project pour les corriger !"
	ralltooltiptxt = "Montre dans l'infobulle"
	ralltooltiptxt2 = "RA: %s Hauts faits trouvés"
	ralltooltiptxt21 = "RA: Hauts faits trouvés"
	ralltooltiptxt3 = "Plus d'info: /raida"
	ralltxt1 = "Quand vous entez dans l'instance, il vous informe :"
	ralltxt10 = "seulement les hauts faits inachevés requis pour \"Gloire au héros/à l'écumeur de raids\""
	ralltxt11 = "seulement les hauts faits requis pour \"Gloire au héros/à l'écumeur de raids\" incluant aussi ceux qui sont complétés"
	ralltxt12 = "Version COMPLETE - TOUS les hauts faits dont j'ai besoin, incluant les boss à tuer en instance normale/héroïque, etc."
	ralltxt13 = "Version COMPLETE - TOUS les hauts faits pour cette zone"
	ralltxt2 = "seulement les hauts faits inachevés"
	ralltxt3 = "tous les hauts faits, incluant aussi ceux qui sont achevés"
	ralltxt4 = "seulement les hauts faits inachevés requis pour \"Gloire au héros/à l'écumeur de raids\""
	ralltxt5 = "seulement les hauts faits requis pour \"Gloire au héros/à l'écumeur de raids\" incluant aussi ceux qui sont achevés"
	ralltxt6 = "Version COMPLETE - TOUS les hauts faits dont j'ai besoin, y compris les boss à tuer en normal/héroïque etc"
	ralltxt7 = "Quand vous ciblez le boss, il vous informe :"
	ralltxt8 = "seulement les hauts faits inachevés"
	ralltxt9 = "tous les hauts faits, y compris ceux qui sont achevés"
	ralltxtoff = "(désactivé)"
	ralltxton = "(activé)"
	ralluilooktactic1 = "Montrer les tactiques"
	ralluilooktactic3 = "|cffff0000No tactic|r, peut-être ce haut fait est facile à comprendre par sa description. Si vous voulez |cff00ff00to add your own tactic - input text here|r"
	ralluilooktactic4 = "Les changements ont été sauvegardés avec succès."
	ralluilooktactic5 = "Tactique"
	rallwhisper = "chuchoter:"
	rallzonenotfound = "La zone actuelle n'a pas été trouvée dans la base de données."



end


end