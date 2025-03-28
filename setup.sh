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
  sudo apt install build-essential git zsh -y
  sudo chsh -s $(which zsh) $(whoami)
fi

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ "$OS" = "mac" ]]; then
  echo >"${HOME}/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"${HOME}/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo >"${HOME}/.zprofile"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>"${HOME}/.zprofile"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
brew install gcc

# Install zinit
brew install zinit

# Install starship
brew install starship

# Install yazi and dependencies
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick

# Install fnm
brew install fnm
# Install latest lts node.js
fnm install --lts

# Install neovim
brew install neovim

# Install lazygit
brew install lazygit

# Install stow
brew install stow

# Git clone dotfiles and use gnu stow to create symlink
cd $HOME
git clone https://github.com/hiback/dotfiles.git
cd dotfiles
stow . --adopt
git restore .

# Install GUI packages for macOS
if [ "$OS" = "mac" ]; then
  # fonts
  brew install --cask font-jetbrains-mono
  brew install --cask font-jetbrains-mono-nerd-font
  brew install --cask font-symbols-only-nerd-font
  # JankyBorders
  brew tap FelixKratz/formulae # For JankyBorders and Sketchybar
  brew install borders
  # Sketchybar for custom menu bar
  brew install --cask font-hack-nerd-font
  brew install sketchybar
  brew install ifstat # For network speed module
  # Aerospace for tiling window managment
  brew install --cask nikitabobko/tap/aerospace
  # Kitty terminal emulator
  brew install --cask kitty
fi

# Finish prompt
echo
if [ "$OS" = "mac" ]; then
  echo -e "${GREEN}Setup done! Please close this terminal and launch kitty to continue.${NC}"
else
  echo -e "${GREEN}Setup done! Please reload this terminal to switch to zsh.${NC}"
fi
