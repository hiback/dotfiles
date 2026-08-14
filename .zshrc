# Zinit
source $(brew --prefix)/opt/zinit/zinit.zsh
zinit ice blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions
autoload compinit
compinit
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Load custom functions
for f in $HOME/.config/sh/*; do source "$f"; done

# Starship
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Mise
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# fzf
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

# zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# try-rs
if command -v try-rs &> /dev/null; then
  alias try="try-rs"
  source '/Users/hiback/Library/Application Support/try-rs/try-rs.zsh'
fi

# Envs
export EDITOR="nvim"
export PATH="$HOME/.config/scripts:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Alias
alias vim="nvim"
if command -v lazygit &> /dev/null; then
  alias lg="lazygit"
fi
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
