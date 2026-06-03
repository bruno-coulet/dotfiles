# Dotfiles

Ce dossier est versionné sur git
l'objectif est de centraliser les fichiers dotfiles (fichiers de configuration d'outils) dans un seul répertoire
Cela permet de les personnaliser et de les versionner plus facilement.


Configurations personnelles WSL / Windows :

- bash
- git
- vscode


## Liens symboliques (symlinks)

Un lien symbolique (*symbolic link* ou *symlink*) est un fichier spécial qui pointe vers un autre fichier ou dossier.
Il fonctionne comme un raccourci, mais directement au niveau du système de fichiers.

Dans le cadre des *dotfiles*, les symlinks permettent de stocker les fichiers de configuration dans un dépôt centralisé comme `~/dotfiles`, tout en laissant les applications accéder aux chemins habituels (`~/.bashrc`, `~/.gitconfig`, etc.).

Exemple :

```bash id="r9q8xy"
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
```

Cette commande crée un lien symbolique nommé `~/.bashrc` qui pointe vers le vrai fichier situé dans `~/dotfiles/bash/.bashrc`.

---

## Démarche recommandée pour les dotfiles

### 1. Sauvegarder le fichier d’origine

Avant de remplacer un fichier de configuration existant par un symlink, il est recommandé de créer une sauvegarde :

```bash id="t4n7pk"
mv ~/.bashrc ~/.bashrc.backup
```

Cela permet de restaurer facilement la configuration initiale en cas de problème.

---

### 2. Copier ou déplacer la configuration dans le dossier dotfiles

Exemple :

```bash id="mqk2ab"
cp ~/.bashrc ~/dotfiles/bash/.bashrc
```

ou, une fois la procédure maîtrisée :

```bash id="5f9vxe"
mv ~/.bashrc ~/dotfiles/bash/.bashrc
```

---

### 3. Créer le lien symbolique

```bash id="n3x7ul"
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
```

À partir de ce moment :

* `~/.bashrc` devient un lien symbolique
* le vrai fichier est stocké dans `~/dotfiles/bash/.bashrc`

Les applications continuent d’utiliser `~/.bashrc` normalement.

---

## Vérifier le lien symbolique

Commande :

```bash id="k8d1qs"
ls -l ~/.bashrc
```

Résultat attendu :

```text id="d4m7oz"
.bashrc -> /home/coule/dotfiles/bash/.bashrc
```

Le symbole `->` indique qu’il s’agit d’un lien symbolique.

---

## Restaurer le fichier original si nécessaire

Supprimer le symlink :

```bash id="b6u3tn"
rm ~/.bashrc
```

Restaurer la sauvegarde :

```bash id="f1z9wr"
mv ~/.bashrc.backup ~/.bashrc
```
