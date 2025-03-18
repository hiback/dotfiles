#!/bin/bash

# Stop on error
set -e

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
  sudo apt install build-essential git -y
fi

# Git pull dotfiles and overwrite existing files
cd $HOME
git init
git remote add origin https://github.com/hiback/dotfiles.git
git fetch --all
git reset --hard origin/main

# Install Homebrew
NONINTERACTIVE=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
brew install ffmpeg
brew install sevenzip
brew install jq
brew install poppler
brew install fd
brew install ripgrep
brew install fzf
brew install zoxide
brew install imagemagick
if [ "$OS" = "mac" ]; then
  brew install -cask font-symbols-only-nerd-font
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

# Source rc file
if [ "$OS" = "mac" ]; then
  source ~/.zshrc
else
  source ~/.bashrc
fi
