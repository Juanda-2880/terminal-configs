#!/usr/bin/env bash
# ==============================================================================
# Script de instalación para Terminal Configs
# Compatible con Arch / Debian / Ubuntu / Fedora
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
MODE="link" # "link" o "copy"

for arg in "$@"; do
  case "$arg" in
    --copy)
      MODE="copy"
      ;;
    --link)
      MODE="link"
      ;;
    -h|--help)
      echo "Uso: ./install.sh [--link | --copy]"
      echo "  --link   Crea enlaces simbólicos a este repositorio (por defecto)."
      echo "  --copy   Copia los archivos a sus destinos en lugar de enlazarlos."
      exit 0
      ;;
  esac
done

echo "=========================================================="
echo "    Instalador de Configuraciones de Terminal (Dotfiles)   "
echo "=========================================================="
echo "Modo: $MODE"
echo "Origen: $SCRIPT_DIR"
echo ""

backup_if_exists() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    # Si es symlink que ya apunta al script, no hace falta backup
    if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$2")" ]; then
      return 0
    fi
    mkdir -p "$BACKUP_DIR"
    echo "  [BACKUP] Moviendo $target -> $BACKUP_DIR/"
    mv "$target" "$BACKUP_DIR/"
  fi
}

deploy_file() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"
  backup_if_exists "$dest" "$src"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    rm -rf "$dest"
  fi

  if [ "$MODE" = "link" ]; then
    ln -sf "$src" "$dest"
    echo "  [LINK] $dest -> $src"
  else
    cp -r "$src" "$dest"
    echo "  [COPY] $src -> $dest"
  fi
}

# 1. Zsh
echo "▶ Configurando ZSH..."
deploy_file "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.zsh/plugins"
for plugin_dir in "$SCRIPT_DIR/zsh/plugins/"*; do
  if [ -d "$plugin_dir" ]; then
    pname="$(basename "$plugin_dir")"
    deploy_file "$plugin_dir" "$HOME/.zsh/plugins/$pname"
  fi
done

# Enlace de compatibilidad para fzf-tab si la configuración lo busca en ~/.zsh/fzf-tab
if [ -d "$SCRIPT_DIR/zsh/plugins/fzf-tab" ]; then
  deploy_file "$SCRIPT_DIR/zsh/plugins/fzf-tab" "$HOME/.zsh/fzf-tab"
fi

# 2. Kitty
echo "▶ Configurando Kitty..."
deploy_file "$SCRIPT_DIR/kitty" "$HOME/.config/kitty"

# 3. Neovim (LazyVim)
echo "▶ Configurando Neovim (Vim)..."
deploy_file "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"

# 4. Starship
echo "▶ Configurando Starship..."
deploy_file "$SCRIPT_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# 5. Fastfetch
echo "▶ Configurando Fastfetch..."
deploy_file "$SCRIPT_DIR/fastfetch" "$HOME/.config/fastfetch"

echo ""
echo "=========================================================="
echo "✔ Configuraciones instaladas con éxito."
if [ -d "$BACKUP_DIR" ]; then
  echo "ℹ Copias de respaldo guardadas en: $BACKUP_DIR"
fi
echo "=========================================================="

echo ""
echo "Recuerda tener instalados los siguientes paquetes en tu sistema:"
echo " - Terminal & Shell: zsh, kitty"
echo " - Editor: neovim (nvim)"
echo " - Herramientas CLI: fzf, eza, bat, starship, fastfetch"
echo " - Tipografía recomendada: JetBrainsMono Nerd Font"
echo ""
echo "Comandos de instalación por distribución:"
echo "  • Arch/EndeavourOS: sudo pacman -S zsh kitty neovim fzf eza bat starship fastfetch ttf-jetbrains-mono-nerd"
echo "  • Ubuntu/Debian:    sudo apt install zsh kitty neovim fzf eza bat fastfetch"
echo "  • Fedora:           sudo dnf install zsh kitty neovim fzf eza bat starship fastfetch jetbrains-mono-fonts-all"
