#!/bin/bash


# Configuration
ZIP_URL="https://raw.githubusercontent.com/louisgavalda/placement/refs/heads/main/scripts.zip"
TEMP_DIR="/tmp/scripts_install_$(date +%s)"
TARGET_SUBFOLDER="0"  # Nom du sous-dossier de destination

# Codes couleur
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Chemins des dossiers Scripts d'Illustrator
SCRIPT_PATHS=(
    "/Applications/Adobe Illustrator 2024/Presets.localized/fr_FR/Scripts/"
    "/Applications/Adobe Illustrator 2025/Presets.localized/fr_FR/Scripts/"
)

error() { echo -e "${RED}Erreur: $1${NC}" >&2; }
info() { echo -e "${YELLOW}Info: $1${NC}"; }
success() { echo -e "${GREEN}$1${NC}"; }

cleanup() {
    [ -d "$TEMP_DIR" ] && rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

if ! command -v curl >/dev/null || ! command -v unzip >/dev/null; then
    error "curl et unzip sont requis"
    exit 1
fi

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

mkdir -p "$TEMP_DIR" || {
    error "Impossible de créer le dossier temporaire"
    exit 1
}

info "Téléchargement de l'archive..."
if ! curl -fsSL "$ZIP_URL" -o "$TEMP_DIR/archive.zip"; then
    error "Échec du téléchargement"
    exit 1
fi

if ! file "$TEMP_DIR/archive.zip" | grep -i "zip archive" >/dev/null; then
    error "Le fichier téléchargé n'est pas une archive ZIP valide"
    exit 1
fi

info "Extraction de l'archive..."
if ! unzip -q "$TEMP_DIR/archive.zip" -d "$TEMP_DIR/extracted"; then
    error "Échec de l'extraction"
    exit 1
fi

total_installed=0
for scripts_dir in "${SCRIPT_PATHS[@]}"; do
    echo scripts_dir
    if [ ! -d "$scripts_dir" ]; then
        continue
    fi

    target_dir="$scripts_dir/$TARGET_SUBFOLDER"
    mkdir -p "$target_dir"

    info "Installation dans $target_dir"

    if cp -R "$TEMP_DIR/extracted/"* "$target_dir/" 2>/dev/null; then
        num_items=$(find "$target_dir" -mindepth 1 | wc -l)
        ((total_installed+=num_items))
        success "  ✓ $num_items éléments installés"
    else
        error "  ✗ Échec de la copie dans $target_dir"
    fi
done

if [ $total_installed -eq 0 ]; then
    error "Aucun fichier installé"
    exit 1
else
    success "\nInstallation terminée : $total_installed éléments installés"
    info "Redémarrez Illustrator pour utiliser les nouveaux scripts"
fi