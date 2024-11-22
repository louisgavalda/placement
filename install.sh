#!/bin/bash

# Configuration
ZIP_URL="https://votre-url-fixe.com/archive.zip"  # <-- Mettez votre URL ici
TEMP_DIR="/tmp/scripts_install_$(date +%s)"

# Codes couleur
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Chemins des dossiers Scripts d'Illustrator
SCRIPT_PATHS=(
    "/Applications/Adobe Illustrator 2025/Presets.localized/fr_FR/Scripts/0"
)

# Fonctions d'affichage
error() { echo -e "${RED}Erreur: $1${NC}" >&2; }
info() { echo -e "${YELLOW}Info: $1${NC}"; }
success() { echo -e "${GREEN}$1${NC}"; }

# Nettoyage
cleanup() {
    [ -d "$TEMP_DIR" ] && rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Vérification des outils requis
if ! command -v curl >/dev/null || ! command -v unzip >/dev/null; then
    error "curl et unzip sont requis"
    exit 1
fi

# Vérification de l'existence d'au moins un dossier Scripts
FOUND_DIR=false
for dir in "${SCRIPT_PATHS[@]}"; do
    if [ -d "$dir" ]; then
        FOUND_DIR=true
        break
    fi
done

if [ "$FOUND_DIR" = false ]; then
    error "Aucun dossier Scripts d'Illustrator trouvé"
    exit 1
fi

# Création du dossier temporaire
mkdir -p "$TEMP_DIR" || {
    error "Impossible de créer le dossier temporaire"
    exit 1
}

# Téléchargement de l'archive
info "Téléchargement de l'archive..."
if ! curl -fsSL "$ZIP_URL" -o "$TEMP_DIR/scripts.zip"; then
    error "Échec du téléchargement"
    exit 1
fi

# Vérification du fichier ZIP
if ! file "$TEMP_DIR/scripts.zip" | grep -i "zip archive" >/dev/null; then
    error "Le fichier téléchargé n'est pas une archive ZIP valide"
    exit 1
fi

# Extraction de l'archive
info "Extraction de l'archive..."
if ! unzip -q "$TEMP_DIR/scripts.zip" -d "$TEMP_DIR"; then
    error "Échec de l'extraction"
    exit 1
fi

# Installation des scripts
total_installed=0
for scripts_dir in "${SCRIPT_PATHS[@]}"; do
    if [ ! -d "$scripts_dir" ]; then
        continue
    fi

    info "Installation dans $scripts_dir"
    count=0

    # Copie des fichiers .jsx
    while IFS= read -r -d '' file; do
        if cp "$file" "$scripts_dir/"; then
            ((count++))
            echo "  → $(basename "$file")"
        fi
    done < <(find "$TEMP_DIR" -type f -name "*.jsx" -print0)

    if [ $count -gt 0 ]; then
        ((total_installed+=count))
        success "  ✓ $count scripts installés"
    fi
done

if [ $total_installed -eq 0 ]; then
    error "Aucun script .jsx trouvé dans l'archive"
    exit 1
else
    success "\nInstallation terminée : $total_installed scripts installés"
    info "Redémarrez Illustrator pour utiliser les nouveaux scripts"
fi