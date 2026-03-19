return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local config = require("nvim-treesitter.configs")

            config.setup({
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    }
}
