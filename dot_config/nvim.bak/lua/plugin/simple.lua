vim.pack.add({
  "https://github.com/folke/flash.nvim",
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/numToStr/Comment.nvim",
  "https://github.com/FabijanZulj/blame.nvim",
  "https://github.com/catgoose/nvim-colorizer.lua",
  "https://github.com/hedyhli/outline.nvim",
  "https://github.com/amitds1997/remote-nvim.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/aznhe21/actions-preview.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/windwp/nvim-ts-autotag",
})

-- Minimal setup (no config needed)
require("bufferline").setup()
require("Comment").setup()
require("blame").setup()
require("remote-nvim").setup()

-- Colorizer
require("colorizer").setup({ css = true, tailwind = true })

-- Outline
require("outline").setup()
vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

-- Flash
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Trouble
require("trouble").setup({
  focus = true,
  modes = {
    diagnostics = { auto_open = false, auto_close = false },
  },
})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Todo-comments
require("todo-comments").setup({
  signs = true,
  keywords = {
    FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
})
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
vim.keymap.set("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme (Trouble)" })

-- Actions-preview
require("actions-preview").setup({
  telescope = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      height = 0.9,
      prompt_position = "top",
      preview_cutoff = 20,
      preview_height = function(_, _, max_lines)
        return max_lines - 15
      end,
    },
  },
})
vim.keymap.set({ "n", "v" }, "<leader>ca", function() require("actions-preview").code_actions() end, { desc = "Code Actions Preview" })
vim.keymap.set("n", "<leader>cA", function() vim.lsp.buf.code_action({ apply = true }) end, { desc = "Quick Code Action (auto-apply first)" })

-- Autopairs
require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    typescript = { "template_string" },
  },
})
local endwise = require("nvim-autopairs.ts-rule").endwise
require("nvim-autopairs").add_rules({
  endwise("do$", "end", "elixir", nil),
})

-- Autotag
require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
  per_filetype = {
    ["html"] = { enable_close = true },
    ["javascript"] = { enable_close = true },
    ["typescript"] = { enable_close = true },
    ["javascriptreact"] = { enable_close = true },
    ["typescriptreact"] = { enable_close = true },
  },
})
