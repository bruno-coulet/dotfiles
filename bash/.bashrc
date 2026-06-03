# ==============================================================================
# 1. INITIALISATION & SÉCURITÉ
# ==============================================================================
case $- in
  *i*) ;;
    *) return;;
esac

# ==============================================================================
# 2. DESIGN & THÈME (STARSHIP NATIVE)
# ==============================================================================
# Initialisation du prompt Starship (installé dans /usr/local/bin par défaut)
eval "$(starship init bash)"

# ==============================================================================
# 3. GESTION AUTOMATIQUE DU VENV (PYTHON / UV)
# ==============================================================================
# Raccourci pour forcer l'activation manuelle sous Linux
alias venv='source .venv/bin/activate'

# Fonction d'activation automatique au changement de dossier
function check_venv {
    if [ -d ".venv" ] && [ -z "$VIRTUAL_ENV" ]; then
        source .venv/bin/activate
    fi
}

# Surcharge de la commande 'cd' pour déclencher la vérification du venv sous WSL
cd() {
    builtin cd "$@" && check_venv
}

# ==============================================================================
# 4. RACCOURCIS IA & VIBE CODING (VERSION WSL)
# ==============================================================================
alias claude='claude' # Lancé nativement si installé via npm sur Ubuntu
alias ask-ai='gh copilot suggest'
alias explain-ai='gh copilot explain'

# ==============================================================================
# 5. ALIAS GÉNÉRAUX & RACCOURCIS GIT
# ==============================================================================
export STARSHIP_DISTRO="🐧 WSL" # Badge pour le prompt
alias reload='source ~/.bashrc'
alias explorer='explorer.exe .'
alias projets='cd ~/Documents/projets'

# Raccourcis Git Personnels
alias gf='git fetch'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gph='git push'
alias gpl='git pull'

# ==============================================================================
# 6. FONCTION D'INITIALISATION DE PROJET (VERSION WSL CORRIGÉE)
# ==============================================================================
init-project() {
    local BASE_DIR="$HOME/Documents/projets"
    local TEMPLATE_DIR="$HOME/templates"

    if [ -z "$1" ]; then
        echo "❌ Erreur : Il faut  spécifier un nom de projet."
        return 1
    fi

    local TARGET_DIR="$BASE_DIR/$1"
    if [ -d "$TARGET_DIR" ]; then
        echo "❌ Erreur : Le projet '$1' existe déjà"
        return 1
    fi

    # 1. On laisse uv créer le dossier ET l'architecture de base
    echo "🚀 Initialisation du projet moderne via uv init..."
    uv init --app --python 3.12 "$TARGET_DIR"
    
    cd "$TARGET_DIR" || return 1

    # 2. Peaufine le .gitignore généré par uv, ajoute :
    {
        echo ""
        echo "# Sécurité & Environnement"
        echo ".env"
        echo "*.pyc"
        echo "# Data & Assistant IA"
        echo "CLAUDE.md"
        echo ".github/copilot-instructions.md"
        echo "data/*"
        echo "temp/*"
        echo "# caches Python"
        echo "__pycache__/"
    } >> .gitignore

    # 📁 Création des dossiers de travail (vides)
    mkdir -p data temp

    # 3 Copie de la configuration VS Code et Ruff
    mkdir -p .vscode
    [ -f "$TEMPLATE_DIR/vscode-settings/settings.json" ] && cp "$TEMPLATE_DIR/vscode-settings/settings.json" ./.vscode/settings.json
    [ -f "$TEMPLATE_DIR/pyproject.toml" ] && cp "$TEMPLATE_DIR/pyproject.toml" ./pyproject.toml


    # 3.5 Copie des fichiers d'instructions IA
    mkdir -p .github
    [ -f "$TEMPLATE_DIR/CLAUDE_WSL.md" ] && cp "$TEMPLATE_DIR/CLAUDE_WSL.md" ./CLAUDE.md
    [ -f "$TEMPLATE_DIR/copilot-instructions.md" ] && cp "$TEMPLATE_DIR/copilot-instructions.md" ./.github/copilot-instructions.md

    # 4. Premier commit automatique (uv init a déjà fait le git init en tâche de fond)
    git add .
    git commit -m "feat: initialisation du projet avec uv et instructions IA"

    echo "✅ Projet prêt avec pyproject.toml."
}



# ==============================================================================
# 7. CONDA INITIALIZATION (WSL)
# ==============================================================================
__conda_setup="$('/home/coule/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/coule/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/coule/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/coule/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup


# =====================================
# 5. Ouverture  dans vscode
# ================================
    echo "Ouverture du projet dans VS Code..."
    code .
