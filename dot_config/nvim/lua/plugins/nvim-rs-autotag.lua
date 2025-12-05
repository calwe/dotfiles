return {
    'windwp/nvim-ts-autotag',
    lazy = false,
    config = function()
        require('nvim-ts-autotag').setup({
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = false,
            },
            per_filetype = {
                ['html'] = {
                    enable_close = true,
                },
                ['javascript'] = {
                    enable_close = true,
                },
                ['typescript'] = {
                    enable_close = true,
                },
                ['javascriptreact'] = {
                    enable_close = true,
                },
                ['typescriptreact'] = {
                    enable_close = true,
                },
            },
        })
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
