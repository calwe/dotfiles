function map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<Leader>t", ":Neotree toggle<CR>")
map("n", "<Leader>l", ":BufferNext<CR>")
map("n", "<Leader>h", ":BufferPrevious<CR>")
