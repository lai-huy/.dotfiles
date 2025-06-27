return {
    "neovim/nvim-lspconfig",  -- LSP Config plugin
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local mason = require("mason").setup()
        local mason_lspconfig = require("mason-lspconfig").setup()
        local lspconfig = require("lspconfig")

        local function keybind(bufnr)
            local opts = { noremap = true, silent = true }
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

        lspconfig.clangd.setup {
            cmd = { "clangd" },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json", "compile_flags.txt", "Makefile", "CMakeLists.txt") or vim.loop.os_homedir(),
            single_file_support = true,
            capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            init_options = {
                fallbackFlags = { "-std=c++23" }
            },

            handlers = {
                ["textDocument/publishDiagnostics"] = function(...) 
                    vim.lsp.diagnostic.on_publish_diagnostics(...)
                end,
            },

            on_attach = function(client, bufnr)
                keybind(bufnr)
            end
        }
        lspconfig.ts_ls.setup {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", },
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
            single_file_support = true,
            capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            handlers = {
                ["textDocument/publishDiagnostics"] = function(...)
                    vim.lsp.diagnostic.on_publish_diagnostics(...)
                end,
            },
            on_attach = function(client, bufnr)
                keybind(bufnr)
            end
        }
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client:supports_method('textDocument/completion') then
                    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
                end
            end,
        })
    end,
}
