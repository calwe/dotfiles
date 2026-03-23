vim.pack.add({
  "https://github.com/olimorris/codecompanion.nvim",
})

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

vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle CodeCompanion Chat" })
vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion Inline" })
vim.keymap.set({ "n", "v" }, "<leader>cp", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
vim.cmd([[cab cc CodeCompanion]])
