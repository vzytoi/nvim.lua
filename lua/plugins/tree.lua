local M = {}

local fn = require('fn')

M.autocmds = function()
    vim.api.nvim_create_autocmd('BufEnter', {
        nested = true,
        callback = function()
            if fn.is_last_win() and
                fn.starts_with(vim.fn.bufname(), 'NvimTree')
            then
                fn.close_current_win()
            end
        end,
    })
end

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
