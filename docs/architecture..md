## Gestion du PATH

### WSL

- appendWindowsPath=true dans /etc/wsl.conf
- Les chemins Windows sont importés automatiquement par WSL.
- Ne jamais ajouter manuellement le chemin de VS Code dans .bashrc.

### Linux

Le PATH utilisateur est géré uniquement dans ~/.profile.

### Bash

Le fichier ~/.bashrc ne doit pas modifier le PATH, sauf exception documentée.
