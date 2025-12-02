return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.lsp.config('postgres_lsp', {})
    end
}
