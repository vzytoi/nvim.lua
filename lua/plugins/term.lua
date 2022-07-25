local M = {}

local cmds = {
    javascript = { cmd = "node" },
    typescript = { cmd = "ts-node" },
    lua = { cmd = "lua" },
    python = { cmd = "python3" }
}

local function envInit()
    local Terminal = require("toggleterm.terminal").Terminal

    for i, v in pairs(M.cmds) do
        cmds[i].term = Terminal:new({ cmd = v.cmd, hidden = true, direction = "float" })
    end

end

local function envGo()
    if M.cmds[vim.bo.filetype] then
        M.cmds[vim.bo.filetype].term:toggle()
    else
        print("Not configured yet.")
    end
end

M.setup = function()

    local map = require('mappings').map

    map()("<leader>t", ":ToggleTerm direction=tab<cr>")
    map()("<leader>tf", ":ToggleTerm direction=float<cr>")
    map()("<leader>ts", ":ToggleTerm direction=horizontal<cr>")
    map()("<leader>tv", ":ToggleTerm direction=vertical<cr>")
    map()("<leader>ti", envGo)
    map("t")("<c-t>", [[<C-\><C-n>[<C-\><C-n>[<C-\><C-n>:q!<cr>]])
    map("t")("<esc>", [[<C-\><C-n>]])
    map("t")("<c-v>", [[<C-\><C-n>"*pA"]])

end

M.config = function()
    envInit()

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
