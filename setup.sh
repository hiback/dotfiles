#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"

getc() {
  local save_state
  save_state="$(/bin/stty -g)"
  /bin/stty raw -echo
  IFS='' read -r -n 1 -d '' "$@"
  /bin/stty "${save_state}"
}

wait_for_user() {
  local c
  echo
  echo -e "${RED}Warning: This setup script will overwrite dotfiles that already exist.${NC}"
  echo "Press RETURN/ENTER to continue or any other key to abort:"
  getc c
  if ! [[ "${c}" == $'\r' || "${c}" == $'\n' ]]; then
    exit 1
  fi
}

# Stop on error
set -e

# Warning for overwrite
wait_for_user

# Get OS information
case "$(uname)" in
Linux*) OS="linux" ;;
Darwin*) OS="mac" ;;
*)
  echo "Unsupported OS: $(uname)"
  exit 1
  ;;
esac

echo "Running on $OS"

# Apt packages
if [ "$OS" = "linux" ]; then
  ulimit -n 4096
  sudo apt install build-essential git curl -y
fi

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ "$OS" = "mac" ]]; then
  echo >"${HOME}/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"${HOME}/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  # Persisted by the .bashrc shipped in this repo, so only load it for this run
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
brew install gcc

# Install starship
brew install starship

# Install mise for runtime version management
brew install mise

# Install yazi and dependencies
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick

# Install ls alternative
brew install eza

# Install neovim
brew install neovim

# Install tmux
brew install tmux

# Install TUIs for git and docker
brew install lazygit lazydocker

# Install GitHub CLI
brew install gh

# Install system monitor
brew install btop

# Install scratch project manager
brew install try-rs

# Install mkvmerge, required by the vmerge script
brew install mkvtoolnix

# Install stow
brew install stow

# Git clone dotfiles and use gnu stow to create symlink
cd $HOME
git clone https://github.com/hiback/dotfiles.git
cd dotfiles
stow . --adopt
git restore .

# The steps below read the configs that stow just linked into place

# Install tpm, required by tmux.conf
if [ ! -d "${HOME}/.config/tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "${HOME}/.config/tmux/plugins/tpm"
fi

# Install the runtimes pinned in .config/mise/config.toml
mise install

# Install the yazi plugins and flavors pinned in package.toml
ya pkg install

# Bootstrap LazyVim
nvim --headless "+Lazy! sync" +qa

# Install GUI packages for macOS
if [ "$OS" = "mac" ]; then
  # zinit, the zsh plugin manager sourced by .zshrc
  brew install zinit
  # fonts
  brew install --cask font-jetbrains-mono
  brew install --cask font-jetbrains-mono-nerd-font
  # Formulae from non-official taps are installed by fully qualified name, which
  # trusts only that formula rather than the whole tap. Homebrew 6.0.0 refuses to
  # load an untrusted tap, so a short name here would fail.
  # JankyBorders and Sketchybar for the custom menu bar
  brew install FelixKratz/formulae/borders FelixKratz/formulae/sketchybar
  brew install ifstat # For network speed module
  # Yabai for tiling window management, driven by skhd hotkeys
  brew install koekeishiya/formulae/yabai koekeishiya/formulae/skhd
  # macism for input source switching, used by skhdrc and im-select.nvim
  brew install laishulu/homebrew/macism
  # Terminal emulators
  brew install --cask kitty
  brew install --cask ghostty
fi

# Finish prompt
echo
if [ "$OS" = "mac" ]; then
  echo -e "${GREEN}Setup done! Please close this terminal and launch ghostty to continue.${NC}"
  echo
  echo "One manual step is left: yabairc runs 'sudo yabai --load-sa', which needs a"
  echo "passwordless sudo rule. Run 'sudo visudo -f /etc/sudoers.d/yabai' and follow"
  echo "https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)"
else
  echo -e "${GREEN}Setup done! Please reload this terminal to pick up the new environment.${NC}"
fi
