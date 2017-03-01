# Préface
Je sais que vous avez peu de temps disponible en cette période de l'année et que ce cours n'intéresse pas beaucoup de gens, mais si vous prennez quelques minutes de votre temps pour comprendre ce qui vous sera demandé au contrôle, vous vous sentirez plus à l'aise et pourrez prendre moins de temps pour faire les questions simples et passer plus de temps sur les questions difficiles.

# Review d'autres utilisateurs
Ici je vais lister les remerciements et retour d'autre utilisateurs, car il en faut:

>C'est trop bien, j'ai eu 21/20 grâce a tout tes conseils gro
>-Un lecteur de «20 minutes»

>Mes élèves ont enfin pu apprendre le fonctionnement de Linux, je suis aux anges
>-Un professeur anonyme

# Comment réussir l'examen de TP Linux de Mr Latu ?
## Partie 1 grand A petit a
Il faut savoir:
- Ajouter un utilisateur
- Mettre à jour la liste des paquets, mettre à jour les paquets (et la distribution ?)
- Savoir installer des paquets (chercher, installer) et afficher les informations de base du paquet
- Contrôler et gèrer les droits utilisateurs
- Introduction aux services ?
- Informations concernant la machine et le système.

## Partie 2
Le script .sh fournis va vous guider au travers des méandres de l'administration de système Linux (fonctionnera sur Debian et ses dérivés).

### L'utilisateur
#### User
```sh
$ adduser nomutilisateur
```

Cette commande va vous demander des informations pour ajouter un utilisateur sur la machine.
Nul besoin de remplir tous les champs demandés, juste mettre le mot de passe suffit. (il est normal qu'il ne soit pas visible lorsque vous l'inscrivez)

Pour vérifier que c'est bon, regarder le fichier **/etc/passwd** c'est une bonne idée
```sh
$ cat /etc/passwd
```

Lister l'uid, gid ainsi que les groupes de l'utilisateur grâce à la commande `id`, ou en regardant le fichier **/etc/passwd** pour voir l'uid et gid, et **/etc/group** pour voir les groupes.

#### Groups
```sh
$ adduser user group
```
Cette commande va ajouter l'utilisateur au groupe.
Et les groupes existant, ainsi que les utilisateurs de chacun sont listé dans **/etc/group**

### Aptitude
Apt `>` Aptitude `>` Apt-get
Cependant, Apt est assez récent comparé à Aptitude, donc devant le prof, utilisez Aptitude !

Je ne vais pas m'étendre sur la fonctionnalité en "graphique" d'Aptitude, donc allez lire le cours. (et au contrôle ce n'est pas demandé)

#### Mettre à jour
Pour mettre à jour:
```sh
# aptitude update
# aptitude upgrade
```
update va mettre à jour la liste des paquets.
upgrade va mettre à jour les paquets et installer les nouvelles dépendance si besoin.

Ensuite il y a:
```sh
# aptitude dist-upgrade
```
Ça va mettre à jour la distribution, donc ça va passer les paquets sur une nouvelle révision (par exemple passer de KDE4 à KDE5), contrairement à l'upgrade des paquets, la dist-upgrade *peut* désinstaller des paquets.

#### Rechercher et installer des paquets
Pour chercher un paquet:
```sh
# aptitude search motclé
```

Afficher les informations d'un paquet en particulier:
```sh
# aptitude show nomdupaquet
```
Dans le résultat, nous voyons diverses informations tel que l'état du paquet (installé ou non), ses dépendances, etc.

Et pour installer un paquet:
```sh
# aptitude install nomdupaquet
```
Ça va installer le paquet ainsi que ses dépendances.

Pour lister les fichiers installé par un paquets (une fois installé):
```sh
$ dpkg -L nomdupaquet
```
NB: le nomdupaquet c'est sans le .deb et sans numéro de version. Ex: `dpkg -L aptitude`

### Droits utilisateurs
Les droits utilisateurs c'est essentiel pour avoir un système un tant soit peu sécurísé. Il suffit d'écouter le prof en cours, je vais pas tout répéter.

Pour voir le masque de droit par défaut (et le modifier) sur la machine:
```sh
$ umask
```
Le masque par défaut permet de gérer les droits sur les fichiers qui vont être créer. Le masque 0022 va donner les droits 644 ou **rw-r--r--** si on regarde les droits avec ls.

Pour modifier les droits en ligne de commande pour l'utilisateur:
```sh
$ chmod u+rwx fichier
```
Cette commande va mettre les droits de lecture, écriture et execution pour l'utilisateur sur le fichier.
`chmod` peut être utilisé en octal ou en littéral, c'est à dire, soit comme dans l'exemple avec des lettres, soit avec les chiffres.
r = 4
w = 2
x = 1
Donc pour avoir les droits de lecture et d'exécution: rx -> 4+1 = 5
Si on veut donner ces droits qu'a l'utilisateur et au groupe du fichier: 
```sh
$ chmod 550 fichier
```
Pour plus d'info, voir la page de manuel.

On peut aussi modifier le propriétaire d'un fichier/dossier avec `chown`.
`chown` peut changer le propriétaire d'un fichier mais aussi le groupe.
```sh
$ chown user fichier
$ chown user:group fichier
```

### Information sur la machine et le système
Les informations sur les composants de la machine que nous affichons sont:
- Informations sur le processeur avec `lscpu`
- Informations sur le bus PCI avec `lspci`
- Informations sur le bus USB avec `lsusb`

Il sera aussi nécessaire de comprendre l'affichage des processus tournant sur le système, pour cela nous avons la commande `ps`
```sh
$ ps aux
$ ps faux
```
Pour comprendre chaque paramètres de la commande `ps` je vous renvoie à sa page man. Mais grossièrement: 
a: pour tous les utilisateurs
u: montre l'utilisateur
x: pas besoin de tty
Et la commande avec un f en plus c'est pour lister _un peu_ comme un arbre.

Viennent ensuite les modules chargé, vous pouvez les afficher avec `lsmod`, et les activer/désactiver avec `modprobe`
Nous avons eu besoin de désactiver le module wifi, puis de le recharger.
(exemple sur mon propre ordinateur)
```sh
$ dmesg -t | grep 'wifi'
iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
```
Nous avons diverses informations, celle qui nous intéresse ici c'est le `iwlwifi`.
Si je fais un `lsmod | grep iwlwifi` je peux vérifier la présence d'un module portant ce nom, il ne me reste plus qu'à le désactiver avec `modprobe -r iwlwifi`

### Introduction aux services
Dans le script je ne couvre que le strict minimum pour comprendre le fonctionnement des services.
`systemctl`: liste les services qui sont chargé, actifs, etc. (q pour quitter)
`systemctl status nomduservice`: montre les informations concernant un service
`systemctl [start|stop|enable|disable] nomduservice`: c'est clair non ?

### Le Shell
Nous n'avons pas de cours concernant l'utilisation des commandes dans le shell, cependant, nous devons être en mesure d'analyser (et lancer) un script shell durant l'examen.
Le bon côté des choses, c'est qu'on a peu de commandes à connaître.
`grep, cut, tr, wc, cat` sont celles qui étaient présentes durant notre passage.
Je ne peux que vous recommender des lire leurs page de manuel respectives.

## Le script
Le script fourni est un script shell qui va vous guider dans l'utilisation des différentes commandes de base du système.

Le script vérifie certaines des commandes que vous inscrivez ! J'estime que vous savez lire et recopier les commandes que j'indique tout de même.

Veuillez avoir un compte ayant les droits super-utilisateur pour lancer le script.

## Netacad
https://www.netacad.com/

Il vous FAUT faire les contrôles sur Netacad, ce n'est pas très compliqué !

## Inetdoc
https://inetdoc.net/

Sur Inetdoc, vous retrouverez tous les cours de Mr Latu dans la page Présentation
**ET LISEZ LES OMG, YEN A TELLEMENT BESOIN EN FAIT.
ET ÉCOUTEZ LE PROF MERDE, IL DIT DES TRUCS QUI SONT PAS DANS LE COURS MAIS QUI SONT DANS L'EXAM !**


