# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source custom functions
for f in $HOME/.config/bash/*; do source "$f"; done

export EDITOR="nvim"

# PATH
export PATH="$PATH:$HOME/.config/scripts"

# alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias try='try-rs'
alias lg='lazygit'
alias lzd='lazydocker'

# yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# mise
eval "$(mise activate bash)"

# try-rs integration
source "$HOME/.config/try-rs/try-rs.bash"

# starship
eval "$(starship init bash)"
