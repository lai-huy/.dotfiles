return {
    "neovim/nvim-lspconfig",  -- LSP Config plugin
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -- Require the lspconfig plugin
        local lspconfig = require("lspconfig")

        -- Configure clangd for C++
        lspconfig.clangd.setup {
            cmd = { "clangd" },  -- Command to invoke clangd
            filetypes = { "c", "cpp", "objc", "objcpp" }, -- File types for this LSP
            root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json", "compile_flags.txt", "Makefile", "CMakeLists.txt") or vim.loop.os_homedir(),
            single_file_support = true, -- Support single-file projects

            -- Optional: Customize clangd capabilities
            capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),

            -- Optional: Add custom initialization options
            init_options = {
                fallbackFlags = { "-std=c++23" } -- Default flags for clangd
            },

            -- Optional: Define handlers for diagnostics or other custom behavior
            handlers = {
                ["textDocument/publishDiagnostics"] = function(...) 
                    vim.lsp.diagnostic.on_publish_diagnostics(...)
                end,
            },

            -- Optional: Add custom on_attach function
            on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }

                -- Keybindings for LSP
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end
        }
    end,
}
