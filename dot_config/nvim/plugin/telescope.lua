vim.pack.add({
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.x" },
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})

-- Build fzf-native synchronously if the shared library doesn't exist
local fzf_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
local lib_name = vim.fn.has("mac") == 1 and "libfzf.dylib" or "libfzf.so"
if vim.fn.filereadable(fzf_path .. "/build/" .. lib_name) == 0 then
  vim.system({ "make" }, { cwd = fzf_path }):wait()
end

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
  },
})

pcall(telescope.load_extension, "fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "Find Definitions" })
vim.keymap.set("n", "<leader>fu", builtin.lsp_references, { desc = "Find References" })
vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "Find Implementations" })
vim.keymap.set("n", "<leader>ft", builtin.lsp_type_definitions, { desc = "Find Type Definitions" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Workspace Symbols" })
