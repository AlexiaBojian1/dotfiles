# ── Oh-My-Zsh ─────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gentoo"
ZSH_CUSTOM="$HOME/.config/zshThemes"
CASE_SENSITIVE="false"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ── PATH ───────────────────────────────────────────────────────────────
export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH"

# ── Editor ─────────────────────────────────────────────────────────────
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"

# ── Aliases ────────────────────────────────────────────────────────────
alias dotgit='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias off='systemctl poweroff'
alias cdk='cd ~/code'
if command -v eza >/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -l --icons --git --group-directories-first'
  alias la='eza -la --icons --git --group-directories-first'
  alias tree='eza --tree --icons'
else
  alias ls='ls --color=auto'
fi
command -v bat >/dev/null && alias cat='bat --paging=never --style=plain'
alias grep='grep --color=auto'

# ── Fastfetch (show system info on terminal open) ──────────────────────
fastfetch

# ── Completions ────────────────────────────────────────────────────────
autoload -Uz compinit promptinit
compinit

# ── fancy-ctrl-z: press Ctrl+Z to background/foreground a process ──────
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# ── fzf (fuzzy finder: Ctrl+R for history, Ctrl+T for files) ──────────
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# ── zsh-autosuggestions (greyed-out inline suggestion, → to accept) ────
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ── history-substring-search (type prefix, ↑/↓ to cycle matches) ───────
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ── fzf previews with bat / eza ────────────────────────────────────────
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --level=2 {}'"

# ── zoxide (z <part of dir name> to jump, zi for interactive) ─────────
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# ── Cargo (Rust) ───────────────────────────────────────────────────────
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
