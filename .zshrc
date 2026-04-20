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
alias ls='ls --color=auto'
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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ── Cargo (Rust) ───────────────────────────────────────────────────────
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
