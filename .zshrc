# Starship
eval "$(starship init zsh)"

# Zsh-vi-mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

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
