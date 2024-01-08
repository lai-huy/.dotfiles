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
    end
}

