vim.pack.add({ { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v2.x" } })

require("neo-tree").setup()
vim.keymap.set({ "n", "v" }, "<leader>t", "<cmd>NeoTreeRevealToggle<cr>", { desc = "Toggle file explorer" })
