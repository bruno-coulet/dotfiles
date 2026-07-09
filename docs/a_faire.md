# Mémo – Versionner `/etc/wsl.conf` avec les dotfiles

## Objectif

Conserver une copie versionnée de la configuration WSL afin de pouvoir la restaurer rapidement après une réinstallation de WSL ou sur une nouvelle machine.

> **Principe :** ne pas créer de lien symbolique depuis `/etc/wsl.conf` vers le dépôt `dotfiles`. Les fichiers système sont copiés, pas liés.

---

# Arborescence recommandée

```text
dotfiles/
├── bash/
├── git/
├── vscode/
├── starship/
├── wsl/
│   ├── wsl.conf
│   └── README.md
└── docs/
```

---

# Sauvegarder la configuration actuelle

Copie le fichier système dans le dépôt :

```bash
sudo cp /etc/wsl.conf ~/dotfiles/wsl/wsl.conf
```

Puis versionne la modification :

```bash
cd ~/dotfiles

git add wsl/wsl.conf
git commit -m "Update WSL configuration"
```

---

# Restaurer la configuration

Après avoir cloné les dotfiles sur une nouvelle machine :

```bash
sudo cp ~/dotfiles/wsl/wsl.conf /etc/wsl.conf
```

Puis redémarrer WSL depuis PowerShell :

```powershell
wsl --shutdown
```

Relancer ensuite la distribution Ubuntu.

---

# Configuration de référence

```ini
[boot]
systemd=true

[user]
default=coule

[interop]
appendWindowsPath=true

[automount]
enabled=true
options="metadata"
mountFsTab=false
```

---

# Pourquoi `appendWindowsPath=true` ?

Cette option permet à WSL d'ajouter automatiquement les exécutables Windows dans le `PATH`.

Cela permet notamment d'utiliser directement depuis WSL :

* `code`
* `explorer.exe`
* `powershell.exe`
* `cmd.exe`
* `notepad.exe`

Lorsque cette option est positionnée à `false`, ces commandes ne sont plus disponibles (sauf en utilisant leur chemin complet).

---

# Bonnes pratiques

* Laisser WSL gérer automatiquement le `PATH` Windows (`appendWindowsPath=true`).
* Ne pas ajouter manuellement le chemin de VS Code dans `~/.bashrc` ou `~/.zshrc`.
* Gérer le `PATH` utilisateur Linux dans `~/.profile`.
* Réserver `~/.bashrc` aux alias, fonctions, prompt (Starship), complétion et personnalisations du shell.

---

# Vérifications utiles

Afficher la configuration WSL :

```bash
cat /etc/wsl.conf
```

Vérifier que VS Code est accessible :

```bash
which code
```

Vérifier que les commandes Windows sont accessibles :

```bash
which explorer.exe
which powershell.exe
```

Afficher le `PATH` ligne par ligne :

```bash
printf '%s\n' "$PATH" | tr ':' '\n'
```

---

# Évolutions possibles

À terme, créer un script d'installation (`install.sh`) capable de :

* copier automatiquement `wsl/wsl.conf` vers `/etc/wsl.conf` ;
* restaurer les liens symboliques des dotfiles ;
* vérifier les dépendances (Git, Starship, uv, etc.) ;
* faciliter la reconstruction complète de l'environnement WSL sur une nouvelle machine.
