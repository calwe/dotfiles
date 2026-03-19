# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a chezmoi-managed dotfiles repository for Arch Linux systems. It manages configuration files for Neovim, Niri (Wayland compositor), shell environment, and various other tools. The repository uses Go templates to support multiple machines with different configurations.

**Repository Location**: `/home/callum/.local/share/chezmoi/`

## Chezmoi Architecture

### File Naming Conventions

Chezmoi uses special prefixes to transform file names when applying:

- `dot_` → `.` (creates dotfiles, e.g., `dot_zshrc` → `.zshrc`)
- `.tmpl` suffix → Go template processed before applying
- `run_once_` → Script runs once (tracked via state file)
- `run_onchange_` → Script runs when content hash changes

Examples:
- `dot_config/nvim/init.lua` → `~/.config/nvim/init.lua`
- `dot_zshrc.tmpl` → `~/.zshrc` (template processed)
- `run_onchange_arch-install-packages.sh.tmpl` → Runs when packages.yaml changes

### Template System

Templates use Go's text/template syntax with chezmoi data:

**Available Variables**:
- `.chezmoi.hostname` - Machine hostname (e.g., "banana", "SCLT465")
- `.chezmoi.osRelease.id` - OS identifier (e.g., "arch")
- `.packages` - Custom data from `.chezmoidata/packages.yaml`

**Common Patterns**:
```go
{{- if eq .chezmoi.hostname "banana" }}
# Personal machine config
{{- end }}

{{- if eq .chezmoi.hostname "SCLT465" }}
# Work machine config
{{- end }}

{{ range .packages.arch.official }}{{ . }} {{ end }}
```

### Data Files

**`.chezmoidata/packages.yaml`**: Package definitions for automated installation
- `packages.arch.official` - Pacman packages
- `packages.arch.aur` - AUR packages (installed via paru)

**`.chezmoiexternal.toml`**: External git repositories (e.g., tmux plugin manager)

**`chezmoi.toml`**: Chezmoi configuration (Bitwarden integration enabled)

## Common Development Tasks

### Testing Configuration Changes

**IMPORTANT**: You are already working in the chezmoi source directory. Changes made here ARE the source of truth.

1. Edit files directly in `/home/callum/.local/share/chezmoi/`
2. Apply changes: `chezmoi apply`
3. Preview what would change: `chezmoi diff`
4. Verify template rendering: `chezmoi execute-template < file.tmpl`

### Adding New Packages

1. Edit `.chezmoidata/packages.yaml`
2. Add package to `packages.arch.official` or `packages.arch.aur`
3. The `run_onchange_arch-install-packages.sh.tmpl` script will automatically run on next `chezmoi apply`

### Creating New Dotfiles

1. Add file with appropriate prefix (e.g., `dot_newconfig`)
2. Use `.tmpl` suffix if templating is needed
3. Apply with `chezmoi apply`

### Run Scripts

**`run_once_*`**: One-time setup scripts
- `run_once_install-zsh.sh` - Installs zsh, oh-my-zsh, and starship
- `run_once_systemd-sway.sh` - Systemd service setup

**`run_onchange_*`**: Scripts that re-run when content changes
- `run_onchange_arch-install-packages.sh.tmpl` - Package installation (hash includes packages.yaml)
- `run_onchange_install-rust.sh` - Rustup setup
- `run_onchange_spicetify-install.sh` - Spotify theming setup

## Configuration Structure

### Managed Configurations

**Shell**:
- `dot_zshrc.tmpl` - Zsh configuration with oh-my-zsh and starship
  - Machine-specific environment variables and aliases
  - Work machine (SCLT465) has docker-compose aliases and ISIS paths

**Git**:
- `dot_gitconfig.tmpl` - Git user configuration
  - Email and name vary by hostname (personal vs work)

**Neovim**:
- `dot_config/nvim/` - Full Neovim configuration (see dedicated CLAUDE.md at `/home/callum/.local/share/chezmoi/dot_config/nvim/CLAUDE.md`)
- Lua-based with lazy.nvim plugin manager
- Modular architecture with language-specific configs

**Niri** (Wayland Compositor):
- `dot_config/niri/config.kdl.tmpl` - Niri compositor configuration

**Terminal**:
- `dot_config/kitty/` - Kitty terminal with Rose Pine theme

**Status Bar**:
- `dot_config/waybar/` - Waybar modules and configuration
- Modular JSON configs for battery, CPU, memory, etc.

**Other Tools**:
- `dot_config/tmux/` - tmux configuration
- `dot_config/spicetify/` - Spotify theming (uses marketplace theme)
- `dot_config/systemd/user/` - User systemd services

### System Requirements

**Base System**: Arch Linux

**Required Packages**: Defined in `.chezmoidata/packages.yaml`
- Shell: zsh, starship, fzf
- Editor: neovim
- Wayland: niri, waybar, rofi, mako, swaybg, swaylock, swayidle
- Browsers: chromium, zen-browser-bin
- Development: rustup, typescript-language-server, go, gopls
- Tools: tmux, bitwarden-cli, bluez, brightnessctl, networkmanager

**AUR Helper**: paru (must be installed manually before running package scripts)

## Git Workflow

### Branch Structure

- **Main Branch**: `main` (use for PRs)
- Repository is personal, so direct commits to main are acceptable

### Committing Changes

After making changes to dotfiles:
1. Stage files: `git add <files>`
2. Commit with descriptive message
3. Push to remote: `git push`

No special chezmoi commands are needed for git operations - this is a normal git repository.

## Machine-Specific Behavior

### Hostname: "banana" (Personal Machine)
- Git: Uses personal email (spikywebb@gmail.com)
- No special environment variables

### Hostname: "SCLT465" (Work Machine)
- Git: Uses work email (callum.webb@stfc.ac.uk)
- Zsh:
  - `REPOS_ROOT_DIR=/home/callum/isis`
  - `dci` alias for docker-compose with ISIS orchestration

When editing templates, always check if hostname-specific logic exists before modifying.

## Notes

- This repository does NOT manage the home directory directly - it's a chezmoi source directory
- Changes require `chezmoi apply` to take effect in the actual home directory
- Template syntax errors will cause apply failures - test with `chezmoi execute-template`
- The `.git` directory is managed normally - chezmoi doesn't interfere with version control
- Neovim configuration has its own detailed CLAUDE.md at `dot_config/nvim/CLAUDE.md`
