return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup( {
            ensure_installed = { "c", "cpp", "java", "javascript", "lua", "python", "typescript", "vim", "vimdoc" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,

            -- List of parsers to ignore installing (or "all")
            ignore_install = { "latex", "markdown" },

            highlight = {
                enable = true,
                disable = { "latex", "markdown" },
                additional_vim_regex_highlighting = false,
            },

            autotag = {
                enable = true
            }
        })
    end
}

