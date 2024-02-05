return {
    'itchyny/lightline.vim',
    config = function()
        vim.g.lightline = {
            colorscheme = 'rosepine_moon'
        },
        vim.api.nvim_command('set noshowmode')
    end
}

