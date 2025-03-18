alias lg="lazygit"
alias vim="nvim"
if grep -qi microsoft /proc/sys/kernel/osrelease || [ -n "$WSL_DISTRO_NAME" ]; then
  win() {
    cd /mnt/c/ # Cd to win directory frist to avoid error runing cmd.exe
    cd "/mnt/c/Users/$(cmd.exe /C "echo %USERNAME%" | tr -d "\r")/Documents/_home"
  }
fi
