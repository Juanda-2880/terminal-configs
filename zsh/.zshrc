# ~/.zshrc

# ==========================================
# 1. INICIALIZACIÓN BÁSICA Y COMPLECIÓN
# ==========================================
# Inicializar autocompletados (vital para AWS, Docker, Kubernetes)
autoload -Uz compinit && compinit

# CONFIGURACIÓN DE AUTOCOMPLETADO (FZF-TAB)
# (Debe cargar justo después de compinit)
if [ -f "$HOME/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh" ]; then
  source "$HOME/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh"
elif [ -f "$HOME/.zsh/fzf-tab/fzf-tab.plugin.zsh" ]; then
  source "$HOME/.zsh/fzf-tab/fzf-tab.plugin.zsh"
fi

export FZF_DEFAULT_OPTS="--color=fg:#aaaaaa,bg:-1,hl:#ffffff,fg+:#ffffff,bg+:#333333,hl+:#ffffff,pointer:#ffffff,marker:#ffffff,spinner:#ffffff,prompt:#ffffff --pointer='❯' --marker='✓'"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'

# Prompt minimalista
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ==========================================
# 2. HISTORIAL GLOBAL
# ==========================================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# ==========================================
# 3. BÚSQUEDA INTERACTIVA Y POR PREFIJO
# ==========================================
# Búsqueda interactiva con FZF (Ctrl+R)
for fzf_kb in \
  "$HOME/.zsh/plugins/fzf/key-bindings.zsh" \
  /usr/share/fzf/key-bindings.zsh \
  /usr/share/doc/fzf/examples/key-bindings.zsh; do
  if [ -f "$fzf_kb" ]; then
    source "$fzf_kb"
    break
  fi
done

for fzf_comp in \
  "$HOME/.zsh/plugins/fzf/completion.zsh" \
  /usr/share/fzf/completion.zsh \
  /usr/share/doc/fzf/examples/completion.zsh; do
  if [ -f "$fzf_comp" ]; then
    source "$fzf_comp"
    break
  fi
done

# Búsqueda de historial por prefijo (Flecha Arriba/Abajo)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# ==========================================
# 4. ALIAS ÚTILES PARA DEVOPS
# ==========================================
alias ssh="kitty +kitten ssh"
alias eza="eza --icons=always"
alias ls="eza --icons=always"
alias ll="eza -la --icons=always"
alias cat="bat --theme=ansi"

# ==========================================
# 5. AUTOSUGERENCIAS (Texto transparente)
# ==========================================
for asug in \
  "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  if [ -f "$asug" ]; then
    source "$asug"
    break
  fi
done

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#444444"

# Aceptar la sugerencia con Flecha Derecha
bindkey '^[[C' forward-char
# Aceptar la sugerencia palabra por palabra con Alt + Flecha Derecha
bindkey '^[[1;3C' forward-word

# ==========================================
# 6. RESALTADO DE SINTAXIS (SIEMPRE AL FINAL)
# ==========================================
for shl in \
  "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  if [ -f "$shl" ]; then
    source "$shl"
    break
  fi
done

# 1. Comandos correctos
typeset -A ZSH_HIGHLIGHT_STYLES 2>/dev/null || true
ZSH_HIGHLIGHT_STYLES[command]='fg=#ffffff,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#ffffff,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#ffffff,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=#ffffff,bold'

# 2. Comando incorrecto/no reconocido
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#666666'

# 3. Texto normal, rutas y archivos
ZSH_HIGHLIGHT_STYLES[default]='fg=#aaaaaa'
ZSH_HIGHLIGHT_STYLES[path]='fg=#aaaaaa'

# 4. Parámetros
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#888888'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#888888'

# ==========================================
# 7. ARRANQUE AUTOMÁTICO
# ==========================================
if command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

# PATH de binarios de usuario
export PATH="$HOME/.local/bin:$PATH"
