local M = {}

function M.setup()
    local k = {
        "h",
        "l",
        "k",
        "j"
    }

    for i, _ in ipairs(k) do
        vim.keymap.set(
            {"n", "i"},
            string.format("<a-%s>", k[i]),
            function()
                M.ResizeSplits(k[i])
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
