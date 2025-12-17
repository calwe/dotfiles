-- Go language support
return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gowork", "gotmpl" },
    config = function()
      require("go").setup({
        -- Disable Mason since you manage LSP servers externally
        lsp_cfg = false,
        lsp_gofumpt = true,
        lsp_on_attach = true,

        -- Diagnostic settings
        lsp_diag_hdlr = true,
        lsp_diag_virtual_text = { space = 0, prefix = "" },
        lsp_diag_signs = true,
        lsp_diag_update_in_insert = false,

        -- Formatting
        lsp_document_formatting = true,
        lsp_keymaps = false, -- Disable default keymaps if you want to set your own

        -- Code lens
        lsp_codelens = true,

        -- Inlay hints
        lsp_inlay_hints = {
          enable = true,
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_variable_name = true,
          parameter_hints_prefix = " ",
          show_parameter_hints = true,
          other_hints_prefix = "=> ",
        },

        -- Other settings
        luasnip = true,
        trouble = false,
        test_runner = "go",
      })

      -- Set up gopls manually since lsp_cfg is disabled
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
    build = ':lua require("go.install").update_all_sync()',
  },
}
