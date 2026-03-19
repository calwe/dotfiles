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

- `init.lua`: Config entrypoint
- `ftdetect/`: Filetype detection scripts, a neovim native feature.
- `lua/core/`: General settings that do not relate to a plugin, such as keybinds and default options.
- `lua/helpers/`: Contains a single helper for setting keys, although it mostly unused (and should not be used in future).
- `lua/plugins/`: Plugins, managed using lazy.lua
- `lua/plugins/lang/`: Language specific plugins. Most languages do not use this folder, and are instead configured in `lua/plugins/lsp.lua`.

## Guidelines

- Plugins should be defined in their own file, unless it directly relates to the other plugin in said file.
- The current config combines different indentation styles, match whatever the file currently uses, and default to 2 space tabs for new files.
- `require("nvim-lspconfig")` is deprecated. Use `vim.lsp.config/enable` instead (as is shown in `lsp.lua`).
- Once you have made changes to the config, DO NOT run `chezmoi apply`. Tell the user what you have done, and ask them to apply and test the changes.
