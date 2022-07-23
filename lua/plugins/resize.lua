local M = {}

function M.setup()

    local k = {
        { "Ì", "h"},
        { "¬", "l"},
        { "È", "k"},
        { "Ï", "j"},
    }

    for i, _ in ipairs(k) do
        vim.keymap.set(
            {"n", "i"},
            k[i][vim.fn.has('macunix') and 1 or 2],
            function()
                M.ResizeSplits(k[i][2])
            end
        )
    end
end

local function reverse(s)
    return (s == "-" and "+" or "-")
end

local function exec(s, d)
    d = d or ""
    vim.api.nvim_command(string.format("%s res%s5", d, s))
end

function M.ResizeSplits(k)
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

return M
