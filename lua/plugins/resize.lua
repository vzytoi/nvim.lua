local M = {}

local function reverse(s)
    return (s == "-" and "+" or "-")
end

local function exec(s, d)
    vim.api.nvim_command(string.format("%s res%s5", d or "", s))
end

local function resize(k)
    local wcount = vim.fn.winnr("$")
    local wcurr = vim.fn.winnr()

    local sl = {
        h = "-",
        l = "+"
    }

    local s

    if sl[k] ~= nil then
        if wcurr == wcount then
            s = reverse(sl[k])
        else
            s = sl[k]
        end
        exec(s, "vert")
    else
        sl.k = sl.l
        sl.j = sl.h
        exec(sl[k])
    end
end

function M.setup()

    local map = require('mappings').map

    local k = {
        { "Ì", "h" },
        { "¬", "l" },
        { "È", "k" },
        { "Ï", "j" },
    }

    for i, _ in ipairs(k) do
        map({ "n", "i" })(k[i][1], function()
            resize(k[i][2])
        end)
    end
end

return M
