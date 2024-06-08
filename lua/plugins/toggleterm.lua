local M = {}

M.keymaps = function()
    vim.g.nmap("<leader>t", ":ToggleTerm direction=tab<cr>")
    vim.g.nmap("<leader>tf", ":ToggleTerm direction=float<cr>")
    vim.g.nmap("<leader>ts", ":ToggleTerm direction=horizontal<cr>")
    vim.g.nmap("\\\\", ":ToggleTerm direction=horizontal<cr>")
    vim.g.nmap("<leader>tv", ":ToggleTerm direction=vertical<cr>")
    vim.g.tmap("<c-t>", [[<C-\><C-n>[<C-\><C-n>[<C-\><C-n>:q!<cr>]])
    vim.g.tmap("<esc>", [[<C-\><C-n>]])


    vim.keymap.set("n", "<leader>te", function()
        require "tester".open {}
    end)
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
