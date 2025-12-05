return {
    'aznhe21/actions-preview.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    keys = {
        {
            '<leader>ca',
            function()
                require('actions-preview').code_actions()
            end,
            desc = 'Code Actions Preview',
            mode = { 'n', 'v' },
        },
        {
            '<leader>cA',
            function()
                vim.lsp.buf.code_action({
                    apply = true,
                })
            end,
            desc = 'Quick Code Action (auto-apply first)',
        },
    },
    config = function()
        require('actions-preview').setup({
            telescope = {
                sorting_strategy = 'ascending',
                layout_strategy = 'vertical',
                layout_config = {
                    width = 0.8,
                    height = 0.9,
                    prompt_position = 'top',
                    preview_cutoff = 20,
                    preview_height = function(_, _, max_lines)
                        return max_lines - 15
                    end,
                },
            },
        })
    end,
}
