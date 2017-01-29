#!/bin/bash

Menu(){
	echo "Menu:"
	echo "1/ Créer un utilisateur"
	echo "2/ Mettre à jour la liste des paquets"
	echo "3/ Mettre à jour les paquets"
	echo "4/ Mettre à jour la distribution"
	echo "5/ Chercher et installer des paquets"
	echo "6/ Contrôler et gèrer les droits utilisateur"
	echo "7/ Petite introduction aux services"
	echo "8/ informations concernant la machine"
	echo "9/ Être Corpo Cogip"
	echo "10/ Netacad et Inetdoc"

	echo "A tout moment, la commande exit quitte le script"
	read choix

	case $choix in
	  1)
		Ajoututilisateur
	    ;;
	  2)
	    Majlistpaquet
		;;
	  3)
		Majpaquets
	    ;;
	  4)
		Majdistrib
		;;
	  5)
		SearchInstall
		;;
	  6)
		DroitUser
		;;
	  7)
		IntroServices
		;;
	  8)
		InfoPC
		;;
	  9)
	  	echo "Cela s'apprend !"
	  	xdg-open "https://www.youtube.com/watch?v=QYWGd3QhD48"	
	  	;;
	  10)
		echo "Il FAUT faire les contrôles Netacad, et lire le cours sur Inetdoc"
		xdg-open "https://www.netacad.com/"
		xdg-open "https://inetdoc.net/"
		;;
	  *)
		echo "Commande: $choix"
		echo "Commande inconnu ou exit, byebye"
		exit
		;;
	esac
}

Check4Commande(){
	if [ $# -ne 4 ]; then
		echo "Tu as oublié un argument ou en a un en trop"
		Menu
	elif [ ! "$2" = "sudo"  ]; then
		echo "sudo et $2 ne sont pas les mêmes commandes"
		Menu
	elif [ ! $1 = $3 ]; then
		echo "$1 et $3 ne sont pas les mêmes commandes"
		Menu
	fi
}

Check5Commande(){
	if [ $# -ne 5 ]; then
		echo "Tu as oublié un argument ou en a un en trop"
		Menu
	elif [ ! "$3" = "sudo"  ]; then
		echo "sudo et $3 ne sont pas les mêmes commandes"
		Menu
	elif [ ! $1 = $4 ]; then
		echo "$1 et $4 ne sont pas les mêmes commandes"
		Menu
	elif [ ! $2 = $5 ]; then
		echo "$2 et $5 ne sont pas les mêmes commandes"
		Menu
	fi
}

Check5moreCommande(){
	if [ $# -lt 5 ]; then
		echo "Tu as oublié un argument ou plus"
		Menu
	elif [ ! "$3" = "sudo"  ]; then
		echo "sudo et $3 ne sont pas les mêmes commandes"
		Menu
	elif [ ! $1 = $4 ]; then
		echo "$1 et $4 ne sont pas les mêmes commandes"
		Menu
	elif [ ! $2 = $5 ]; then
		echo "$2 et $5 ne sont pas les mêmes commandes"
		Menu
	fi
}
CheckUser(){
	shift 2
	user=`grep $1 /etc/passwd | cut -d ":" -f1`
	if [ "$1" = "$user" ]; then
		echo "Utilisateur déjà présent"
		echo "Retour au menu !"
		Menu
	else
		echo "Utilisateur non ajouté, on retente (si ça refail, fait un exit haha)"
		Ajoututilisateur
	fi
}

Ajoututilisateur(){
	# commande adduser
	echo ""
	echo "Suivre les questions demandé par la commande"
	echo "Pas besoin d'entrer toutes les informations demandé"
	echo "hormis le mot de passe évidemment"
	echo "Il faut être en root/super-utilisateur"
	echo "commande: sudo adduser nomutilisateur (faut l'écrire maintenant)"
    read commande
    echo "Tu as écris: $commande"
    echo ""

    Check4Commande "adduser" $commande
	echo "Je vais la lancer !"
	eval $commande
	echo ""
	
	CheckUser $commande

	echo "Bravo ! Tu peux vérifier que ça a bien fonctionné de diverse façon. Check le fichier /etc/passwd, regarder le dossier /home, ..."
	echo "J'ai une préférence pour le fichier /etc/passwd (car on peut ajouter un utilisateur sans lui faire de dossier dans /home)"
	echo "Par exemple:  grep nomutilisateur /etc/passwd"
	echo "(je vais te le faire)"
	sleep 2
	grep `echo $commande | cut -d " "  -f3` /etc/passwd
    echo ""
    echo "Si une ligne c'est affichée (et ça devrait être le cas haha), c'est que l'utilisateur est bien ajouté"
    echo ""
	
	
	echo "Retour au menu !"
	Menu
}

Majlistpaquet(){
	 # commande aptitude
	echo ""
    echo "Pour mettre à jour la liste des paquets, vous devez utiliser la commande: aptitude update"
    echo "Si vous voulez perdre des points, utilisez apt-get."
    echo "Si vous voulez être futur-proof, utilisez apt"
    echo "Il faut de plus être en super-utilisateur, donc sudo devant la commande (ou être root)"
    echo "Donc: sudo aptitude update"
    read commande
    Check5Commande "aptitude" "update" $commande
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer !"
	eval $commande
	echo ""
	
	echo "Retour au menu !"
	Menu
}

Majpaquets(){
	echo ""
    echo "Pour mettre à jour les paquets, vous devez utiliser la commande: aptitude upgrade"
    echo "Si vous voulez perdre des points, utilisez apt-get."
    echo "Si vous voulez être futur-proof, utilisez apt"
    echo "Il faut de plus être en super-utilisateur, donc sudo devant la commande (ou être root)"
	echo "Différence entre update et upgrade ? Update mets à jour la liste des paquets pouvant être mis à jour, upgrade les mets à jour (et installe les nouvelles dépendances si nécessaire)"
    echo "Donc: sudo aptitude upgrade"
    read commande
	    Check5Commande "aptitude" "upgrade" $commande

    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! (il faudra valider l'installation des paquets)"
	eval $commande
	echo ""
	
	echo "Retour au menu !"
	Menu
}

Majdistrib(){
	echo ""
    echo "Mettre à jour la distribution c'est plus «lourd» que juste mettre à jour les paquets, ça va en retirer certains, en ajouter d'autre, etc. Ça permet de passer sur la nouvelle version de [Debian|Ubuntu|etc]"
    echo "Si vous voulez perdre des points, utilisez apt-get."
    echo "Si vous voulez être futur-proof, utilisez apt"
    echo "Il faut de plus être en super-utilisateur, donc sudo devant la commande (ou être root)"
	echo "Différence entre update et upgrade ? Update mets à jour la liste des paquets pouvant être mis à jour, upgrade les mets à jour (et installe les nouvelles dépendances si nécessaire)"
    echo "Donc: sudo aptitude dist-upgrade"
    read commande
	    Check5Commande "aptitude" "dist-upgrade" $commande
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! (il faudra valider l'installation des paquets)"
	eval $commande
	echo ""

	echo "Retour au menu !"
	Menu
}

SearchInstall(){
	echo ""
	echo "Pour rechercher un paquet, nous allons utiliser la commande: aptitude search motclé"
	echo "Par exemple: sudo aptitude search wireshark"
	read commande
	    Check5moreCommande "aptitude" "search" $commande
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval $commande
	echo ""

	echo "Ensuite pour installer le paquet que l'on veut: aptitude install nomdupaquet"
	echo "Pas besoin de tester, mais ça va mettre le paquet et toutes les dépendances dont il a besoin"
	echo ""

	echo "Retour au menu !"
	Menu
}

DroitUser(){
	echo ""
	echo "Parler des droits utilisateur ça peut prendre du temps, donc on va en parler juste rapidement, et juste assez pour que le prof ne voit pas de droit 0777 !"
	echo "Tout d'abord on va créer un fichier, le plus simple c'est tout simplement la commande: touch nomdufichier"
	echo "Par exemple: touch latualecranequibrille"
	read commande
	# check=`echo $commande | cut -d " " -f1`
	if [ ! `echo $commande | cut -d " " -f1` = "touch" ]; then
		echo "Tu ne sais pas écrire touch ?" 
		DroitUser
	fi
	nomfich=`echo $commande | cut -d " " -f2`

    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval $commande
	echo ""

	echo "Sur Debian (et toutes les autres ?) l'umask par défaut est 0022, donc le fichier aura comme droit -rw-r--r--, ou sinon on prend la permission par défaut, donc 666 et on y ôte le masque, donc 666 - 022 = 644."
	echo "Pour vérifié, il n'y a pas 1500000000000 solutions, le plus rapide: ls -l nomdufichier"
	echo "Par exemple: ls -l latualecranequibrille"
	echo ""

	echo "-rw-r--r-- veut dire: fichier, lecture écriture en droit utilisateur, lecture en droit groupe, et lecture en droit pour les autres."
	echo "Si on veut donner les droits d'exécution au groupe par exemple, il faut utiliser la command: chmod"
	echo "Il y a plusieurs façon de l'utiliser, soit en spécifiant les nouveaux droits que pour l'user, groupe ou les autres (ou plusieurs en même temps) soit en donnant le droit tel que 777 directement"
	echo "Pour donner les droits d'exécution au groupe donc: chmod g+x nomdufichier"
	echo "Par exemple: chmod g+x latualecranequibrille"
	read commande
	# check=`echo $commande | cut -d " " -f1`
	if [ ! `echo $commande | cut -d " " -f1` = "chmod" ]; then
		echo "Tu ne sais pas écrire chmod ?" 
		DroitUser
	elif [ ! `echo $commande | cut -d " " -f2` = "g+x" ]; then
		echo "C'est «g+x» !"
		DroitUser
	fi

    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval $commande
	echo ""

	echo "On le test avec un ls -l nomdufichier"
	read commande
	if [ ! `echo $commande | cut -d " " -f1` = "ls" ]; then
		echo "ls, un L minuscule et un S minuscule !"
		echo "Comme ça"
		ls -l $nomfich
	elif [ ! `echo $commande | cut -d " " -f2` = "-l" ]; then
		echo "Pls kill me, -l"
		echo "Comme ça"
		ls -l $nomfich
	else
		echo "Tu as écris: $commande"
		echo ""
		echo "Je vais la lancer ! "
		eval $commande
	fi
	echo ""
	echo "Pour modifier les droits par défaut, il faut changer l'umask, pour cela: umask xxxx"
	echo "Par exemple: umask 0027"
	echo "Ça donnera les droits -rw-r-----"
	echo "Retour au menu !"
	rm $nomfich
	Menu
}

IntroServices(){
	echo ""
	echo "Pour voir la liste des services qui tournent sur une machine (munie de systemd, ce qui est le cas des machines un tant soit peu mise à jour)"
	echo "Pour lister les services lancé (q pour quitter): systemctl"
	read commande
	if [ ! `echo $commande` = "systemctl" ]; then
		echo "J'ai dit systemctl..."
		IntroServices
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval $commande
	echo ""

	echo "Pour voir l'état d'un service en particulier: systemctl status nomduservice"
	echo "Par exemple: systemctl status cron.service"
	echo ""
	echo "(on le fera pas, flemme)"
	echo "On peut voir que c'est chargé (active), qu'il tourne (running), et que ça sera lancé au démarrage (enabled)"
	echo "Pour lancer, stopper, relancer, activer au démarrage: systemctl [start|stop|reload|enable] nomduservice"
	echo "Retour au menu !"
	Menu
}

InfoPC(){
	echo ""
	echo "Pour afficher les informations de la machine nous avons plusieurs commandes"
	echo "Tout d'abord les informations sur le processeur: lscpu"
	read commande
	if [ ! `echo $commande` = "lscpu" ]; then
		echo "l s c p u"
		InfoPC
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval $commande
	echo ""

	echo "Ensuite, les informations sur le bus PCI avec: lspci"
	read commande
	if [ ! `echo $commande` = "lspci" ]; then
		echo "LsPcI"
		InfoPC
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval $commande
	echo ""

	echo "Ensuite, les informations sur le bus PCI avec: lsusb"
	read commande
	if [ ! `echo $commande` = "lsusb" ]; then
		echo "Commande: lsusb"
		InfoPC
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval $commande
	echo ""

	echo "Et enfin, on peux afficher les informations du noyau Linux avec la commande uname, pour tout voir «uname -a»"
	read commande
	if [ ! `echo $commande` = "uname -a" ]; then
		echo "Commande: uname -a"
		InfoPC
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval $commande
	echo ""
	echo "Annnnnd voilà"

}

echo "Instructions pour bien réussir (j'espère) le TP noté Linux"
while true; do
	Menu
done
