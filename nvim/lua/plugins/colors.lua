return {
    'Mofiqul/vscode.nvim',
    config = function()
        require('vscode').setup({
            disable_background = true
        })
        vim.cmd('colorscheme vscode')
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
}

