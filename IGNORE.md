# Ignore list

Things that exist on the current machine but are **intentionally excluded** from this repo. Do not add them back during a setup review.

## Why

This repo provisions one specific personal setup. Out-of-scope tooling, bundled OS apps, and machine-specific environment are excluded by design.

## Excluded brews

- `cocoapods`
- `colima`
- `docker`
- `docker-compose`
- `gitleaks`
- `kubernetes-cli`
- `watchman`

## Excluded App Store apps

- GarageBand
- iMovie
- Keynote
- Numbers
- Pages
- TestFlight
- uBlock Origin Lite

## Excluded apps (installed and managed outside this repo)

- Falcon
- NetBird
- Okta Verify
- Privileges
- Self Service
- Slack
- Zoom

## Excluded Cursor extensions

- anysphere.remote-ssh
- monokai.theme-monokai-pro-vscode
- redhat.vscode-yaml

## Excluded `~/.zshrc` lines

Anything tied to a specific employer, project, or machine-local path stays in `~/.zshrc` and does not move into this repo. This includes exports, `source` lines, and completions that reference paths outside `$HOME`'s dotfile-managed locations.
