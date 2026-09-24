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
brew bundle --file="$(dirname "$0")/Brewfile" || exit 1

# Provision Node through NVM; preserve a usable default on subsequent runs.
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR" || exit 1
NVM_PREFIX="$(brew --prefix nvm)" || exit 1
. "$NVM_PREFIX/nvm.sh" --no-use || exit 1
if nvm version default >/dev/null 2>&1; then
  nvm use default || exit 1
else
  nvm install --lts || exit 1
  nvm alias default "$(nvm current)" || exit 1
fi

# Configure the Android SDK and ARM64 emulator (accepts package SDK licenses).
bash "$(dirname "$0")/android-setup.sh" || exit 1

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
ln -sfn "$DOTFILES_DIR/nvm.zsh" "$HOME/.oh-my-zsh/custom/nvm.zsh"
ln -sfn "$DOTFILES_DIR/bun.zsh" "$HOME/.oh-my-zsh/custom/bun.zsh"
ln -sfn "$DOTFILES_DIR/android.zsh" "$HOME/.oh-my-zsh/custom/android.zsh"

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

echo "Done. Restart your terminal for all changes to take effect."
