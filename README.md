# dotfiles

Personal setup for a fresh Mac, including iOS development tools.

## Install

```sh
./bootstrap.sh
```

This will:

- Install Xcode command line tools (if missing).
- Install Homebrew (if missing) and packages from `Brewfile`.
- Apply macOS defaults from `.macos`.
- Install Oh My Zsh (if missing).
- Symlink `aliases.zsh`, `nvm.zsh`, and `bun.zsh` into `~/.oh-my-zsh/custom/` so zsh auto-sources them.
- Register a git `includeIf` so repos under `~/Developer/sashakryzh/` use the identity in `gitconfig-sashakryzh`.

The Brewfile includes Visual Studio Code, ChatGPT and Claude desktop apps, plus the separate Codex
and Claude Code CLIs. After installation, authenticate the CLIs with `codex login`
and `claude auth login`.

VS Code is the only editor installed by bootstrap. Its settings and extensions
remain manual; the legacy Cursor snapshots are preserved but not applied.

The Brewfile also installs 1Password, Raycast, Obsidian, Shottr, Google Chrome,
cmux, T3 Code, and `xcodes` with `aria2` for parallel Xcode downloads. Choose and
install your Xcode version separately after bootstrap; see `APPS.md`.

## Files


| File                   | Purpose                                      |
| ---------------------- | -------------------------------------------- |
| `bootstrap.sh`         | Idempotent installer. Safe to re-run.        |
| `Brewfile`             | Homebrew packages, including VS Code, ChatGPT/Claude desktop apps and Codex/Claude Code CLIs. |
| `.macos`               | macOS system defaults.                       |
| `aliases.zsh`          | Shell aliases.                               |
| `nvm.zsh`              | Homebrew NVM shell initialization.           |
| `bun.zsh`              | Bun PATH and completions.                    |
| `gitconfig-sashakryzh` | Git identity override for personal repos.    |
| `cursor/`              | Legacy snapshots; not applied by bootstrap. |
| `raycast.md`           | Raycast hotkeys to re-enter manually.        |
| `APPS.md`              | Manual steps after bootstrap, including Xcode selection. |
| `AGENTS.md`            | Conventions for AI coding agents (CLAUDE.md is a symlink). |
| `IGNORE.md`            | Brews/apps/env intentionally excluded — do not re-add. |
