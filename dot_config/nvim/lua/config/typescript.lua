vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  once = true,
  callback = function()
    vim.pack.add({
      "https://github.com/pmizio/typescript-tools.nvim",
      "https://github.com/esmuellert/nvim-eslint",
    })

    require("typescript-tools").setup({
      settings = {
        expose_as_code_action = "all",
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
    })

    -- Set indentation for TypeScript/JavaScript files
    -- Default: 2 spaces, ~/isis/ directory: 4 spaces
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      callback = function()
        local filepath = vim.fn.expand("%:p")
        local home = vim.fn.expand("~")
        local isis_path = home .. "/isis/"

        if vim.startswith(filepath, isis_path) then
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.softtabstop = 4
          vim.opt_local.expandtab = true
        else
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.softtabstop = 2
          vim.opt_local.expandtab = true
        end
      end,
    })
  end,
})
