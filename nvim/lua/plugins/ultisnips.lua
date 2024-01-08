return {
    'Sirver/ultisnips',
    config = function()
        vim.g.UltiSnipsExpandTrigger = '<Tab>'
        vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
        vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
        vim.g.UltiSnipsEditSplit = "vertical"
        vim.g.UltiSnipsSnippetDirectories = {'~/.config/nvim/Ultisnips'}
    end
}
