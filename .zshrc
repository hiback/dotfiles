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

# Starship
eval "$(starship init zsh)"

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# fzf
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

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
if command -v zoxide &> /dev/null; then
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
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Wsl alias
if grep -qi microsoft /proc/sys/kernel/osrelease || [ -n "$WSL_DISTRO_NAME" ]; then
  win() {
    cd /mnt/c/ # Cd to win directory frist to avoid error runing cmd.exe
    cd "/mnt/c/Users/$(cmd.exe /C "echo %USERNAME%" | tr -d "\r")/Documents/_home"
  }
fi

# Kitty ssh solution
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
