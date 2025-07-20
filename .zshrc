# ~/.zshrc  — first lines
export SHELL=/bin/zsh
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

# simple coloured prompt: alexia@archlinux:~/dir %
PROMPT='%F{cyan}%n@%m%f:%~ %# '
alias dotgit='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
