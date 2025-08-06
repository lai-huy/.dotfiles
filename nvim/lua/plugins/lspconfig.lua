return {
    "neovim/nvim-lspconfig",  -- LSP Config plugin
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        -- Setup nvim-cmp
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
                { name = 'path' },
            })
        })

        -- Setup LSP
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local mason = require("mason").setup()
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        
        mason_lspconfig.setup({
            ensure_installed = { "clangd", "ts_ls" },
            automatic_installation = true,
        })

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

        -- Configure LSP servers
        local servers = {
            clangd = {
                cmd = { "clangd", "--query-driver=/home/linuxbrew/.linuxbrew/bin/g++-15" },
                filetypes = { "c", "cpp", "objc", "objcpp" },
                init_options = {
                    fallbackFlags = { "--std=c++23" }
                },
                root_dir = lspconfig.util.root_pattern(
                    ".git",
                    "compile_commands.json",
                    "compile_flags.txt",
                    "Makefile",
                    "CMakeLists.txt"
                ) or vim.loop.os_homedir(),
                capabilities = capabilities,
            },
            ts_ls = {
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                },
                root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
                capabilities = capabilities,
            },
        }

        -- Setup each LSP server
        for server, config in pairs(servers) do
            config.on_attach = function(client, bufnr)
                keybind(bufnr)
            end
            lspconfig[server].setup(config)
        end
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
