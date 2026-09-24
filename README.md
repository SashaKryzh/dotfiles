# dotfiles

Personal setup for a fresh Mac, including iOS and Android development tools.

## Install

Sign in to the Mac App Store first so Homebrew can install the `mas` apps.

```sh
./bootstrap.sh
```

This will:

- Install Xcode command line tools (if missing).
- Install Homebrew (if missing) and packages from `Brewfile`.
- Install Node LTS through NVM and set it as the default if no usable default exists. Re-runs preserve the existing default.
- Install Android Studio, configure its bundled Java and a shared Android SDK, accept the required SDK licenses, and create an ARM64 Pixel 9 emulator (Apple Silicon).
- Apply macOS defaults from `.macos`.
- Install Oh My Zsh (if missing).
- Symlink `aliases.zsh`, `nvm.zsh`, `bun.zsh`, and `android.zsh` into `~/.oh-my-zsh/custom/` so zsh auto-sources them.
- Register a git `includeIf` so repos under `~/Developer/sashakryzh/` use the identity in `gitconfig-sashakryzh`.

The Brewfile includes Visual Studio Code, ChatGPT and Claude desktop apps, plus the separate Codex
and Claude Code CLIs. It also installs the 1Password, App Store Connect, and Google
Cloud CLIs, plus the standalone Tailscale app. Complete the account setup in
[APPS.md](APPS.md) after bootstrap.

VS Code is the only editor installed by bootstrap. Its settings and extensions
remain manual; the legacy Cursor snapshots are preserved but not applied.

For a project's Node version, use its `.nvmrc` with `nvm install` and `nvm use`.
The bootstrap LTS default is a starting point; upgrades remain an explicit choice.

The Brewfile also installs 1Password, Raycast, Obsidian, Shottr, Google Chrome,
cmux, T3 Code, and `xcodes` with `aria2` for parallel Xcode downloads. Choose and
install your Xcode version separately after bootstrap.

## iOS development

Follow [ios.md](ios.md) to install Xcode through `xcodes`, select the toolchain,
complete first launch, and install and verify an iOS simulator runtime. CocoaPods
is installed by bootstrap for local Expo iOS builds.

## Android development

Run `./bootstrap.sh` to install and configure the tools without the Android Studio setup wizard. See [android.md](android.md) for versions, verification, and emulator commands.

## Files


| File                   | Purpose                                      |
| ---------------------- | -------------------------------------------- |
| `bootstrap.sh`         | Idempotent installer. Safe to re-run.        |
| `Brewfile`             | Homebrew packages, including VS Code, ChatGPT/Claude desktop apps and Codex/Claude Code CLIs. |
| `.macos`               | macOS system defaults.                       |
| `aliases.zsh`          | Shell aliases.                               |
| `nvm.zsh`              | Homebrew NVM shell initialization.           |
| `android.zsh`         | Android SDK paths and Studio bundled Java.   |
| `android-setup.sh`    | Idempotent SDK and Pixel emulator setup.     |
| `android.md`          | Android setup and verification instructions. |
| `ios.md`              | Xcode, CocoaPods, and simulator setup and verification. |
| `bun.zsh`              | Bun PATH and completions.                    |
| `gitconfig-sashakryzh` | Git identity override for personal repos.    |
| `cursor/`              | Legacy snapshots; not applied by bootstrap. |
| `raycast.md`           | Raycast hotkeys to re-enter manually.        |
| `APPS.md`              | Manual account setup, agent tooling, and app preferences. |
| `AGENTS.md`            | Conventions for AI coding agents (CLAUDE.md is a symlink). |
| `IGNORE.md`            | Brews/apps/env intentionally excluded — do not re-add. |
