vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/ray-x/go.nvim" })

    require("go").setup({
      lsp_cfg = false,
      lsp_gofumpt = true,
      lsp_on_attach = true,

      lsp_diag_hdlr = true,
      lsp_diag_virtual_text = { space = 0, prefix = "" },
      lsp_diag_signs = true,
      lsp_diag_update_in_insert = false,

      lsp_document_formatting = true,
      lsp_keymaps = false,

      lsp_codelens = true,

      lsp_inlay_hints = {
        enable = true,
        only_current_line = false,
        only_current_line_autocmd = "CursorHold",
        show_variable_name = true,
        parameter_hints_prefix = " ",
        show_parameter_hints = true,
        other_hints_prefix = "=> ",
      },

      luasnip = true,
      trouble = false,
      test_runner = "go",
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          gofumpt = true,
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
          semanticTokens = true,
        },
      },
    })
    vim.lsp.enable("gopls")
  end,
})
