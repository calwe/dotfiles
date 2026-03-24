# Chezmoi Neovim Config - Development Guide

## Chezmoi info

This neovim config is part of a larger dotfiles repository, managed by chezmoi. This means the following:

- The file path for the config is `~/.local/share/chezmoi/dot_config/nvim/`, rather than `~/.config/nvim`.
- Changes must be syncronised with `chezmoi apply` to appear is `~/.config/nvim`.
- Templates can be used by adding the `.tmpl` extension to the end of a file name.
  - Templates use the Go Template syntax.
  - A JSON output of the availible data to be used in the templates can be retrieved with `chezmoi data`.
  - Templates can be executed with `chezmoi execute-template -f <filepath>` to see their output with the current data.
  - Templates should ONLY be used if strictly needed. They decrease readability of files, but can be useful for specific usecases

## File Structure

- `init.lua`: Config entrypoint. Sets leader, loads core modules, registers all plugins via `vim.pack.add()`, loads language configs.
- `ftdetect/`: Filetype detection scripts, a neovim native feature.
- `lua/core/`: General settings that do not relate to a plugin, such as keybinds and default options.
- `lua/helpers/`: Contains a helper for keymaps (used by `lua/core/keymaps.lua`).
- `lua/config/`: Language-specific and LSP configurations, loaded by `init.lua`.
  - `lsp.lua`: Diagnostics UI config + LSPs requiring no/minimal config (yamlls, basedpyright, postgres_lsp, rust_analyzer, tailwindcss, clangd).
  - `elixir.lua`: Elixir tools setup (elixir-tools.nvim).
  - `typescript.lua`: TypeScript/JS tools, eslint, and indentation autocmds. Loaded on FileType.
  - `go.lua`: Go tools and gopls config. Loaded on FileType.
- `plugin/`: Auto-sourced by Neovim on startup. Each file calls `vim.pack.add()` then `require().setup()`.
  - `00-theme.lua.tmpl`: Colorscheme (loaded first via alphabetical ordering).
  - `telescope.lua`: Fuzzy finder with keymaps.
  - `harpoon.lua`: Quick file marks with keymaps.
  - `treesitter.lua`: Syntax highlighting and indentation.
  - `completion.lua`: Blink.cmp completion engine.
  - `neo-tree.lua`: File explorer.
  - `dap.lua`: Debugger adapter protocol (nvim-dap, dap-ui, overseer).
  - `codecompanion.lua`: AI coding assistant.
  - `simple.lua`: Consolidated file for plugins with minimal config (flash, bufferline, Comment, blame, colorizer, outline, remote, trouble, todo-comments, actions-preview, autopairs, autotag).

## Plugin Management

Plugins are managed via the built-in `vim.pack` module (Neovim 0.12+).

- `init.lua` calls `vim.pack.add()` to install and load all plugins.
- `plugin/` files call `vim.pack.add()` (idempotent if already loaded) then `require().setup()`.
- `lua/config/` files for filetype-specific plugins use `FileType` autocmds that call `vim.pack.add()` on first match.
- Plugin state is tracked in `nvim-pack-lock.json` in the config directory (treat as part of config).
- Update plugins with `:lua vim.pack.update()`.
- Check health with `:checkhealth vim.pack`.
- Build steps (telescope-fzf-native `make`, treesitter parser install) are handled inline in their plugin/ files.

## Guidelines

- Complex plugins get their own file in `plugin/`. Simple plugins (empty or minimal setup) are consolidated in `plugin/simple.lua`.
- The current config combines different indentation styles, match whatever the file currently uses, and default to 2 space tabs for new files.
- `require("nvim-lspconfig")` is deprecated. Use `vim.lsp.config/enable` instead.
- `vim.lsp.with()` is deprecated in Neovim 0.12. Move hover/signature config to `vim.diagnostic.config()` float options.
- nvim-treesitter `main` branch removed `nvim-treesitter.configs`. Use `require('nvim-treesitter').setup()` + `vim.treesitter.start()` per filetype instead.
- blink.cmp uses Lua fuzzy matcher (`fuzzy.implementation = "lua"`) since prebuilt Rust binaries require lazy.nvim build hooks.
- LSPs with no/minimal config are grouped in `lua/config/lsp.lua`. LSPs needing significant config get their own file in `lua/config/`.
- Once you have made changes to the config, DO NOT run `chezmoi apply`. Tell the user what you have done, and ask them to apply and test the changes.
