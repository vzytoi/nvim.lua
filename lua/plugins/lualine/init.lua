local M = {}

function M.config()

    local t = {
        spacecamp = require('plugins.lualine.themes.spacecamp')
    }

    local c

    for k, v in pairs(t) do
        if k == vim.g.colors_name then
            c = v
        end
        break
    end

    if not c then
        c = t[math.random(1, #t)][2]
    end

    require('lualine').setup {
        options = {
            theme = c,
            section_separators = '',
            component_separators = ''
        }
    }

end

return M
