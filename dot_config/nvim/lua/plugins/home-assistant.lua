return {
  "myakove/homeassistant-nvim",
  dependencies = {
    "neovim/nvim-lspconfig",          -- Required for LSP
    "nvim-telescope/telescope.nvim",  -- Optional, for entity picker
  },
  event = { "BufRead", "BufNewFile" }, -- Load on file open
  config = function()
    require("homeassistant").setup({
      paths = { "homeassistant/" },
      lsp = {
        enabled = true,
        -- LSP server command (default: homeassistant-lsp --stdio)
        cmd = { "homeassistant-lsp", "--stdio" },
        -- File types to attach LSP to
        filetypes = { "yaml", "yaml.homeassistant", "python", "json" },
        -- LSP server settings
        settings = {
          homeassistant = {
            host = "ws://192.168.1.2:8123/api/websocket",
            token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2ZDUwYmQzYTNhNTE0ZTg1YmRhNTM5NWU4OWI2ZjE1MCIsImlhdCI6MTc2NzUyMDQwNiwiZXhwIjoyMDgyODgwNDA2fQ.lci-iWmN4fXyCtWL2cS-bGjlWpgTOhmUsSN4GE11Xko",
            timeout = 5000,
          },
          cache = {
            enabled = true,
            ttl = 300, -- 5 minutes
          },
          diagnostics = {
            enabled = true,
            debounce = 500,
          },
        },
      },
      -- Optional: UI settings
      ui = {
        dashboard = {
          width = 0.8,
          height = 0.8,
          border = "rounded",
        },
      },
      -- Optional: Custom keymaps (set to false to disable defaults)
      keymaps = {
        dashboard = "<leader>hd",
        picker = "<leader>hp",
        reload_cache = "<leader>hr",
        debug = "<leader>hD",
        edit_dashboard = "<leader>he",
      },
    })
  end,
}
