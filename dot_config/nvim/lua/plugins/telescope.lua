return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    cmd = 'Telescope',
    keys = {
        {
            '<leader>ff',
            '<cmd>Telescope find_files<cr>',
            desc = 'Find Files',
        },
        {
            '<leader>fg',
            '<cmd>Telescope live_grep<cr>',
            desc = 'Live Grep',
        },
        {
            '<leader>fb',
            '<cmd>Telescope buffers<cr>',
            desc = 'Buffers',
        },
        {
            '<leader>fh',
            '<cmd>Telescope help_tags<cr>',
            desc = 'Help Tags',
        },
        {
            '<leader>fr',
            '<cmd>Telescope oldfiles<cr>',
            desc = 'Recent Files',
        },
                {
            '<leader>fd',
            '<cmd>Telescope lsp_definitions<cr>',
            desc = 'Find Definitions',
        },
        {
            '<leader>fu',
            '<cmd>Telescope lsp_references<cr>',
            desc = 'Find References',
        },
        {
            '<leader>fi',
            '<cmd>Telescope lsp_implementations<cr>',
            desc = 'Find Implementations',
        },
        {
            '<leader>ft',
            '<cmd>Telescope lsp_type_definitions<cr>',
            desc = 'Find Type Definitions',
        },
        {
            '<leader>fs',
            '<cmd>Telescope lsp_document_symbols<cr>',
            desc = 'Find Symbols (Document)',
        },
        {
            '<leader>fS',
            '<cmd>Telescope lsp_workspace_symbols<cr>',
            desc = 'Find Symbols (Workspace)',
        },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = {
                        'rg',
                        '--files',
                        '--hidden',
                        '--glob',
                        '!.git/*',
                    },
                },
            },
        })

        telescope.load_extension('fzf')
    end,
}
