return {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
        local api = require('Comment.api')
        vim.keymap.set('n', '<C-l>', api.toggle.linewise.current)
    end
}

