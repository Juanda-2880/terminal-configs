# Terminal Configurations & Dotfiles

Repositorio con las configuraciones completas de terminal y entorno de desarrollo (Zsh, Kitty, Neovim/Vim, Starship, Fastfetch y plugins) para persistencia e instalación rápida ante cambios de distribución o nuevas máquinas.

---

## 📁 Estructura del Repositorio

```text
terminal-configs/
├── zsh/
│   ├── .zshrc                           # Configuración completa de Zsh
│   └── plugins/
│       ├── fzf-tab/                     # Autocompletado interactivo con vistas previas
│       ├── zsh-autosuggestions/         # Sugerencias estilo pez
│       ├── zsh-syntax-highlighting/     # Resaltado de sintaxis en tiempo real
│       └── fzf/                         # Key-bindings y completions de FZF
├── kitty/
│   └── kitty.conf                       # Configuración monocromática y fuente JetBrainsMono
├── nvim/                                # Configuración de Neovim (LazyVim + Lackluster)
│   ├── init.lua
│   ├── lazy-lock.json                   # Versiones bloqueadas de plugins
│   ├── lazyvim.json
│   ├── stylua.toml
│   └── lua/
├── starship/
│   └── starship.toml                    # Configuración del prompt minimalista
├── fastfetch/
│   └── config.jsonc                     # Información del sistema al iniciar terminal
├── install.sh                           # Script para desplegar o enlazar todo automáticamente
└── README.md
```

---

## 🚀 Instalación Rápida

### 1. Clonar el repositorio
```bash
git clone https://github.com/Juanda-2880/terminal-configs.git ~/terminal-configs
cd ~/terminal-configs
```

### 2. Ejecutar el script de instalación
Por defecto, crea enlaces simbólicos (`symlinks`), por lo que cualquier cambio que hagas en el repositorio se reflejará inmediatamente en tu sistema:
```bash
chmod +x install.sh
./install.sh
```

Si prefieres copiar físicamente los archivos sin enlazar:
```bash
./install.sh --copy
```

> **Nota:** El script crea automáticamente una copia de seguridad en `~/.dotfiles_backup_<fecha>` de cualquier archivo o carpeta preexistente antes de reemplazarlo.

---

## 📦 Paquetes Requeridos por Distribución

Para aprovechar al 100% todas las características (iconos, preview con eza, bat, etc.), instala los paquetes según tu distribución:

### Arch Linux / EndeavourOS / Manjaro
```bash
sudo pacman -S zsh kitty neovim fzf eza bat starship fastfetch ttf-jetbrains-mono-nerd
```

### Ubuntu / Debian / Pop!_OS
```bash
sudo apt update
sudo apt install zsh kitty neovim fzf eza bat fastfetch
# Starship (si no está en los repositorios):
curl -sS https://starship.rs/install.sh | sh
```

### Fedora
```bash
sudo dnf install zsh kitty neovim fzf eza bat starship fastfetch jetbrains-mono-fonts-all
```

---

## ⚡ Configuración de Shell por Defecto
Para que Zsh sea tu shell predeterminado:
```bash
chsh -s $(which zsh)
```

## 🛠 Neovim / Plugins
Al abrir `nvim` por primera vez tras la instalación:
- LazyVim detectará `lazy-lock.json` e instalará automáticamente todos los plugins requeridos (Lackluster, Lualine, etc.).
- Para actualizar plugins en cualquier momento: dentro de Neovim escribe `:Lazy update`.