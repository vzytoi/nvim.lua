local M = {}

local function copy(table)

    local ret = {}

    for k, v in pairs(table) do
        ret[k] = v
    end

    return ret

end

local function mergeTables(a, b)

    local ret = copy(a)

    for k, v in pairs(b) do
        ret[k] = v
    end

    return ret

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

function M:config()

    require('options').ColorOpt()
    local hi = require('colors.colors')

    apply_color (
        mergeTables(get_color(hi), hi['all'])
    )

end

return M
