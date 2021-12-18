local M = {}

function M.config()

    local t = {
        spacecamp = require('plugins.lualine.themes.spacecamp'),
        gruvbox = 'gruvbox_dark',
        enfocado = 'enfocado'
    }

    require('lualine').setup {
        options = {
            theme = t[vim.g.colors_name]
                or t[math.random(1, #t)],
            section_separators = '',
            component_separators = ''
        }
    }

end

return M
