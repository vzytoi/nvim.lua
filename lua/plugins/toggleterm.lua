local M = {}

M.keymaps = function()
    vim.keymap.set("n", "<leader>t", ":ToggleTerm direction=horizontal<cr>")
    vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<cr>")
    vim.keymap.set("n", "<leader>ts", ":ToggleTerm direction=horizontal<cr>")
    vim.keymap.set("n", "\\\\", ":ToggleTerm direction=horizontal<cr>")
    vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<cr>")
    vim.keymap.set("t", "<c-t>", [[<C-\><C-n>[<C-\><C-n>[<C-\><C-n>:q!<cr>]])
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
end

M.config = function()
    require("toggleterm").setup {
        hide_numbers = true,
        start_in_insert = true,
        close_on_exit = true,
        size = function(term)
            if term.direction == "vertical" then
                return 100
            elseif term.direction == "horizontal" then
                return 20
            end
        end,
        update_focused_file = {
            enable = true,
            update_root = true,
            ignore_list = { "toggleterm", "term" },
        },
    }
end


return M
