local map = require("helpers.keys").map

map("i", "jk", "<esc>")

map("v", "<", "<gv")
map("v", ">", ">gv")

vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search (centered)' })

vim.keymap.set('n', "'", '`', { desc = 'Jump to mark (exact position)' })
