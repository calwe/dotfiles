vim.pack.add({ "https://github.com/rmagatti/auto-session" })

require("auto-session").setup({
  auto_save = true,
  auto_restore = true,
  pre_save_cmds = { "Neotree close" },
  session_lens = {
    load_on_setup = true,
  },
})

vim.keymap.set("n", "<leader>fP", "<cmd>SessionSearch<cr>", { desc = "Sessions" })
