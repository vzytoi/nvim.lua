local M = {}
local utils = require('utils')

local function apply(name, args)

    local opt = {
        'guifg', 'guibg', 'gui', 'guisp', 'cterm'
    }

    vim.cmd(
        string.format('hi clear %s', name)
    )

    local s = string.format(
        'hi %s', name
    )

    for _, value in ipairs(opt) do

        local v = args[value] or 'NONE'

        s = table.concat(
            {s, table.concat({value, v}, '=')}, ' '
        )

    end

    vim.cmd(s)

end

local function undeep(v)

    for k, _ in pairs(v[2]) do
        v[2][k] = utils.mergeTables(v[2][k], v[1])
    end

    return v[2]

end

local function sort(hi)

    local o = {}

    for k, _ in pairs(hi) do
        if k == vim.g.colors_name or k == 'all' then
            o = utils.mergeTables(o, hi[k])
        end
    end

    return o

end

function M.config()

    require('options').ColorOpt()

    local o = sort(
        require('colors.colors').setup()
    )

    for k, _ in ipairs(o) do
        print(k)
    end

    for k, _ in pairs(o) do
        if k == '_' then
            o = utils.mergeTables(
                undeep(o[k]), o
            )
        end
    end

    for k, v in pairs(o) do
        if k ~= '_' then
            apply(k, v)
        end
    end

end

return M
