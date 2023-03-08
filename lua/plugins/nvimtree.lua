local M = {}


M.load = {
    "nvim-tree/nvim-tree.lua",
    -- cmd = "NvimTreeToggle",
    config = function()
        vim.defer_fn(M.config, 0)
    end
}

M.keymaps = function()
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>")
end

M.on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

    vim.keymap.set("n", "v", api.node.open.vertical, opts)
    vim.keymap.set("n", "s", api.node.open.horizontal, opts)
    vim.keymap.set("n", "d", api.fs.remove, opts)
    vim.keymap.set("n", "r", api.fs.rename, opts)
    vim.keymap.set("n", "a", api.fs.create, opts)
    vim.keymap.set("n", "<tab>", api.node.open.preview, opts)
    vim.keymap.set("n", "e", api.node.open.edit, opts)
    vim.keymap.set("n", "o", api.node.open.edit, opts)
    vim.keymap.set("n", "<cr>", api.node.open.edit, opts)
    vim.keymap.set('n', 'C', api.fs.copy.absolute_path, opts)
    vim.keymap.set('n', 'K', api.node.navigate.parent, opts)
end

M.config = function()
    local api = require 'nvim-tree.api'

    require "nvim-tree".setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        },
        filters = { custom = { "^.git$", ".root", ".DS_Store" } },
        view = {
            side = "right",
            hide_root_folder = true,
            mappings = {
                custom_only = true
            }
        },
        git = { ignore = false },
        diagnostics = { enable = true, debounce_delay = 10 },
        renderer = {
            indent_markers = { enable = false },
            icons = { show = { git = false } }
        },
        on_attach = M.on_attach
    }
end

return M
