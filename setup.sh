#!/bin/sh

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

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
  brew install font-symbols-only-nerd-font
fi
brew install yazi

# Install fnm
brew install fnm

# Install latest lts node.js
fnm install --lts

# Install neovim
brew install neovim

# Install lazyvim
brew install lazyvim

# Source rc file
if [ "$OS" = "mac" ]; then
  source ~/.zshrc
else
  source ~/.bashrc
fi
