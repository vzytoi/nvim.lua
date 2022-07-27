local M = {}

M.autocmds = function()
    vim.api.nvim_create_autocmd('BufEnter', {
        nested = true,
        callback = function()
            if vim.g.fn.is_last_win() and
                vim.g.fn.startswith(vim.fn.bufname(), 'NvimTree')
            then
                vim.g.fn.close_current_win()
            end
        end,
    })
end

M.setup = function()
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
