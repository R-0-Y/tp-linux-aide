#!/bin/bash
clear

#--------------------------------------------------#
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
	read  -r choix
	clear

	case $choix in
	  1)
		echo -e "Créer un utilisateur\n"
		Ajoututilisateur
	    ;;
	  2)
		echo -e "Mettre à jour la liste des paquets\n"
	    Majlistpaquet
		;;
	  3)
		echo -e "Mettre à jour les paquets\n"
		Majpaquets
	    ;;
	  4)
		echo -e "Mettre à jour la distibution\n"
		Majdistrib
		;;
	  5)
		echo -e "Chercher et installer des paquets\n"
		SearchInstall
		;;
	  6)
		echo -e "Contrôler et gèrer les droits utilisateur\n"
		DroitUser
		;;
	  7)
		echo -e "Petite introduction aux services\n"
		IntroServices
		;;
	  8)
		echo -e "informations concernant la machine\n"
		InfoPC
		;;
	  9)
		echo -e "Être Corpo Cogip\n"
	  	echo "Cela s'apprend !"
	  	xdg-open "https://www.youtube.com/watch?v=QYWGd3QhD48"	
	  	;;
	  10)
		echo -e "Netacad et Inetdoc\n"
		echo "Il FAUT faire les contrôles Netacad, et lire le cours sur Inetdoc"
		xdg-open "https://www.netacad.com/"
		xdg-open "https://inetdoc.net/"
		;;
	  *)
		echo -e "Commande: $choix \n"
		echo "Commande inconnu ou exit, byebye"
		exit
		;;
	esac
}
#--------------------------------------------------#

#--------------------------------------------------#
Check4Commande(){
	if [ $# -ne 4 ]; then
		clear
		echo -e "\033[31mTu as oublié un argument ou en a un en trop\033[0m\n"
		Menu
	elif [ ! "$2" = "sudo"  ]; then
		clear
		echo -e "\033[31msudo et $2 ne sont pas les mêmes commandes\033[0m\n"
		Menu
	elif [ ! "$1" = "$3" ]; then
		clear
		echo -e "\033[31m$1 et $3 ne sont pas les mêmes commandes\033[0m\n"
		Menu
	fi
}
#--------------------------------------------------#

#--------------------------------------------------#
Check5Commande(){
	if [ $# -ne 5 ]; then
		clear
		echo -e "\033[31mTu as oublié un argument ou en a un en trop\033[0m\n"
		Menu
	elif [ ! "$3" = "sudo"  ]; then
		clear
		echo -e "\033[31msudo et $2 ne sont pas les mêmes commandes\033[0m\n"
		Menu
	elif [ ! "$1" = "$4" ]; then
		clear
		echo -e "\033[31$1 et $4 ne sont pas les mêmes commandes\033[0m\n"
		Menu
	elif [ ! "$2" = "$5" ]; then
		clear
		echo -e "\033[31m$2 et $5 ne sont pas les mêmes commandes\033[0m\n"
		Menu
	fi
}
#--------------------------------------------------#

#--------------------------------------------------#
Check5moreCommande(){
	if [ $# -lt 5 ]; then
		echo "Tu as oublié un argument ou plus"
		Menu
	elif [ ! "$3" = "sudo"  ]; then
		clear
		echo -e "\033[31msudo et $3 ne sont pas les mêmes commandes\033[0m\n"
		Menu
	elif [ ! "$1" = "$4" ]; then
		clear
		echo -e "\033[31m$1 et $4 ne sont pas les mêmes commandes\033[0m\n"
		Menu
	elif [ ! "$2" = "$5" ]; then
		clear
		echo -e "\033[31m$1 et $5 ne sont pas les mêmes commandes\033[0m\n"
		Menu
	fi
}
#--------------------------------------------------#

#--------------------------------------------------#
CheckUser(){
	shift 2
	user=$(grep "$1" /etc/passwd | cut -d ":" -f1)
	if [ "$2" -eq 1 ]; then
		if [ "$1" = "$user" ]; then
			echo "Utilisateur déjà présent"
			echo "Retour au menu !"
			Menu
		fi
	else
		echo "Utilisateur non ajouté, on retente (si ça refail, fait un exit haha)"
		Ajoututilisateur
	fi
}
#--------------------------------------------------#

#--------------------------------------------------#
Ajoututilisateur(){
	# commande adduser
	echo "Suivre les questions demandé par la commande"
	echo "Pas besoin d'entrer toutes les informations demandé"
	echo "hormis le mot de passe évidemment"
	echo "Il faut être en root/super-utilisateur"
	echo -e "commande: \033[32msudo adduser nomutilisateur\033[0m (faut l'écrire maintenant)"
    read -r commande
    echo "Tu as écris: $commande"
    echo ""

    Check4Commande "adduser" $commande
	echo "Je vais la lancer !"
	CheckUser $commande 1
	eval "$commande"
	echo ""
	
	CheckUser $commande

	echo "Bravo ! Tu peux vérifier que ça a bien fonctionné de diverse façon. Check le fichier /etc/passwd, regarder le dossier /home, ..."
	echo "J'ai une préférence pour le fichier /etc/passwd (car on peut ajouter un utilisateur sans lui faire de dossier dans /home)"
	echo "Par exemple:  grep nomutilisateur /etc/passwd"
	echo "(je vais te le faire)"
	sleep 2
	grep "$(echo "$commande" | cut -d " "  -f3)" /etc/passwd
    echo ""
    echo "Si une ligne c'est affichée (et ça devrait être le cas haha), c'est que l'utilisateur est bien ajouté"
    echo ""
	
	
	echo "Retour au menu !"
	Menu
}
#--------------------------------------------------#

#--------------------------------------------------#
Majlistpaquet(){
	 # commande aptitude

    echo -e "Pour mettre à jour la liste des paquets, vous devez utiliser la commande: \033[32maptitude update\033[0m"
    echo -e "Si vous voulez perdre des points, \033[32mutilisez apt-get.\033[0m"
    echo -e "Si vous voulez être futur-proof, \033[32mutilisez apt\033[0m"
    echo "Il faut de plus être en super-utilisateur, donc sudo devant la commande (ou être root)"
    echo -e "Donc: \033[32msudo aptitude update\033[0m"
    read -r commande
    Check5Commande "aptitude" "update" "$commande"
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer !"
	eval "$commande"
	echo ""
	
	echo "Retour au menu !"
	Menu
}
#--------------------------------------------------#

#--------------------------------------------------#
Majpaquets(){

    echo "Pour mettre à jour les paquets, vous devez utiliser la commande: aptitude upgrade"
    echo "Si vous voulez perdre des points, utilisez apt-get."
    echo "Si vous voulez être futur-proof, utilisez apt"
    echo "Il faut de plus être en super-utilisateur, donc sudo devant la commande (ou être root)"
	echo "Différence entre update et upgrade ? Update mets à jour la liste des paquets pouvant être mis à jour, upgrade les mets à jour (et installe les nouvelles dépendances si nécessaire)"
    echo -e "Donc: \033[32msudo aptitude upgrade\033[0m"
    read -r commande
	    Check5Commande "aptitude" "upgrade" "$commande"

    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! (il faudra valider l'installation des paquets)"
	eval "$commande"
	echo ""
	
	echo "Retour au menu !"
	Menu
}
#--------------------------------------------------#

#--------------------------------------------------#
Majdistrib(){

    echo "Mettre à jour la distribution c'est plus «lourd» que juste mettre à jour les paquets, ça va en retirer certains, en ajouter d'autre, etc. Ça permet de passer sur la nouvelle version de [Debian|Ubuntu|etc]"
    echo "Si vous voulez perdre des points, utilisez apt-get."
    echo "Si vous voulez être futur-proof, utilisez apt"
    echo "Il faut de plus être en super-utilisateur, donc sudo devant la commande (ou être root)"
	echo "Différence entre update et upgrade ? Update mets à jour la liste des paquets pouvant être mis à jour, upgrade les mets à jour (et installe les nouvelles dépendances si nécessaire)"
    echo -e "Donc: \033[32msudo aptitude dist-upgrade\033[0m"
    read -r commande
	    Check5Commande "aptitude" "dist-upgrade" "$commande"
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! (il faudra valider l'installation des paquets)"
	eval "$commande"
	echo ""

	echo "Retour au menu !"
	Menu
}
#--------------------------------------------------#

#--------------------------------------------------#
SearchInstall(){

	echo -e "Pour rechercher un paquet, nous allons utiliser la commande: \033[32maptitude search motclé\033[0m"
	echo -e "Par exemple: \033[32msudo aptitude search wireshark\033[0m"
	read -r commande
	    Check5moreCommande "aptitude" "search" "$commande"
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval "$commande"
	echo ""

	echo "Ensuite pour installer le paquet que l'on veut: aptitude install nomdupaquet"
	echo "Pas besoin de tester, mais ça va mettre le paquet et toutes les dépendances dont il a besoin"
	echo ""

	echo "Retour au menu !"
	Menu
}
#--------------------------------------------------#

#--------------------------------------------------#
DroitUser(){

	echo "Parler des droits utilisateur ça peut prendre du temps, donc on va en parler juste rapidement, et juste assez pour que le prof ne voit pas de droit 0777 !"
	echo "Tout d'abord on va créer un fichier, le plus simple c'est tout simplement la commande: touch nomdufichier"
	echo -e "Par exemple: \033[32mtouch latualecranequibrille\033[0m"
	read -r commande
	# check=`echo $commande | cut -d " " -f1`
	if [ ! "$(echo "$commande" | cut -d " " -f1)" = "touch" ]; then
		echo "Tu ne sais pas écrire touch ?" 
		DroitUser
	fi
	nomfich=$(echo "$commande" | cut -d " " -f2)

    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval "$commande"
	echo ""

	echo "Sur Debian (et toutes les autres ?) l'umask par défaut est 0022, donc le fichier aura comme droit -rw-r--r--, ou sinon on prend la permission par défaut, donc 666 et on y ôte le masque, donc 666 - 022 = 644."
	echo -e "Pour vérifié, il n'y a pas 1 500 000 000 000 solutions, le plus rapide: \033[32mls -l nomdufichier\033[0m"
	echo -e "Par exemple: \033[32mls -l latualecranequibrille\033[0m"
	echo ""

	echo "-rw-r--r-- veut dire: fichier, lecture écriture en droit utilisateur, lecture en droit groupe, et lecture en droit pour les autres."
	echo -e "Si on veut donner les droits d'exécution au groupe par exemple, il faut utiliser la command: \033[32mchmod\033[0m"
	echo "Il y a plusieurs façon de l'utiliser, soit en spécifiant les nouveaux droits que pour l'user, groupe ou les autres (ou plusieurs en même temps) soit en donnant le droit tel que 777 directement"
	echo -e "Pour donner les droits d'exécution au groupe donc: \033[32mchmod g+x nomdufichier\033[0m"
	echo -e "Par exemple: \033[32mchmod g+x latualecranequibrille\033[0m"
	read -r commande
	# check=`echo $commande | cut -d " " -f1`
	if [ ! "$(echo "$commande" | cut -d " " -f1)" = "chmod" ]; then
		echo "Tu ne sais pas écrire chmod ?" 
		DroitUser
	elif [ ! "$(echo "$commande" | cut -d " " -f2)" = "g+x" ]; then
		echo "C'est «g+x» !"
		DroitUser
	fi

    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval "$commande"
	echo ""

	echo "On le test avec un ls -l nomdufichier"
	read -r commande
	if [ ! "$(echo "$commande" | cut -d " " -f1)" = "ls" ]; then
		echo "ls, un L minuscule et un S minuscule !"
		echo "Comme ça"
		ls -l "$nomfich"
	elif [ ! "$(echo "$commande" | cut -d " " -f2)" = "-l" ]; then
		echo "Pls kill me, -l"
		echo "Comme ça"
		ls -l "$nomfich"
	else
		echo "Tu as écris: $commande"
		echo ""
		echo "Je vais la lancer ! "
		eval "$commande"
	fi
	echo ""
	echo -e "Pour modifier les droits par défaut, il faut changer l'umask, pour cela: \033[32mumask xxxx\033[0m"
	echo -e "Par exemple: \033[32mumask 0027\033[0m"
	echo "Ça donnera les droits -rw-r-----"
	echo "Retour au menu !"
	rm "$nomfich"
	Menu
}
#--------------------------------------------------#

#--------------------------------------------------#
IntroServices(){

	echo "Pour voir la liste des services qui tournent sur une machine (munie de systemd, ce qui est le cas des machines un tant soit peu mise à jour)"
	echo -e "Pour lister les services lancé (q pour quitter): \033[32msystemctl\033[0m"
	read -r commande
	if [ ! "$("$commande")" = "systemctl" ]; then
		echo "J'ai dit systemctl..."
		IntroServices
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval "$commande"
	echo ""

	clear;
	echo "Pour voir l'état d'un service en particulier: systemctl status nomduservice"
	echo -e "Par exemple: \033[32msystemctl status cron.service\033[0m"
	echo ""
	echo "(on le fera pas, flemme)"
	echo "On peut voir que c'est chargé (active), qu'il tourne (running), et que ça sera lancé au démarrage (enabled)"
	echo -e "Pour lancer, stopper, relancer, activer au démarrage: \033[32msystemctl [start|stop|reload|enable] nomduservice\033[0m"
	echo -e "Retour au menu !\n"
	Menu
}
#--------------------------------------------------#

#--------------------------------------------------#
InfoPC(){
	echo "Pour afficher les informations de la machine nous avons plusieurs commandes"
	echo -e "Tout d'abord les informations sur le processeur: \033[32mlscpu\033[0m"
	read -r commande
	if [ ! "$("$commande")" = "lscpu" ]; then
		echo "l s c p u"
		InfoPC
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval "$commande"
	echo ""

	echo -e "Ensuite, les informations sur le bus PCI avec: \033[32mlspci\033[0m"
	read -r commande
	if [ ! "$("$commande")" = "lspci" ]; then
		echo "LsPcI"
		InfoPC
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval "$commande"
	echo ""

	echo -e "Ensuite, les informations sur le bus PCI avec: \033[32mlsusb\033[0m"
	read -r commande
	if [ ! "$("$commande")" = "lsusb" ]; then
		echo "Commande: lsusb"
		InfoPC
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval "$commande"
	echo ""

	echo -e "Et enfin, on peux afficher les informations du noyau Linux avec la commande uname, pour tout voir «\033[32muname -a\033[0m»"
	read -r commande
	if [ ! "$commande" = "uname -a" ]; then
		echo "Commande: uname -a"
		InfoPC
	fi
    echo "Tu as écris: $commande"
    echo ""
	echo "Je vais la lancer ! "
	eval "$commande"
	echo ""
	echo "Annnnnd voilà"

}
#--------------------------------------------------#

#--------------------------------------------------#
echo -e "\tInstructions pour bien réussir (j'espère) le TP noté Linux \n"
while true; do
	Menu
done
#--------------------------------------------------#
