vim.pack.add({ "https://github.com/chrisgrieser/nvim-origami" })

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

require("origami").setup({
	useLspFoldsWithTreesitterFallback = { enabled = true },
	pauseFoldsOnSearch = true,
	foldtext = { enabled = true, diagnosticsCount = true },
	autoFold = { enabled = true, kinds = { "imports" } },
	foldKeymaps = { setup = true },
})

vim.keymap.set("n", "<leader>zc", "zM", { desc = "Close all folds" })
vim.keymap.set("n", "<leader>zo", "zR", { desc = "Open all folds" })
