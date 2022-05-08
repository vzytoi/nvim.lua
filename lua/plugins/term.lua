local M = {}

M.toggleterm = require("toggleterm")

M.cmds = {
    javascript = {cmd = "node"},
    lua = {cmd = "lua"},
    python = {cmd = "python3"}
}

M.envInit = function()
    local Terminal = require("toggleterm.terminal").Terminal

    for i, v in pairs(M.cmds) do
        M.cmds[i].term = Terminal:new({cmd = v.cmd, hidden = true, direction = "float"})
    end
end

M.envGo = function()
    if M.cmds[vim.bo.filetype] then
        M.cmds[vim.bo.filetype].term:toggle()
    else
        print("Not configured yet.")
    end
end

M.setup = function()
    vim.keymap.set("n", "<leader>t", ":ToggleTerm direction=tab<cr>")
    vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<cr>")
    vim.keymap.set("n", "<leader>ts", ":ToggleTerm direction=horizontal<cr>")
    vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<cr>")
    vim.keymap.set("n", "<leader>ti", M.envGo)
    vim.keymap.set("t", "<c-t>", [[<C-\><C-n>[<C-\><C-n>[<C-\><C-n>:q!<cr>]])
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
    vim.keymap.set("t", "<c-v>", [[<C-\><C-n>"*pA"]])
    vim.g.called_term = true
end

M.config = function()
    M.envInit()

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
        end
    }
end

return M
