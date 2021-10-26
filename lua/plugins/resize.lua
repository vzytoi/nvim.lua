local M = {}

function M.setup()

    local map = {
        { '<a-', {}}
    }

    local k = {
        'h', 'l', 'k', 'j'
    }

    for i, _ in ipairs(k) do
        table.insert(map[1][2],
            {k[i] .. '>',
            function()
                M.ResizeWindow(k[i])
            end
        })
    end

    return map

end

function M.ResizeWindow(k)
    local wcount = vim.fn.winnr("$")
    local wcurr = vim.fn.winnr()

    local sl = {}
    sl.h = "-"
    sl.l = "+"

    function Reverse(s)
        return (s == "-" and "+" or "-");
    end

    function Exec(d, s)
        local c = d .. "res " .. s .. "5"
        vim.api.nvim_command(c)
    end

    local s

    if sl[k] ~= nil then
        if wcurr == wcount then
            s = Reverse(sl[k])
        else
            s = sl[k]
        end
        Exec("vert ", s)
    else
        sl.k = sl.l
        sl.j = sl.h
        Exec("", sl[k])
    end
end

return M
