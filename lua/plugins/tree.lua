local M = {}

local fn = require('fn')

M.setup = function()
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", fn.opts)
end

M.config = function()
    require "nvim-tree".setup {
        view = {
            side = "right",
            mappings = {
                list = {
                    { key = "v", action = "vsplit" },
                    { key = "s", action = "split" },
                    { key = "e", action = "edit" }
                }
            }
        },
        git = {
            ignore = false
        }
    }
end

return M
