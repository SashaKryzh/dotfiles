#!/usr/bin/env bash

# Install Xcode command line tools if not already installed
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode command line tools..."
  xcode-select --install || true
else
  echo "Xcode command line tools already installed, skipping."
fi

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed, skipping."
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
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
mkdir -p "$HOME/.nvm"
ln -sfn "$DOTFILES_DIR/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
ln -sfn "$DOTFILES_DIR/nvm.zsh" "$HOME/.oh-my-zsh/custom/nvm.zsh"
ln -sfn "$DOTFILES_DIR/bun.zsh" "$HOME/.oh-my-zsh/custom/bun.zsh"

# Use sashakryzh git identity for repos under ~/Developer/sashakryzh/
git config --global "includeIf.gitdir:$HOME/Developer/sashakryzh/.path" "$DOTFILES_DIR/gitconfig-sashakryzh"

# Auto-create upstream tracking on first `git push` for new branches
git config --global push.autoSetupRemote true

# Install Bun if not already installed
if [ ! -x "$HOME/.bun/bin/bun" ] && ! command -v bun &>/dev/null; then
  echo "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
else
  echo "Bun already installed, skipping."
fi

# Link Cursor custom overwrites and install the Vim extension
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_USER_DIR"
ln -sfn "$DOTFILES_DIR/cursor/settings.json" "$CURSOR_USER_DIR/settings.json"
ln -sfn "$DOTFILES_DIR/cursor/keybindings.json" "$CURSOR_USER_DIR/keybindings.json"

if command -v cursor &>/dev/null; then
  while IFS= read -r extension; do
    [ -n "$extension" ] && cursor --install-extension "$extension"
  done <"$DOTFILES_DIR/cursor/extensions.txt"
else
  echo "Cursor CLI not found, skipping extension install."
fi

echo "Done. Restart your terminal and Cursor for all changes to take effect."
