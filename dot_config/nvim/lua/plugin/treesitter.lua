vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

local parsers = {
  "bash",
  "c",
  "css",
  "elixir",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "rust",
  "typescript",
  "tsx",
  "yaml",
}

require("nvim-treesitter").setup()

vim.defer_fn(function()
  require("nvim-treesitter").install(parsers):wait(300000)
end, 0)

vim.api.nvim_create_autocmd("FileType", {
  pattern = parsers,
  callback = function()
    vim.treesitter.start()
  end,
})
