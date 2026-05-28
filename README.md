# dotfiles

Personal macOS setup.

## Install

```sh
./bootstrap.sh
```

This will:

- Install Xcode command line tools (if missing).
- Install Homebrew (if missing) and packages from `Brewfile`.
- Apply macOS defaults from `.macos`.
- Install Oh My Zsh (if missing).
- Symlink `aliases.zsh` and `nvm.zsh` into `~/.oh-my-zsh/custom/` so zsh auto-sources them.
- Register a git `includeIf` so repos under `~/Developer/sashakryzh/` use the identity in `gitconfig-sashakryzh`.
- Seed Cursor `settings.json` / `keybindings.json` from the snapshots in `cursor/` (only if missing) and install the extensions in `cursor/extensions.txt`.

## Files


| File                   | Purpose                                      |
| ---------------------- | -------------------------------------------- |
| `bootstrap.sh`         | Idempotent installer. Safe to re-run.        |
| `Brewfile`             | Homebrew packages and casks.                 |
| `.macos`               | macOS system defaults.                       |
| `aliases.zsh`          | Shell aliases.                               |
| `nvm.zsh`              | Homebrew NVM shell initialization.           |
| `bun.zsh`              | Bun PATH and completions.                    |
| `gitconfig-sashakryzh` | Git identity override for personal repos.    |
| `cursor/`              | Minimal Cursor overrides and extension list. |
| `raycast.md`           | Raycast hotkeys to re-enter manually.        |
| `APPS.md`              | Apps to install manually on a fresh machine. |
| `AGENTS.md`            | Conventions for AI coding agents (CLAUDE.md is a symlink). |
| `IGNORE.md`            | Brews/apps/env intentionally excluded — do not re-add. |


