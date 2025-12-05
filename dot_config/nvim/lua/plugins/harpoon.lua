return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    keys = {
        {
            '<leader>a',
            function()
                require('harpoon'):list():add()
            end,
            desc = 'Harpoon: Add file',
        },
        {
            '<leader>h',
            function()
                local harpoon = require('harpoon')
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = 'Harpoon: Quick menu',
        },
        {
            '<leader>fH',
            '<cmd>Telescope harpoon marks<cr>',
            desc = 'Harpoon: Telescope marks',
        },
        {
            '<leader>1',
            function()
                require('harpoon'):list():select(1)
            end,
            desc = 'Harpoon: File 1',
        },
        {
            '<leader>2',
            function()
                require('harpoon'):list():select(2)
            end,
            desc = 'Harpoon: File 2',
        },
        {
            '<leader>3',
            function()
                require('harpoon'):list():select(3)
            end,
            desc = 'Harpoon: File 3',
        },
        {
            '<leader>4',
            function()
                require('harpoon'):list():select(4)
            end,
            desc = 'Harpoon: File 4',
        },
        {
            '<C-S-P>',
            function()
                require('harpoon'):list():prev()
            end,
            desc = 'Harpoon: Previous',
        },
        {
            '<C-S-N>',
            function()
                require('harpoon'):list():next()
            end,
            desc = 'Harpoon: Next',
        },
    },
    config = function()
        local harpoon = require('harpoon')
        
        harpoon:setup()

        -- Telescope integration
        local conf = require('telescope.config').values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require('telescope.pickers').new({}, {
                prompt_title = 'Harpoon',
                finder = require('telescope.finders').new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set('n', '<leader>fh', function()
            toggle_telescope(harpoon:list())
        end, { desc = 'Harpoon: Telescope UI' })
    end,
}
