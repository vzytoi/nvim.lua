local M = {}

M.keymaps = function()
    vim.g.nmap("<leader>e", ":NvimTreeToggle<cr>")
end

M.config = function()

    require "nvim-tree".setup {
        respect_buf_cwd = true,
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        },
        open_on_setup = true,
        view = {
            side = "right",
            mappings = {
                custom_only = false,
                list = {
                    { key = "v", action = "vsplit" },
                    { key = "s", action = "split" },
                    { key = "e", action = "edit" },

                }
            }
        },
        git = {
            ignore = false
        }
    }
end

return M
