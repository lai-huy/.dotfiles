return {
    'lervag/vimtex',
    config = function()
        vim.g.tex_flavor = 'latex'
        vim.g.vimtex_compiler_method = 'latexmk'
        vim.g.vimtex_view_method = 'general'
        vim.g.vimtex_view_general_viewer = '/usr/bin/zathura'
        vim.g.vimtex_quickfix_mode = 0
        vim.opt.conceallevel = 2
        vim.g.tex_conceal = 'abdmgs'
        vim.g.vimtex_compiler_latexmk = {
            aux_dir = './aux',
            out_dir = './out',
            callback = 1,
            continuous = 1,
            executable = 'latexmk',
            hooks = {},
            options = {
                '-verbose',
                '-file-line-error',
                '-synctex=1',
                '-interaction=nonstopmode',
                '-shell-escape',
            },
        }
    end
}

