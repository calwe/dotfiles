return {
    'norcalli/nvim-colorizer.lua',
    lazy = false,
    config = function()
        require('colorizer').setup({
            '*',  -- Highlight all files
            css = { css = true },  -- Enable all CSS features
        })
    end,
}
