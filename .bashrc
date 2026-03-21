# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

# Source custom functions
for f in $HOME/.config/sh/*; do source "$f"; done

export EDITOR="nvim"
set -o vi # vi mode

# PATH
export PATH="$PATH:$HOME/.config/scripts"

# alias
alias ls='eza -lh --group-directories-first --icons=auto --time-style="+%y/%m/%d %H:%M"'
alias lsa='ls -a'
alias lsg='ls --group --bytes'
alias lss='eza --group-directories-first --icons=auto'
alias lt='eza --tree --level=2 --long --icons --git --time-style="+%y/%m/%d %H:%M"'
alias lta='lt -a'
alias grep='grep --color=auto'
alias try='try-rs'
alias lg='lazygit'
alias lzd='lazydocker'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# mise
set +h
eval "$(mise activate bash)"

# try-rs integration
source "$HOME/.config/try-rs/try-rs.bash"

# starship
eval "$(starship init bash)"

# fzf
eval "$(fzf --bash)"

# zoxide
eval "$(zoxide init bash)"
alias cd="zd"
zd() {
  if (($# == 0)); then
    builtin cd ~ || return
  elif [[ -d $1 ]]; then
    builtin cd "$1" || return
  else
    if ! z "$@"; then
      echo "Error: Directory not found"
      return 1
    fi
  fi
}
