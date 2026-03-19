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

      -- Set indentation for TypeScript/JavaScript files
      -- Default: 2 spaces, ~/isis/ directory: 4 spaces
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function()
          local filepath = vim.fn.expand("%:p")
          local home = vim.fn.expand("~")
          local isis_path = home .. "/isis/"
          local dssg_path = home .. "/dssg/"

          if vim.startswith(filepath, isis_path) 
            -- or vim.startswith(filepath, dssg_path)
          then
            -- Use 4 spaces for files in ~/isis/ and ~/dssg/
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.softtabstop = 4
            vim.opt_local.expandtab = true
          else
            -- Use 2 spaces for all other TypeScript/JavaScript files
            vim.opt_local.tabstop = 2
            vim.opt_local.shiftwidth = 2
            vim.opt_local.softtabstop = 2
            vim.opt_local.expandtab = true
          end
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
