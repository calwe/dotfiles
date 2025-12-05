-- PostgreSQL language support
return {
  {
    "neovim/nvim-lspconfig",
    ft = { "sql", "pgsql" },
    config = function()
      -- Configure postgres_lsp
      vim.lsp.config('postgres_lsp', {
        -- Add any postgres_lsp specific settings here
        -- filetypes = { "sql", "pgsql" },
        -- root_dir = function(fname)
        --   return vim.fn.getcwd()
        -- end,
      })
    end,
  },
}
