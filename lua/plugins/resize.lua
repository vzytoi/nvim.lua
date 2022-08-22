local M = {}

local function reverse(s)
    return (s == "-" and "+" or "-")
end

local function exec(s, d)
    nvim.command(string.format("%s res%s5", d or "", s))
end

local function resize(k)

    if vim.fn.winheight(0) + vim.opt.cmdheight:get()
        + 1 == vim.opt.lines:get() and vim.fn.winwidth(0) ==
        vim.opt.columns:get() then
        return
    end

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
        if wcurr == wcount then
            sl.k = sl.l
            sl.j = sl.h
        else
            sl.k = sl.h
            sl.j = sl.l
        end
        exec(sl[k])
    end

end

M.keymaps = function()

    local keys = {
        h = "Ì",
        l = "¬",
        k = "È",
        j = "Ï"
    }

    for k, v in pairs(keys) do
        vim.g.nmap(v, function()
            resize(k)
        end)
    end

end

return M
