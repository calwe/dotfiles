# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed by **chezmoi**, a dotfile management tool that uses templates and supports multiple machines with different configurations.

## Important Rules for Claude Code

When working in this repository:
- **DO NOT run `chezmoi apply`** - The user will run this themselves when ready
- **DO NOT use `chezmoi edit`** - Edit source files directly in this repository instead
- **When editing config files, edit the source files visible in this repo** (e.g., `dot_config/nvim/lua/plugins/telescope.lua`) rather than the target files in the home directory
- **DO NOT use the question tool to ask "should I proceed with implementation?"** — If the user says to go ahead, just start implementing. The question tool puts the user back into plan mode, which is frustrating. Use the question tool only for genuine design/technical decisions during planning.

## Key Concepts

### Chezmoi Naming Convention

Files in this repository follow chezmoi's special naming convention:
- `dot_` prefix → `.` (e.g., `dot_gitconfig` becomes `.gitconfig`)
- `.tmpl` suffix → Template files processed with Go templates
- `run_once_` prefix → Scripts that run once during `chezmoi apply`
- `run_onchange_` prefix → Scripts that run when their content changes
- `executable_` prefix → Makes the file executable

### Configuration Structure

- **`chezmoi.toml`** - Main chezmoi configuration (Bitwarden integration)
- **`.chezmoidata/packages.yaml`** - Package lists for different distros (currently Arch Linux)
- **`.chezmoiexternal.toml`** - External dependencies fetched by chezmoi (e.g., tmux plugin manager)
- **`dot_gitconfig.tmpl`** - Git config template with hostname-based email configuration

## Common Commands

### Apply Changes to System
```bash
# Preview what would change
chezmoi diff

# Apply all changes
chezmoi apply

# Apply with verbose output
chezmoi apply -v
```

### Editing Files
```bash
# Edit a dotfile (automatically handles chezmoi naming)
chezmoi edit ~/.config/nvim/init.lua

# Edit in the source directory directly
cd ~/.local/share/chezmoi
# Edit files with dot_ prefix, etc.
```

### Testing Templates
```bash
# Execute template and preview output
chezmoi execute-template < dot_gitconfig.tmpl

# See what data is available for templates
chezmoi data
```

### Package Management Script
```bash
# The run_onchange_arch-install-packages.sh.tmpl script automatically:
# - Installs official Arch packages via pacman
# - Installs AUR packages via paru
# - Runs when .chezmoidata/packages.yaml changes
```

### Add New Files
```bash
# Add existing file from home directory
chezmoi add ~/.config/some-app/config

# Add as template
chezmoi add --template ~/.gitconfig
```

## Architecture

### Template Variables

Templates use Go template syntax and have access to:
- `{{ .chezmoi.hostname }}` - Current machine hostname
- `{{ .chezmoi.osRelease.id }}` - OS identifier (e.g., "arch")
- `{{ .packages }}` - Package lists from `.chezmoidata/packages.yaml`

### Machine-Specific Configuration

The repository supports multiple machines:
- **banana** - Personal machine (uses spikywebb@gmail.com)
- **SCLT465** - Work laptop (uses callum.webb@stfc.ac.uk)

Configuration adapts based on hostname detection in templates.

### Application Configurations

Major applications configured:
- **Neovim** - Modern Vim config with lazy.nvim plugin manager (`dot_config/nvim/`)
  - Plugins auto-loaded from `lua/plugins/` directory
  - Uses rose-pine theme
  - LSP configuration via `lsp.lua` and `blink.lua`
- **Niri** - Wayland compositor config (`dot_config/niri/config.kdl.tmpl`)
- **Waybar** - Status bar with modular configuration (`dot_config/waybar/`)
- **Kitty** - Terminal emulator with rose-pine theme
- **tmux** - Terminal multiplexer with TPM (Tmux Plugin Manager)
- **Spicetify** - Spotify theming tool

### Neovim Plugin Structure

Neovim uses lazy.nvim for plugin management:
- Leader key is set to Space
- Plugin specs are auto-loaded from `dot_config/nvim/lua/plugins/`
- Each plugin has its own file (e.g., `telescope.lua`, `lsp.lua`)
- Core configuration in `lua/core/` (options, keymaps, lazy setup)

## Working with This Repository

When modifying dotfiles:
1. Edit files in the chezmoi source directory (`~/.local/share/chezmoi`)
2. Use proper prefixes (`dot_`, `executable_`, etc.)
3. Use `.tmpl` suffix when file needs template variables
4. Test with `chezmoi diff` before applying
5. Commit changes to git and push to remote

When adding packages:
1. Edit `.chezmoidata/packages.yaml`
2. Add to `packages.arch.official` for official repos
3. Add to `packages.arch.aur` for AUR packages
4. The `run_onchange_arch-install-packages.sh.tmpl` script will auto-install on next apply
