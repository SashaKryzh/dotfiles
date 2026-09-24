# Manual setup

After running `./bootstrap.sh` on a fresh Mac:

- Complete [Xcode and simulator setup](ios.md) using `xcodes`.
- Sign in to installed apps as needed.
- Restore the Raycast hotkeys documented in [raycast.md](raycast.md).

Visual Studio Code is installed by Homebrew. Editor settings and extensions are
currently configured manually.

## Accounts and connectivity

Run these steps locally after opening a new terminal. Account credentials and
machine-specific configuration stay outside this repository.

| Tool | Setup | Verify |
| --- | --- | --- |
| GitHub | `gh auth login` | `gh auth status` |
| Codex | `codex login` | `codex login status` |
| Claude Code | `claude auth login` | `claude auth status` |
| Google Cloud | [`gcloud init`](https://docs.cloud.google.com/sdk/docs/initialize); select the intended account and project | `gcloud auth list` and `gcloud config get-value project` |
| 1Password | Sign in to the desktop app. For unattended agent access, complete the `op-agent` setup below. | `op --version`; then `op-agent vault list` after provisioning |
| Tailscale | Open the standalone app, approve the macOS network/system-extension prompts, and sign in to the existing tailnet. See the [macOS guide](https://tailscale.com/docs/install/mac). | Confirm this Mac and the intended peer appear connected in the app; test the usual SSH connection to that peer. |

Google Cloud client libraries can also need Application Default Credentials.
Run `gcloud auth application-default login` only for projects that use them;
CLI sign-in and application credentials are separate.

## App Store Connect

Register the intended App Store Connect API key with `asc`. Keep the `.p8` file
outside Git, readable only by your user. Substitute the profile, key, issuer,
and local file path in this example:

```sh
chmod 600 /path/to/AuthKey.p8
asc auth login --name "PROFILE" --key-id "KEY_ID" --issuer-id "ISSUER_ID" --private-key /path/to/AuthKey.p8
asc auth status --validate
asc apps list
```

Use the default Keychain storage. For an individual API key, use
`--key-type individual` instead of `--issuer-id`; see `asc auth login --help`.

## Agent tooling and 1Password access

Use the existing [agents repository](https://github.com/SashaKryzh/agents), which
owns the shared instructions, skills, and `op-agent` wrapper. On a new main Mac,
clone it to `~/Developer/sashakryzh/agents` and run its local installer:

```sh
cd ~/Developer/sashakryzh/agents
./scripts/install.sh main
```

Use `server` for a server Mac. This installs `op-agent` into `~/.local/bin` and
links the role's agent configuration. Ensure `~/.local/bin` is on the agent
shell's `PATH`; its setup belongs with the agents repository.

Follow that repository's [1Password instructions](https://github.com/SashaKryzh/agents#1password)
to provision a separate service account for this Mac, with read access to the
`Agents` vault, in the local login Keychain. Then verify `op-agent vault list`
and `op-agent item list --vault Agents`. Tokens and Keychain data remain local.
