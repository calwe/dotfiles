return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'TodoTrouble', 'TodoTelescope', 'TodoLocList', 'TodoQuickFix' },
    event = 'BufReadPost',
    keys = {
        {
            ']t',
            function()
                require('todo-comments').jump_next()
            end,
            desc = 'Next todo comment',
        },
        {
            '[t',
            function()
                require('todo-comments').jump_prev()
            end,
            desc = 'Previous todo comment',
        },
        {
            '<leader>xt',
            '<cmd>TodoTrouble<cr>',
            desc = 'Todo (Trouble)',
        },
        {
            '<leader>xT',
            '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>',
            desc = 'Todo/Fix/Fixme (Trouble)',
        },
        {
            '<leader>ft',
            '<cmd>TodoTelescope<cr>',
            desc = 'Todo (Telescope)',
        },
    },
    opts = {
        signs = true,
        keywords = {
            FIX = {
                icon = ' ',
                color = 'error',
                alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
            },
            TODO = { icon = ' ', color = 'info' },
            HACK = { icon = ' ', color = 'warning' },
            WARN = {
                icon = ' ',
                color = 'warning',
                alt = { 'WARNING', 'XXX' },
            },
            PERF = {
                icon = ' ',
                alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' },
            },
            NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
            TEST = {
                icon = '⏲ ',
                color = 'test',
                alt = { 'TESTING', 'PASSED', 'FAILED' },
            },
        },
    },
}
