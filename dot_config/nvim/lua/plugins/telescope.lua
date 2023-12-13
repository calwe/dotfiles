return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "https://github.com/ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup({})
      end,
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "projects")
    
    vim.keymap.set(
      "n",
      "<leader>fp",
      function() vim.cmd([[Telescope projects]]) end,
      { noremap = true }
    )
  end
}

