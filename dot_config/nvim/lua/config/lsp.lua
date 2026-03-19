-- Diagnostics display configuration
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

-- LSPs requiring no/minimal configuration
vim.lsp.enable("yamlls")
vim.lsp.enable("basedpyright")
vim.lsp.enable("postgres_lsp")

-- Rust
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
      diagnostics = {
        disabled = { "macro-error" },
      },
    },
  },
})
vim.lsp.enable("rust_analyzer")

-- Tailwind
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

-- Clangd
vim.lsp.config("clangd", {
  cmd = { "clangd", "--query-driver=**" },
})
vim.lsp.enable("clangd")
