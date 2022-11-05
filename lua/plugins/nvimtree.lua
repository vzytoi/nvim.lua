local M = {}

local api = require('nvim-tree.api')

M.keymaps = function()
    vim.g.nmap("<leader>e", ":NvimTreeToggle<cr>")
end

M.config = function()

    require "nvim-tree".setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        },
        filters = { custom = { "^.git$" } },
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
        git = {
            ignore = false
        },
        renderer = {
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    none = " ",
                },
            },
        },
        on_attach = function(bufnr)
            vim.g.nmap("v", api.node.open.vertical, { buffer = bufnr })
            vim.g.nmap("s", api.node.open.horizontal, { buffer = bufnr })

            vim.g.nmap("t", function()
                api.node.open.tab()
            end, { buffer = bufnr })

            vim.g.nmap("p", api.node.open.preview, { buffer = bufnr })
            vim.g.nmap("e", api.node.open.edit, { buffer = bufnr })
            vim.g.nmap("o", api.node.open.edit, { buffer = bufnr })
            vim.g.nmap("<cr>", api.node.open.edit, { buffer = bufnr })
        end
    }
end

return M
