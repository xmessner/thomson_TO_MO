La compilation se fait de manière classique avec le Makefile fourni. Il est très simple pour le moment. Par défaut la compilation se fera avec le mode debug.
- make : lancement de la compilation en mode debug
- make gencass : compilation sans le mode debug
- make clean : supprime gencass et gencass.o

# Linux

Testé sous Manjaro. Mais n'importe quel Linux doit fonctionner sans problème. Ma plateforme principale est en 64 bits, je ne prévois pas de tester en 32 bits pour le moment.

# Fonctionnement

L'outil est très simple on lui indique un fichier d'entrée, un fichier de sortie. Il n'est prévu pour le moment que pour générer une cassette avec un seul fichier basic au format texte. Je travaille actuellement pour rajouter l'intégration de plusieurs fichiers textes ou binaires. Je réfléchis à voir comment faire pour générer un fichier basic au format token. Mais cela n'est pas prioritaire pour le moment.

Dans le répertoire _tests_ vous trouverez quelques fichiers au format texte pour tester que tout fonctionne correctement.

Pour générer une nouvelle cassette vous devez le faire ainsi

```
gencass -t fichier.txt -o fichier.k7
```

Si vous ajoutez d'autres fichiers textes ils ne seront pas pris en compte.

# BUT

Le but premier du programme est de permettre la génération d'un fichier au format k7 pour le TO7 uniquement à partir d'un fichier texte contenant un programme basic.

Dans les prochaines versions il pourra en plus
- créer un fichier k7 avec plusieurs fichiers basics au format texte
- Inclure des fichiers binaires
- Afficher les informations d'une cassette
- Extraire les différents fichiers
- Liste le contenu d'une cassette
- Vérifier l'intégrité d'une cassette
- Ajouter des fichiers à une cassette existante

Ces fonctionnalités peuvent évoluer au besoin.

# BUGS

Le programme n'est pas encore finalisé et n'est pas exempt de bugs. Vous pouvez l'utiliser comme bon vous semble mais je n'apporte aucune garantie quant à vos données, pensez à les sauvegarder avant dans un soucis de sécurité.

Si vous rencontrez des bugs ou si vous souhaitez que je rajoute des fonctionnalités particulières non gérées merci de le faire via le dépôt [gitlab](https://gitlab.com/xmessner/ordinosaures). J'essaie de le faire évoluer régulièrement donc avant de poster un bug veillez à vérifier que vous avez bien la dernière version. Indiquez le plus précisément possible les conditions de recontre du bug, la plateforme utilisée, le copilateur, l'émulateur.
N'ayant pas de ressources infinies, je ne valide pour le moment que sous ces versions

- Manjaro Linux 64bits
- DCMOTO 2021.10.30 avec Wine

# LICENCE

Vous pouvez l'utiliser comme bon vous semble, dans un produit opensource, ou gratuit.

Pour un produit payant merci de me contacter directement. En cas de réutilisation du code ou de l'outil à part entière je demande simplement que la source soit citée.

Je réfléchis à quelle licence libre le code sera rattaché ... ou pas :)

_Xavier MESSNER @ 2021
