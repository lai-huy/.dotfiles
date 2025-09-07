return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        vim.opt.termguicolors = true

        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                mode = "buffers",
                style_preset = bufferline.style_preset.default,
                themable = true,
                numbers = "ordinal",
                close_command = "bdelete! %d",
                right_mouse_command = "bdelete! %d",
                left_mouse_command = "buffer %d",
                middle_mouse_command = nil,
                indicator = {
                    style = "icon",
                    icon = "▎",
                },
                buffer_close_icon = "✕",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                max_name_length = 18,
                max_prefix_length = 15,
                truncate_names = true,
                tab_size = 18,
                diagnostics = "nvim_lsp",
                diagnostics_update_in_insert = false,
                diagnostics_update_on_event = true,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local icon = level:match("error") and " "
                        or level:match("warning") and " "
                        or ""
                    return " " .. icon .. count
                end,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "left",
                        separator = true,
                    }
                },
            },
            -- highlights = {
            --     separator = {
            --         fg = { attribute = "bg", highlight = "Normal" },
            --         bg = "none",
            --     },
            --     separator_selected = {
            --         fg = { attribute = "bg", highlight = "Normal" },
            --         bg = "none",
            --     },
            --     separator_visible = {
            --         fg = { attribute = "bg", highlight = "Normal" },
            --         bg = "none",
            --     },
            -- },
        })

        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
        vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)
        vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>", opts)
        vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", opts)
        vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", opts)
    end,
}
