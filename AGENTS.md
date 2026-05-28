# Agent guide

Personal macOS dotfiles. `bootstrap.sh` is the single entry point and must stay idempotent.

**Before adding anything during a setup review, read `IGNORE.md`** — it lists brews, apps, and shell env that are intentionally excluded and must not be re-added.

## Conventions

- **Shell config**: put `*.zsh` files at repo root, symlink them from `bootstrap.sh` into `~/.oh-my-zsh/custom/`. Never edit `~/.zshrc` directly.
- **Homebrew packages**: add to `Brewfile`. App Store apps go via `mas "name", id: <id>`.
- **App preferences**: prefer a config file inside an app-named directory (see `cursor/`). If the app has no portable config format, document it as markdown at repo root (see `raycast.md`).
- **Snapshot configs (don't symlink)**: `cursor/settings.json` and `cursor/keybindings.json` are **migration snapshots**, not live config. Cursor writes through symlinks and would clobber the source of truth, so `bootstrap.sh` only `cp`s them when the live file is missing. During setup reviews, diff `cursor/settings.json` and `cursor/keybindings.json` against `~/Library/Application Support/Cursor/User/{settings,keybindings}.json` and surface any new live entries as drift candidates.
- **Manual-only apps**: list them in `APPS.md`.
- **Git identity**: personal repos under `~/Developer/sashakryzh/` use `gitconfig-sashakryzh` via `includeIf` — already wired in `bootstrap.sh`.

## When adding something new

1. If it's installable: extend `Brewfile` or add an idempotent install block to `bootstrap.sh`.
2. If it has config: store the file in the repo and symlink it from `bootstrap.sh`.
3. Add a row to the README file table.
4. Don't introduce a new directory unless there are 2+ related files.
