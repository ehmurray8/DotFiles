# Herdr Setup

This guide assumes this repository already exists at `~/DotFiles`.

## Dependencies

Install these before continuing:

- Herdr 0.9.0 or newer
- OpenCode
- Bun
- `fzf`
- `jq`
- Neovim
- Git

Optional: `bat` provides richer Sessionizer README previews.

## 1. Link the Herdr config

```sh
mkdir -p "$HOME/.config/herdr"
ln -s "$HOME/DotFiles/herdr/config.toml" "$HOME/.config/herdr/config.toml"
```

## 2. Install Sessionizer

[Sessionizer](https://github.com/andrewchng/herdr-sessionizer) provides the
`sessionizer.open` action bound to `prefix+f`.

```sh
herdr plugin install andrewchng/herdr-sessionizer --yes
```

Link the tracked Sessionizer config:

```sh
SESSIONIZER_CONFIG_DIR="$(herdr plugin config-dir sessionizer)"
mkdir -p "$SESSIONIZER_CONFIG_DIR"
ln -s "$HOME/DotFiles/herdr/sessionizer/config.toml" "$SESSIONIZER_CONFIG_DIR/config.toml"
```

The config scans `~/.config`, `~/projects`, and `~/work`. Create the project
directories if needed:

```sh
mkdir -p "$HOME/projects" "$HOME/work"
```

New project workspaces contain `code`, `ai`, and `terminal` tabs. The `code`
tab starts Neovim, while the other tabs start the default shell.

## 3. Link the workspace picker

Register the local plugin included in this repository:

```sh
herdr plugin link "$HOME/DotFiles/herdr/workspace-picker"
```

It provides these actions:

- `dotfiles.workspace-picker.open-workspace`
- `dotfiles.workspace-picker.open-collapsed`

If the repository moves, refresh the absolute plugin link:

```sh
herdr plugin unlink dotfiles.workspace-picker
herdr plugin link "$HOME/DotFiles/herdr/workspace-picker"
```

## 4. Configure OpenCode

Install OpenCode v2 through mise (the npm backend also works with mise older
than 2026.10.9):

```sh
MISE_NPM_PACKAGE_MANAGER=npm mise use -g npm:@opencode/cli@latest
mise unuse -g --no-prune opencode
```

For future OpenCode updates, use npm so the package's required postinstall
script runs:

```sh
MISE_NPM_PACKAGE_MANAGER=npm mise upgrade npm:@opencode/cli
```

Link the tracked OpenCode v2 configuration. Back up any existing files at these
destinations first:

```sh
mkdir -p "$HOME/.config/opencode"
ln -s "$HOME/DotFiles/opencode/opencode.jsonc" "$HOME/.config/opencode/opencode.jsonc"
ln -s "$HOME/DotFiles/opencode/cli.json" "$HOME/.config/opencode/cli.json"
```

Install Herdr's official OpenCode integration:

```sh
herdr integration install opencode
```

V2 uses `cli.json` instead of V1's `tui.json(c)`. Keep the global configuration
in `opencode.jsonc`; move any old `opencode.json` out of the config directory
after merging its settings.

Herdr creates `~/.config/opencode/plugins/herdr-agent-state.js` and
`~/.config/opencode/herdr-tui-session.js`. The integration
reports OpenCode lifecycle and session information when OpenCode runs inside a
Herdr pane. Restart OpenCode after installing it.

## 5. Reload Herdr

Reload an existing Herdr server:

```sh
herdr server reload-config
```

If Herdr is not running, start it normally:

```sh
herdr
```

## 6. Check the setup

```sh
herdr plugin list
herdr plugin action list --plugin sessionizer
herdr plugin action list --plugin dotfiles.workspace-picker
herdr integration status
```

The plugin list should contain `sessionizer` and
`dotfiles.workspace-picker`. The integration status should report OpenCode as
installed.

Configured keybindings:

| Keys | Action |
| --- | --- |
| `Ctrl-a`, then `f` | Open Sessionizer's project picker |
| `Ctrl-f` | Open the workspace picker |
| `Ctrl-a`, then `s` | Open the compact workspace picker |

## Refresh an outdated integration

Check for outdated Herdr integrations and reinstall the OpenCode integration
when listed:

```sh
herdr integration status --outdated-only
herdr integration install opencode
```

Restart OpenCode after refreshing the integration.
