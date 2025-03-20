#!/bin/bash

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
  echo -e "\033[0;31mWarning: This setup script will overwrite dotfiles that already exist.\033[0m"
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

# Debian packages
if [ "$OS" = "linux" ]; then
  ulimit -n 4096
  sudo apt install build-essential git -y
fi

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ "$OS" = "mac" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
brew install gcc

# Install starship
brew install starship

# Install zsh-vi-mode
if [ "$OS" = "mac" ]; then
  brew install zsh-vi-mode
fi

# Install yazi and dependencies
brew install sevenzip
brew install jq
brew install poppler
brew install fd
brew install ripgrep
brew install fzf
brew install zoxide
brew install imagemagick
brew install ffmpeg
if [ "$OS" = "mac" ]; then
  brew install --cask font-symbols-only-nerd-font
fi
brew install yazi

# Install fnm
brew install fnm

# Install latest lts node.js
fnm install --lts

# Install neovim
brew install neovim

# Install lazyvim
brew install lazygit

# Install stow
brew install stow

# Git clone dotfiles and use gnu stow to create link
cd $HOME
git clone https://github.com/hiback/dotfiles.git
cd dotfiles
stow . --adopt
git restore .

# Install GUI packages for macOS
if [ "$OS" = "mac" ]; then
  # Jetbrains font
  brew install --cask font-jetbrains-mono
  brew install --cask font-jetbrains-mono-nerd-font
  # Aerospace for tiling window managment
  brew install --cask nikitabobko/tap/aerospace
  # Sketchybar for custom menu bar
  brew tap FelixKratz/formulae
  brew install sketchybar
  brew services start sketchybar
  # Kitty terminal emulator
  brew install --cask kitty
fi

# Prompt to source rc file
echo "Setup done! Please run the following command to load configs:"
if [ "$OS" = "mac" ]; then
  echo "source ~/.zshrc"
else
  echo "source ~/.bashrc"
fi
