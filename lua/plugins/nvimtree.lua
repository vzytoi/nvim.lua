local M = {}

local api = require 'nvim-tree.api'

M.keymaps = function()
    vim.keymap.set("n", "<leader>e", ":silent NvimTreeToggle<cr>")
end

M.config = function()
    require "nvim-tree".setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        },
        filters = { custom = { "^.git$", ".root", ".DS_Store" } },
        open_on_setup = true,
        view = {
            side = "right",
            hide_root_folder = true,
            mappings = {
                custom_only = false,
                list = {
                    { key = "v", action = "vsplit" },
                    { key = "s", action = "split" },
                    { key = "e", action = "edit" },
                    { key = "K", action = "parent_node" },
                }
            }
        },
        git = { ignore = false },
        diagnostics = { enable = true, debounce_delay = 10 },
        renderer = {
            indent_markers = { enable = false },
            icons = { show = { git = false } }
        },
        on_attach = function(bufnr)
            vim.keymap.set("n", "v", api.node.open.vertical, { buffer = bufnr })
            vim.keymap.set("n", "s", api.node.open.horizontal, { buffer = bufnr })

            vim.keymap.set("n", "t", function()
                api.node.open.tab()
            end, { buffer = bufnr })

            vim.keymap.set("n", "p", api.node.open.preview, { buffer = bufnr })
            vim.keymap.set("n", "e", api.node.open.edit, { buffer = bufnr })
            vim.keymap.set("n", "o", api.node.open.edit, { buffer = bufnr })
            vim.keymap.set("n", "<cr>", api.node.open.edit, { buffer = bufnr })
        end
    }
end

return M
