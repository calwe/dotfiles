vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")

-- Install and load all plugins
-- Plugin/ files will handle setup and keymaps
-- Theme is handled separately in plugin/00-theme.lua.tmpl (needs Go template variables)
vim.pack.add({
  -- Dependencies (no setup needed)
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/ray-x/guihua.lua",
  "https://github.com/rafamadriz/friendly-snippets",

  -- Core plugins (setup in plugin/ files)
  "https://github.com/saghen/blink.cmp",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.x" },
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/folke/flash.nvim",
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v2.x" },
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/numToStr/Comment.nvim",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/stevearc/overseer.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/catgoose/nvim-colorizer.lua",
  "https://github.com/FabijanZulj/blame.nvim",
  { src = "https://github.com/olimorris/codecompanion.nvim", version = "v19.3.1" },
  "https://github.com/hedyhli/outline.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/aznhe21/actions-preview.nvim",
  "https://github.com/amitds1997/remote-nvim.nvim",

  -- Language-specific plugins (setup in lua/config/ or plugin/ files)
  { src = "https://github.com/elixir-tools/elixir-tools.nvim", version = "v0.18.0" },
})

-- Language configs (create lazy-load autocmds)
require("config.lsp")
require("config.typescript")
require("config.go")
require("config.elixir")
