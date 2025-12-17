-- TypeScript/JavaScript language support
return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      -- typescript-tools specific settings
      settings = {
        -- Specify the TypeScript server path if needed
        -- tsserver_path = nil,

        -- Expose as global for other plugins
        expose_as_code_action = "all",

        -- Configure tsserver preferences
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
    config = function(_, opts)
      require("typescript-tools").setup(opts)

      -- Set 2 space indentation for TypeScript/JavaScript files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.softtabstop = 2
          vim.opt_local.expandtab = true
        end,
      })
    end,
  },
  {
    'esmuellert/nvim-eslint',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = {},
  },
  -- Note: tailwindcss LSP is configured in lsp.lua to avoid duplicate specs
}
