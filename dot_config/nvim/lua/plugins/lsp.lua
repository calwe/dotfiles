-- Core LSP configuration and shared infrastructure
-- Language-specific configs are in lua/plugins/lang/
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
  },
  config = function()
    -- Configure diagnostics display
    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
      },
    })

    -- Configure LSP UI borders
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })

    -- Language server configurations
    -- Rust
    vim.lsp.config("rust_analyzer", {
      settings = {
        ['rust-analyzer'] = {
          check = {
            command = 'clippy',
          },
          cargo = {
            allFeatures = true,
          },
          procMacro = {
            enable = true,
          },
          diagnostics = {
            disabled = { "macro-error" }
          },
        },
      },
    })
    vim.lsp.enable("rust_analyzer")

    vim.lsp.config("tailwindcss", {
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            },
          },
        },
      },
    })
    vim.lsp.enable("tailwindcss")
  end,
}
