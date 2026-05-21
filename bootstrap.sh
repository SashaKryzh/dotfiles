#!/usr/bin/env bash

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed, skipping."
fi

# Install packages from Brewfile
brew bundle --file="$(dirname "$0")/Brewfile"

# Apply macOS defaults
bash "$(dirname "$0")/.macos"

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed, skipping."
fi

# Link zsh aliases into oh-my-zsh custom folder
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$HOME/.oh-my-zsh/custom"
ln -sfn "$DOTFILES_DIR/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"

# Use sashakryzh git identity for repos under ~/Developer/sashakryzh/
git config --global "includeIf.gitdir:$HOME/Developer/sashakryzh/.path" "$DOTFILES_DIR/gitconfig-sashakryzh"

echo "Done. Restart your terminal (and VS Code) for all changes to take effect."
