return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>cc",
      "<cmd>CodeCompanionChat Toggle<cr>",
      desc = "Toggle CodeCompanion Chat",
      mode = { "n", "v" },
    },
    {
      "<leader>ci",
      "<cmd>CodeCompanion<cr>",
      desc = "CodeCompanion Inline",
      mode = { "n", "v" },
    },
    {
      "<leader>cp",
      "<cmd>CodeCompanionActions<cr>",
      desc = "CodeCompanion Actions",
      mode = { "n", "v" },
    },
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        acp = {
          opencode = function()
            return require("codecompanion.adapters").extend("opencode", {})
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "opencode",
        },
      },
    })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
