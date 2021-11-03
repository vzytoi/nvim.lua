local M = {}

local function merge_tables(a, b)

    if not vim.tbl_islist(b) then
        return a
    end

    for k, v in pairs(b) do
        a[k] = v
    end

    return a

end

local function apply_color(hi)

    local opt = {
        'guifg', 'guibg', 'gui', 'guisp', 'cterm'
    }

    for k, _ in pairs(hi) do
        vim.cmd(
            string.format("hi clear %s", k)
        )
    end

    for k, _ in pairs(hi) do

        local s = string.format(
            "hi %s", k
        )

        for _, o in pairs(opt) do
            local v = hi[k][o] or "NONE"

            s = table.concat(
                {s, table.concat({o, v}, '=')}, ' '
            )
        end

        vim.cmd(s)

    end

end

local function get_color(table)

    for k, _ in pairs(table) do
        if k == vim.g.colors_name then
            return table[k]
        end
    end

end

function M.config()

    require('options').ColorOpt()
    local hi = require('colors.colors')

    apply_color(
        merge_tables(hi['all'], get_color(hi))
    )

end

return M.config()
