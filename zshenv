# Oh My Zsh reads update preferences before loading its custom files.
if [[ -o interactive ]]; then
  source "${ZDOTDIR:-$HOME}/.shell-preferences.zsh"
fi

# Keep machine-specific environment settings outside the shared configuration.
if [[ -f "${ZDOTDIR:-$HOME}/.zshenv.local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshenv.local"
fi
