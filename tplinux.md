# Comment réussir l'examen de TP Linux de Mr Latu ?
## Partie 1 grand A petit a

Il faut savoir:
- Ajouter un utilisateur
- Mettre à jour la liste des paquets, mettre à jour les paquets (et la distribution ?)
- Savoir installer des paquets (chercher, installer)
- Contrôler et gèrer les droits utilisateurs
- Introduction aux services ?

## Partie 2

Le script .sh fournis va vous guider au travers des méandres de l'administration de système Linux (fonctionnera sur Debian et ses dérivés).

### Ajouter un utilisateur

```sh
$ adduser nomutilisateur
```

Cette commande va vous demander des informations pour ajouter un utilisateur sur la machine.
Nul besoin de remplir tous les champs demandés, juste mettre le mot de passe suffit. (il est normal qu'il ne soit pas visible lorsque vous l'inscrivez)

Pour vérifier que c'est bon, regarder le fichier /etc/passwd c'est une bonne idée
```sh
$ cat /etc/passwd
```

### Aptitude

Apt `>` Aptitude `>` Apt-get
Cependant, Apt est assez récent comparé à Aptitude, donc devant le prof, utilisez Aptitude !

Je ne vais pas m'étendre sur la fonctionnalité en "graphique" d'Aptitude, donc allez lire le cours.

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

Et pour installer un paquet:
```sh
# aptitude install nomdupaquet
```
Ça va installer le paquet ainsi que ses dépendances.

### Droits utilisateurs

Les droits utilisateurs c'est essentiel pour avoir un système un tant soit peu sécurísé. Il suffit d'écouter le prof en cours, je vais pas tout répéter.

Pour voir le masque de droit par défaut (et le modifier) sur la machine:
```sh
$ umask
```
Le masque par défaut permet de gérer les droits sur les fichiers qui vont être créer. Le masque 0022 va donner les droits 644 ou rw-r--r-- si on regarde les droits avec ls.

Pour modifier les droits en ligne de commande pour l'utilisateur:
```sh
$ chmod u+rwx nomdufichier
```
Cette commande va mettre les droits de lecture, écriture et execution pour l'utilisateur sur le fichier.
Pour plus d'info, voir la page de manuel.

On peut aussi modifier le propriétaire d'un fichier/dossier avec `chown`.

### Bonus Intro service

Bon dans le script il n'y a pas grand chose, lisez le cours !

## Le script

Le script fourni est un script shell qui va vous guider dans l'utilisation des différentes commandes de base du système.
