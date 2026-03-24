local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("i", "jk", "<esc>")

map("v", "<", "<gv")
map("v", ">", ">gv")

vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search (centered)' })

vim.keymap.set('n', "'", '`', { desc = 'Jump to mark (exact position)' })

vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move to right split" })
