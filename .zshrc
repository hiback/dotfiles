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

# Alias
alias vim="nvim"
alias lg="lazygit"

# Wsl alias
if grep -qi microsoft /proc/sys/kernel/osrelease || [ -n "$WSL_DISTRO_NAME" ]; then
  win() {
    cd /mnt/c/ # Cd to win directory frist to avoid error runing cmd.exe
    cd "/mnt/c/Users/$(cmd.exe /C "echo %USERNAME%" | tr -d "\r")/Documents/_home"
  }
fi

# Kitty ssh solution
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
