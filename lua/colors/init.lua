local M = {}

function M.config()

    require('options').ColorOpt()

    local opt = {
        'guifg', 'guibg', 'gui', 'guisp', 'cterm'
    }

    local hi = require('colors.colors')

    for name, _ in pairs(hi) do
        if name == vim.g.colors_name then
            M.hi = hi[name]
        end
    end

    for m, _ in pairs(M.hi) do
        vim.cmd(
            string.format("hi clear %s", m)
        )
    end

    for m, _ in pairs(M.hi) do
        local s = string.format('hi %s', m)

        for _, o in pairs(opt) do
            local v = 'none'
            if M.hi[m][o] ~= nil then
                v = M.hi[m][o]
            end
            s = s .. ' ' .. table.concat({o, v}, '=')
        end

        vim.cmd(s)
    end

end

return M.config()
